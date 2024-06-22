
import 'package:donation_repository/scr/models/donation_model.dart';

abstract class DonationRepository{
  Future<void> setDonation(DonationModel donationModel);

  Future<List<DonationModel>> getDonationReports();

  Future<Map<String , double>> getDataCharts();
}