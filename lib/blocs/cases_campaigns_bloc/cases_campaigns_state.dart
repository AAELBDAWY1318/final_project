part of 'cases_campaigns_bloc.dart';

sealed class CasesCampaignsState extends Equatable {
  const CasesCampaignsState();

  @override
  List<Object> get props => [];
}

class CasesCampaignsInitial extends CasesCampaignsState {}

class ChangeCategoryState extends CasesCampaignsState {
  final int newIndex;

  const ChangeCategoryState(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}

class AddCaseWithRequestProcess extends CasesCampaignsState{}
class AddCaseWithRequestSuccess extends CasesCampaignsState{}
class AddCaseWithRequestFailure extends CasesCampaignsState{}

class AddCaseWithoutRequestProcess extends CasesCampaignsState{}
class AddCaseWithoutRequestSuccess extends CasesCampaignsState{}
class AddCaseWithoutRequestFailure extends CasesCampaignsState{}

class DropdownChangeState extends CasesCampaignsState{}

class GetAllCasesProcess extends CasesCampaignsState{}
class GetAllCasesFailure extends CasesCampaignsState{}
class GetAllCasesSuccess extends CasesCampaignsState{
  final List<CaseModel> list ;

  const GetAllCasesSuccess({required this.list});

}

class DeleteCaseProcess extends CasesCampaignsState{}
class DeleteCaseFailure extends CasesCampaignsState{}
class DeleteCaseSuccess extends CasesCampaignsState{}

class SearchInCasesProcess extends CasesCampaignsState{}
class SearchInCasesFailure extends CasesCampaignsState{}
class SearchInCasesSuccess extends CasesCampaignsState{
  final CaseModel caseModel ;

  const SearchInCasesSuccess({required this.caseModel});
}

class AddCampaignProcess extends CasesCampaignsState{}
class AddCampaignSuccess extends CasesCampaignsState{}
class AddCampaignFailure extends CasesCampaignsState{}
class AddCampaignFailureNetwork extends CasesCampaignsState{}

class GetCampaignsProcess extends CasesCampaignsState{}
class GetCampaignsFailure extends CasesCampaignsState{}
class GetCampaignsSuccess extends CasesCampaignsState{
  final List<CampaignModel> list ;

  const GetCampaignsSuccess({required this.list});
}