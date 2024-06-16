part of 'ml_bloc.dart';

@immutable
sealed class MlState {}

final class MlInitial extends MlState {}

class IDDetectionProcessing extends MlState{}
class IDDetectionFailure extends MlState{}
class IDDetectionSuccess extends MlState{
  final int prediction ;

  IDDetectionSuccess({required this.prediction});
}