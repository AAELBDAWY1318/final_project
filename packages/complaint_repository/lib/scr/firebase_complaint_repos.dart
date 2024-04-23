import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:complaint_repository/scr/complaint_repos.dart';
import 'package:complaint_repository/scr/entities/complaint_entity.dart';
import 'package:complaint_repository/scr/models/complaint.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseComplaintRepository implements ComplaintRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Create a CollectionReference called complaint that references the firestore collection
  CollectionReference complaintCollection =
      FirebaseFirestore.instance.collection('complaint');

  @override
  Future<List<Complaint>> getComplaint() async {
    try {
      List<Complaint> list = [];
      await complaintCollection.get().then((value) {
        value.docs.forEach((element) {
          Map<String, dynamic>? data = element.data() as Map<String, dynamic>?;

          if (data != null) {
            Complaint complaint =
                Complaint.fromEntity(ComplaintEntity.fromDocument(data));
            list.add(complaint);
          }
        });
      });
      return list;
    } catch (e) {
      log('Error getting documents: $e');
      return []; // Return an empty list or handle the error according to your application's logic
    }
  }

  @override
  Future<void> setComplaintData(Complaint complaint) async {
    String userId = _firebaseAuth.currentUser!.uid;
    complaint = complaint.edit(userId: userId);
    log(complaint.userId);
    try {
      // call CollectionReference that called complaintCollection
      await complaintCollection
          .doc(complaint
              .userId) // doc function that add new document with the userId as uid
          .set(complaint
              .toEntity()
              .toDocument()); // then set the data in Map format
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
