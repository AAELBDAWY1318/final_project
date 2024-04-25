part of 'request_bloc.dart';

sealed class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

final class RequestInitial extends RequestState {}


class AddRequestProcess extends RequestState{}
class AddRequestSuccess extends RequestState{}
class AddRequestFailure extends RequestState{}

class GetRealRequestsProcess extends RequestState{}
class GetRealRequestsSuccess extends RequestState{
  final List<Request> list;

  const GetRealRequestsSuccess({required this.list});
}
class GetRealRequestsFailure extends RequestState{}

class GetFakeRequestsProcess extends RequestState{}
class GetFakeRequestsSuccess extends RequestState{
  final List<Request> list;

  const GetFakeRequestsSuccess({required this.list});
}
class GetFakeRequestsFailure extends RequestState{}

class RefuseRequestProcess extends RequestState{}
class RefuseRequestSuccess extends RequestState{}
class RefuseRequestFailure extends RequestState{}

class AskAboutRequestProcess extends RequestState{}
class AskAboutRequestSuccess extends RequestState{
  final String response;

  const AskAboutRequestSuccess({required this.response});
}
class AskAboutRequestFailure extends RequestState{}




