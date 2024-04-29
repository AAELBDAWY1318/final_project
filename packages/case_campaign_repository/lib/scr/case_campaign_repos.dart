
import 'package:case_campaign_repository/case_campaign_repository.dart';

abstract class CaseCampaignRepository {
  Future<void> addCaseWithRequest(CaseModel caseModel);

  Future<void> addCaseWithoutRequest(CaseModel caseModel);

  Future<List<CaseModel>> getAllCases();

  Future<void> removeCase(String caseId);

  Future<CaseModel> searchViaNationalId(String caseId);

  Future<void> addCampaign(CampaignModel campaignModel);

  Future<List<CampaignModel>> getCampaigns();

  Future<List<CaseModel>> getWidowsCases();

  Future<List<CaseModel>> getPoorCases();

  Future<List<CaseModel>> getStudentsCases();

  Future<List<CaseModel>> getDebtorsCases();

}