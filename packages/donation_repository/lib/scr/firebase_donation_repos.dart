import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donation_repository/scr/donation_repos.dart';
import 'package:donation_repository/scr/entities/donation_entity.dart';
import 'package:donation_repository/scr/models/donation_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDonationRepository implements DonationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference donationCollection =
      FirebaseFirestore.instance.collection("donations");
  @override
  Future<void> setDonation(DonationModel donationModel) async {
    String userId = _firebaseAuth.currentUser!.uid;
    donationModel = donationModel.editUserId(userId: userId);
    try {
      await donationCollection.add(
        donationModel.toEntity().toDocument(),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<DonationModel>> getDonationReports() async {
    List<DonationModel> list = [];
    String userId = _firebaseAuth.currentUser!.uid;
    try{
      await donationCollection.get().then((value){
        value.docs.forEach((element) {
          if(element.data() != null){
            DonationEntity entity = DonationEntity.fromDocument(
              element.data() as Map<String , dynamic>,
            );
            DonationModel model = DonationModel.fromEntity(entity);
            if(model.userId == userId){
              list.add(model);
            }
          }
        });
      });
    }catch(e){
      log(e.toString());
    }
    return list;
  }
}
