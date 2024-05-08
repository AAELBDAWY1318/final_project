part of 'language_bloc.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

class ChangeLanguageProcess extends LanguageState{}
class ChangeLanguageSuccess extends LanguageState{
  final String languageCode;

  ChangeLanguageSuccess({required this.languageCode});
}
class ChangeLanguageFailure extends LanguageState{}
