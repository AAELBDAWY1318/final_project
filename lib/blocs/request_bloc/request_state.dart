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


