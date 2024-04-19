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
