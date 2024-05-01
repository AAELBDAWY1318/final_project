part of 'cases_campaigns_bloc.dart';

sealed class CasesCampaignsEvent extends Equatable{
  const CasesCampaignsEvent();

  @override
  List<Object> get props => [];
}

class ChangeCategory extends CasesCampaignsEvent {
  final int index ;

  const ChangeCategory({required this.index});

}

class DropdownChange extends CasesCampaignsEvent{}

class AddCaseWithRequest extends CasesCampaignsEvent{
  final CaseModel caseModel;

  const AddCaseWithRequest({required this.caseModel});
}
class AddCaseWithoutRequest extends CasesCampaignsEvent{
  final CaseModel caseModel;

  const AddCaseWithoutRequest({required this.caseModel});
}

class GetAllCasesEvent extends CasesCampaignsEvent{}

class RemoveCaseEvent extends CasesCampaignsEvent{
  final String caseId;

  const RemoveCaseEvent({required this.caseId});
}

class SearchInCasesEvent extends CasesCampaignsEvent{
  final String caseId;

  const SearchInCasesEvent({required this.caseId});
}

class AddCampaignEvent extends CasesCampaignsEvent{
  final CampaignModel campaignModel;

  const AddCampaignEvent({required this.campaignModel});
}

class GetCampaignsEvent extends CasesCampaignsEvent{}

class GetPoorCasesEvent extends CasesCampaignsEvent{}

class GetWidowsCasesEvent extends CasesCampaignsEvent{}

class GetStudentsCasesEvent extends CasesCampaignsEvent{}

class GetDebtorsCasesEvent extends CasesCampaignsEvent{}


