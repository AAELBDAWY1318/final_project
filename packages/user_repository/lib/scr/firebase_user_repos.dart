import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/scr/user_repos.dart';

import 'entities/user_entity.dart';
import 'models/user.dart';

class FirebaseUserRepos implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepos({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email,
          password: password
      );

      myUser = myUser.copyWith(
          userId: user.user!.uid
      );

      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection
          .doc(myUser.userId)
          .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> sendVerification() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        log('Verification email sent to ${user.email}');
      } else {
        log('User is already verified or no user signed in.');
      }
    } catch (e) {
      log('Failed to send verification email: $e');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Future<MyUser> getMyUser(String myUserId) async {
    try {
      log(myUserId);
      final docSnapshot = await usersCollection.doc(myUserId).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data();
        if (userData != null) {
          // Safely handle null values when creating MyUserEntity
          final myUserEntity = MyUserEntity.fromDocument(userData);
          // Safely handle null values when creating MyUser
          return MyUser.fromEntity(myUserEntity);
        } else {
          throw Exception("User data is null");
        }
      } else {
        throw Exception("User document does not exist");
      }
    } catch (e) {
      log('error : ${e.toString()}');
      rethrow;
    }
  }

}