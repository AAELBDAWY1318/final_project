import 'package:complaint_repository/scr/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ComplaintRepository{

  Future<void> setComplaintData (Complaint complaint);

  Future<List<Complaint>> getComplaint();

}