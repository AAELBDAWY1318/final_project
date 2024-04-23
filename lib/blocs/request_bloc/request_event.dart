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