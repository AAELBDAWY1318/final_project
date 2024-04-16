part of 'sign_up_bloc.dart';
// here the file that hold the states of signUP
//success , process , failure
sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}
// the initial state to send to bloc file
final class SignUpInitial extends SignUpState {}
// state when the sign up done without any error
class SignUpSuccess extends SignUpState {}
// in failure case we must send the error message
class SignUpFailure extends SignUpState {
  final String ? message;

  const SignUpFailure({this.message});
}
// process state
class SignUpProcess extends SignUpState {}

class SendVerificationSuccess extends SignUpState{}

class SendVerificationFailure extends SignUpState{
  final String ? message;

  const SendVerificationFailure({this.message});
}