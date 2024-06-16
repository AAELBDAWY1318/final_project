part of 'ml_bloc.dart';

@immutable
sealed class MlEvent {}

class DetectFakeIdEvent extends MlEvent{
  final File imageFile;

  DetectFakeIdEvent({required this.imageFile});
}
