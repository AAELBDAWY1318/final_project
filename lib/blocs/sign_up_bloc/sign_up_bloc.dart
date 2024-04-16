import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  // define an object from UserRepository that hold the logic of signUp
  final UserRepository _userRepository;

  SignUpBloc({
    // when bloc on create take an object from UserRepository
    required UserRepository userRepository
  }) : _userRepository = userRepository,
        super(SignUpInitial()) {
    // case we read the the event SignUpRequired from UI
    on<SignUpRequired>((event, emit) async {
      // the first take state of process
      emit(SignUpProcess());
      // second try to process the logic
      try {
        // the event hold user, and password
        // send them to signUp method that return MyUser after done process
        // and assign User UID
        MyUser user = await _userRepository.signUp(event.user, event.password);
        // after that we set user data(name , email , UID) to firebase storage
        await _userRepository.setUserData(user);
        // if the try scope done without any problem
        // emit the signUpSuccess state
        emit(SignUpSuccess());
      } on FirebaseAuthException catch (e) {
        // if any error with firebase Auth. emit Failure state
        log(e.toString());
        emit(SignUpFailure(message: e.code));
      } catch (e) {
        // if any other error emit Failure state
        log(e.toString());
        emit(const SignUpFailure());
      }
    });

    on<SendVerificationLink>((event , email) async {
      try{
        await _userRepository.sendVerification();
        emit(SendVerificationSuccess());
      }on FirebaseAuthException catch(e){
        log(e.toString());
        emit(SendVerificationFailure(message: e.code));
      }
    });

  }
}