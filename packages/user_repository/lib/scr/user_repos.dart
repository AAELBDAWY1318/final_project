import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/scr/models/models.dart';

abstract class UserRepository{
  Stream<User?> get user;

  Future<MyUser> signUp(MyUser myUser , String password);

  Future<void> setUserData(MyUser user);

  Future<void> signIn(String email , String password);

  Future<void> sendVerification();

  Future<void> logOut();

  Future<MyUser> getMyUser(String myUserId);

  Future<void> resetPassword(String email);

}