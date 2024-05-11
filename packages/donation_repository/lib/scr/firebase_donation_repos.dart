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
  CollectionReference campaignsCollection =
      FirebaseFirestore.instance.collection("campaign");
  CollectionReference casesCollection =
      FirebaseFirestore.instance.collection("cases");
  @override
  Future<void> setDonation(DonationModel donationModel) async {
    String userId = _firebaseAuth.currentUser!.uid;
    donationModel = donationModel.editUserId(userId: userId);
    try {
      await donationCollection.add(
        donationModel.toEntity().toDocument(),
      );
      if (donationModel.category == "campaigns") {
        QuerySnapshot querySnapshot = await campaignsCollection
            .where("photo", isEqualTo: donationModel.caseId)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          QueryDocumentSnapshot queryDocumentSnapshot =
              querySnapshot.docs.first;
          Map<String, dynamic> data =
              queryDocumentSnapshot.data() as Map<String, dynamic>;
          double temp = double.parse(data["collectedAmount"]) +
              int.parse(donationModel.donationAmount) -
              double.parse(donationModel.managementCost);
          if (temp <= int.parse(data["allAmount"])) {
            data["collectedAmount"] = temp.toString();
          } else {
            data["collectedAmount"] = data["allAmount"];
          }
          await queryDocumentSnapshot.reference.update(data);
        }
      } else if (donationModel.category.isNotEmpty) {
        DocumentSnapshot documentSnapshot =
            await casesCollection.doc(donationModel.caseId).get();
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          double temp = double.parse(data["getAmount"]) +
              int.parse(donationModel.donationAmount) -
              double.parse(donationModel.managementCost);
          if (temp <= int.parse(data["allAmount"])) {
            data["getAmount"] = temp.toString();
          } else {
            data["getAmount"] = data["allAmount"];
          }
          await documentSnapshot.reference.update(data);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<List<DonationModel>> getDonationReports() async {
    List<DonationModel> list = [];
    String userId = _firebaseAuth.currentUser!.uid;
    try {
      await donationCollection.get().then((value) {
        value.docs.forEach((element) {
          if (element.data() != null) {
            DonationEntity entity = DonationEntity.fromDocument(
              element.data() as Map<String, dynamic>,
            );
            DonationModel model = DonationModel.fromEntity(entity);
            if (model.userId == userId) {
              list.add(model);
            }
          }
        });
      });
    } catch (e) {
      log(e.toString());
    }
    return list;
  }
}
