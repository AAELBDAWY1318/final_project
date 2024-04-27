import 'dart:developer';

import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cases_campaigns_event.dart';
part 'cases_campaigns_state.dart';

class CasesCampaignsBloc extends Bloc<CasesCampaignsEvent, CasesCampaignsState> {
  int index = 0;
  final CaseCampaignRepository caseCampaignRepository;
  CasesCampaignsBloc({required this.caseCampaignRepository}) : super(CasesCampaignsInitial()) {
    on<ChangeCategory>((event, emit) {
      index = event.index;
      log('$index');
      emit(ChangeCategoryState(index));
    });
    on<AddCaseWithRequest>((event, emit) async {
      try{
        emit(AddCaseWithRequestProcess());
        await caseCampaignRepository.addCaseWithRequest(event.caseModel);
        emit(AddCaseWithRequestSuccess());
      }catch(e){
        log(e.toString());
        emit(AddCaseWithRequestFailure());
      }
    });
    on<DropdownChange>((event, emit) {
      emit(DropdownChangeState());
    });
    on<AddCaseWithoutRequest>((event, emit) async {
      try{
        emit(AddCaseWithoutRequestProcess());
        await caseCampaignRepository.addCaseWithoutRequest(event.caseModel);
        emit(AddCaseWithoutRequestSuccess());
      }catch(e){
        log(e.toString());
        emit(AddCaseWithoutRequestFailure());
      }
    });
  }

  // get method to get an object from the current BLoC
  static CasesCampaignsBloc get(BuildContext context) {
    return BlocProvider.of<CasesCampaignsBloc>(context);
  }
}
