
import 'package:case_campaign_repository/scr/models/case_model.dart';

abstract class CaseCampaignRepository {
  Future<void> addCaseWithRequest(CaseModel caseModel);
  Future<void> addCaseWithoutRequest(CaseModel caseModel);
}