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

class GetPoorCasesProcess extends CasesCampaignsState{}
class GetPoorCasesFailure extends CasesCampaignsState{}
class GetPoorCasesSuccess extends CasesCampaignsState{
  final List<CaseModel> list ;

  const GetPoorCasesSuccess({required this.list});

}

class GetWidowsCasesProcess extends CasesCampaignsState{}
class GetWidowsCasesFailure extends CasesCampaignsState{}
class GetWidowsCasesSuccess extends CasesCampaignsState{
  final List<CaseModel> list ;

  const GetWidowsCasesSuccess({required this.list});

}

class GetStudentsCasesProcess extends CasesCampaignsState{}
class GetStudentsCasesFailure extends CasesCampaignsState{}
class GetStudentsCasesSuccess extends CasesCampaignsState{
  final List<CaseModel> list ;

  const GetStudentsCasesSuccess({required this.list});

}

class GetDebtorsCasesProcess extends CasesCampaignsState{}
class GetDebtorsCasesFailure extends CasesCampaignsState{}
class GetDebtorsCasesSuccess extends CasesCampaignsState{
  final List<CaseModel> list ;

  const GetDebtorsCasesSuccess({required this.list});

}

class RemoveCampaignProcess extends CasesCampaignsState{}
class RemoveCampaignSuccess extends CasesCampaignsState{}
class RemoveCampaignFailure extends CasesCampaignsState{}

class EditCampaignProcess extends CasesCampaignsState{}
class EditCampaignSuccess extends CasesCampaignsState{}
class EditCampaignFailure extends CasesCampaignsState{}

class GetCompletedCasesProcess extends CasesCampaignsState{}
class GetCompletedCasesSuccess extends CasesCampaignsState{
  final List<CaseModel> list ;

  const GetCompletedCasesSuccess({required this.list});

}
class GetCompletedCasesFailure extends CasesCampaignsState{}

class GetCampaignFormUrlProcess extends CasesCampaignsState{}
class GetCampaignFormUrlFailure extends CasesCampaignsState{}
class GetCampaignFormUrlSuccess extends CasesCampaignsState{
  final CampaignModel campaignModel;

  const GetCampaignFormUrlSuccess({required this.campaignModel});

}

