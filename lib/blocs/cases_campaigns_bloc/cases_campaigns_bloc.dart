import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cases_campaigns_event.dart';
part 'cases_campaigns_state.dart';

class CasesCampaignsBloc extends Bloc<CasesCampaignsEvent, CasesCampaignsState> {
  int index = 0;
  CasesCampaignsBloc() : super(CasesCampaignsInitial()) {
    on<ChangeCategory>((event, emit) {
      index = event.index;
      log('$index');
      emit(ChangeCategoryState(index));
    });
  }


  // get method to get an object from the current BLoC
  static CasesCampaignsBloc get(BuildContext context) {
    return BlocProvider.of<CasesCampaignsBloc>(context);
  }
}
