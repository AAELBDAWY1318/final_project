import 'dart:developer';

import 'package:case_campaign_repository/case_campaign_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    on<GetAllCasesEvent>((event, emit) async {
      try{
        emit(GetAllCasesProcess());
        List<CaseModel> list = await caseCampaignRepository.getAllCases();
        emit(GetAllCasesSuccess(list: list));
      }catch(e){
        log(e.toString());
        emit(GetAllCasesFailure());
      }
    });
    on<RemoveCaseEvent>((event, emit)async {
      try{
        emit(DeleteCaseProcess());
        await caseCampaignRepository.removeCase(event.caseId);
        emit(DeleteCaseSuccess());
      }catch(e){
        log(e.toString());
        emit(DeleteCaseFailure());
      }
    });
    on<SearchInCasesEvent>((event, emit) async {
      try{
        emit(SearchInCasesProcess());
        CaseModel caseModel = await caseCampaignRepository.searchViaNationalId(event.caseId);
        emit(SearchInCasesSuccess(caseModel: caseModel));
      }catch(e){
        log(e.toString());
        emit(SearchInCasesFailure());
      }
    });
    on<AddCampaignEvent>((event, emit)async {
      try{
        emit(AddCampaignProcess());
        await caseCampaignRepository.addCampaign(event.campaignModel);
        emit(AddCampaignSuccess());
      }on FirebaseException catch(e){
        log(e.toString());
        emit(AddCampaignFailureNetwork());
      }catch(e){
        log(e.toString());
        emit(AddCampaignFailure());
      }
    });
    on<GetCampaignsEvent>((event, emit) async {
      try{
        emit(GetCampaignsProcess());
        List<CampaignModel> list = await caseCampaignRepository.getCampaigns();
        emit(GetCampaignsSuccess(list: list));
      }on FirebaseException catch(e){
        log(e.toString());
        emit(GetCampaignsFailure());
      }
    });
  }

  // get method to get an object from the current BLoC
  static CasesCampaignsBloc get(BuildContext context) {
    return BlocProvider.of<CasesCampaignsBloc>(context);
  }
}
