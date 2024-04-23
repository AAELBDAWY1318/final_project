import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:request_repository/scr/models/request_model.dart';
import 'package:request_repository/scr/request_repos.dart';
import 'package:path/path.dart';

class FirebaseRequestRepository implements RequestRepository{
  // create a FirebaseStorage instance for the default bucket
  final storage = FirebaseStorage.instanceFor(bucket: "gs://charity-3385e.appspot.com");
  // create collection called requests to hold the help requests
  CollectionReference requestsCollection = FirebaseFirestore.instance.collection('requests');
  @override
  Future<void> addRequest(Request request) async {
    // the request hold the following
    //1- status: by default is inQueue
    //2-name , 3-phone , 4-description, 5-nationalId , 6-idImage1 , 7-idImage2

    File file1 = File(request.idImage1);//create file object hold the face of notional id
    File file2 = File(request.idImage2); // create file object hold the tail of notional id
    var imageName1 = basename(request.idImage1);
    var imageName2 = basename(request.idImage2);
    Reference imageRef1 = storage.ref('idImages1/$imageName1');
    Reference imageRef2 = storage.ref('idImages2/$imageName2');
    try{
      await imageRef1.putFile(file1);//upload the first image
      await imageRef2.putFile(file2); // upload the second one
      var url1 = await imageRef1.getDownloadURL(); // get url of image1
      var url2 = await imageRef2.getDownloadURL(); //get url of image2
      //edit the request model before add to collection
      //change the image paths from local path to firebase storage path
      request = request.edit(
        idImage1: url1,
        idImage2: url2
      );
      await requestsCollection.doc(request.nationalId).set(
        request.toEntity().toDocument(),
      );
    }catch(e){
      log(e.toString());
    }

  }

}