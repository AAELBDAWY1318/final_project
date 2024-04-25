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
    on<GetRealRequests>((event, emit) async{
      try{
        emit(GetRealRequestsProcess());
        List<Request> requests = await requestRepository.getRealRequest();
        emit(GetRealRequestsSuccess(list: requests));
      }catch(e){
        log(e.toString());
        emit(GetRealRequestsFailure());
      }
    });
    on<GetFakeRequest>((event, emit) async{
      try{
        emit(GetFakeRequestsProcess());
        List<Request> requests = await requestRepository.getFakeRequest();
        emit(GetFakeRequestsSuccess(list: requests));
      }catch(e){
        log(e.toString());
        emit(GetFakeRequestsFailure());
      }
    });
    on<RefuseRequest>((event, emit) async{
      try{
        emit(RefuseRequestProcess());
        await requestRepository.updateRequest(event.request);
        emit(RefuseRequestSuccess());
      }catch(e){
        log(e.toString());
        emit(RefuseRequestFailure());
      }
    });
    on<AskAboutRequest>((event, emit) async{
      try{
        emit(AskAboutRequestProcess());
        var response = await requestRepository.getRequestStatus(event.nationalId);
        emit(AskAboutRequestSuccess(response: response));
      }catch(e){
        log(e.toString());
        emit(AskAboutRequestFailure());
      }
    });
  }
}
