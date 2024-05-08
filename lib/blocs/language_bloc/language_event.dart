part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {
  final String languageCode;
  final AppLocale appLocale;
  ChangeLanguageEvent(this.appLocale, {required this.languageCode});
}
