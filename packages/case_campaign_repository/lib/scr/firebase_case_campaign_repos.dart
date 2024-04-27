import 'dart:developer';
import 'dart:io';

import 'package:case_campaign_repository/scr/case_campaign_repos.dart';
import 'package:case_campaign_repository/scr/models/case_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseCaseCampaignRepository implements CaseCampaignRepository{
  CollectionReference casesCollection = FirebaseFirestore.instance.collection('cases');
  CollectionReference requestsCollection = FirebaseFirestore.instance.collection('requests');
  final storage =
  FirebaseStorage.instanceFor(bucket: "gs://charity-3385e.appspot.com");
  // create collection called requests to hold the help requests
  @override
  Future<void> addCaseWithRequest(CaseModel caseModel) async{
    try{
      // get the request
      var temp = await requestsCollection.doc(caseModel.caseId).get();
      var request = temp.data() as Map<String , dynamic>;
      request['status'] = 'accepted'; // update status
      await requestsCollection.doc(caseModel.caseId).update(request);// set it
      log("change the status successfully");
      //now we will set the new case
      await casesCollection.doc(caseModel.caseId).set(caseModel.toEntity().toDocument());
      log("add the case successfully");
    }catch(e){
      log(e.toString());
    }
  }

  @override
  Future<void> addCaseWithoutRequest(CaseModel caseModel) async {
    File file1 = File(
        caseModel.idImage1); //create file object hold the face of notional id
    File file2 = File(
        caseModel.idImage2); // create file object hold the tail of notional id
    var imageName1 = basename(caseModel.idImage1);
    var imageName2 = basename(caseModel.idImage2);
    Reference imageRef1 = storage.ref('idImages1/$imageName1');
    Reference imageRef2 = storage.ref('idImages2/$imageName2');
    try{
      await imageRef1.putFile(file1); //upload the first image
      await imageRef2.putFile(file2); // upload the second one
      var url1 = await imageRef1.getDownloadURL(); // get url of image1
      var url2 = await imageRef2.getDownloadURL(); //get url of image2
      //edit the case model before add to collection
      caseModel = caseModel.edit(
        idImage1: url1,
        idImage2: url2,
      );
      await casesCollection.doc(caseModel.caseId).set(caseModel.toEntity().toDocument());
      log("add the case successfully");
    }catch(e){
      log(e.toString());
    }
  }

}