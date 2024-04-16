part of 'sign_up_bloc.dart';
// sealed class is special kind of class used to implement related options
// in our case used to implement singUp events options
// Equatable used to compare objects
sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}
// create the first event called signUpRequired to take user to sign Up
class SignUpRequired extends SignUpEvent{
  final MyUser user; // MyUsr is the user model hold (UID , email , name)
  final String password; // the user password
  //the constructor of signUp required event take the user and password to complete signUp option
  const SignUpRequired(this.user, this.password);
}

class SendVerificationLink extends SignUpEvent {}