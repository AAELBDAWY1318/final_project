import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:charity/ml_model/ml_model.dart';
import 'package:meta/meta.dart';

part 'ml_event.dart';
part 'ml_state.dart';

class MlBloc extends Bloc<MlEvent, MlState> {
  final MLLogic mlLogic;
  MlBloc({required this.mlLogic}) : super(MlInitial()) {
    mlLogic.init(); // call init to initialize the dio
    on<DetectFakeIdEvent>((event, emit)async{
      try{
        emit(IDDetectionProcessing());
        Map<String, dynamic> data = await mlLogic.postImage(imageFile: event.imageFile);
        emit(IDDetectionSuccess(prediction: data['prediction']));
      }catch(e){
        log(e.toString());
        emit(IDDetectionFailure());
      }
    });
  }
}
