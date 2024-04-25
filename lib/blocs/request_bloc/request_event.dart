part of 'request_bloc.dart';

sealed class RequestEvent extends Equatable{
  const RequestEvent();

  @override
  List<Object> get props => [];
}

class AddRequestRequired extends RequestEvent{
  final Request request;

  const AddRequestRequired({required this.request});
}

class GetRealRequests extends RequestEvent{}

class GetFakeRequest extends RequestEvent{}

class RefuseRequest extends RequestEvent{
  final Request request;

  const RefuseRequest({required this.request});
}

class AskAboutRequest extends RequestEvent{
  final String nationalId;

  const AskAboutRequest({required this.nationalId});

}