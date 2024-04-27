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

