import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:charity/app_locale/app_locale.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<ChangeLanguageEvent>((event, emit) async {
      try {
        emit(ChangeLanguageProcess());
        await event.appLocale.setLanguage(event.languageCode);
        emit(ChangeLanguageSuccess(languageCode: event.languageCode));
      } catch (e) {
        log(e.toString());
        emit(ChangeLanguageFailure());
      }
    });
  }
}
