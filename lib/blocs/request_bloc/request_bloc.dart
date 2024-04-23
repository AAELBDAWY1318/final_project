import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:request_repository/request_repository.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  RequestRepository requestRepository ;
  RequestBloc({required this.requestRepository}) : super(RequestInitial()) {
    on<AddRequestRequired>((event, emit) async{
     try{
       emit(AddRequestProcess());
       await requestRepository.addRequest(event.request);
       emit(AddRequestSuccess());
     }catch(e){
       log(e.toString());
       emit(AddRequestFailure());
     }
    });
  }
}
