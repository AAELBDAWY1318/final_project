import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:complaint_repository/complaint_repository.dart';
import 'package:equatable/equatable.dart';

part 'complaint_event.dart';
part 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintRepository complaintRepository ;
  ComplaintBloc({required this.complaintRepository}) : super(ComplaintInitial()) {
    on<AddComplaint>((event , emit) async{
      try{
        emit(AddComplaintProcess());
        log('${event.complaint }');
        await complaintRepository.setComplaintData(event.complaint);
        emit(AddComplaintSuccess());
      }catch(e){
        log(e.toString());
        emit(AddComplaintFailure());
      }
    });
  }
}
