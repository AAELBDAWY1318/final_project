import 'package:complaint_repository/scr/models/models.dart';

abstract class ComplaintRepository{

  Future<void> setComplaintData (Complaint complaint);

  Future<List<Complaint>> getComplaint();

}