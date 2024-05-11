part of 'payment_donations_bloc.dart';

sealed class PaymentDonationsEvent extends Equatable {
  const PaymentDonationsEvent();
  @override
  List<Object> get props => [];
}

class GetAuthTokenEvent extends PaymentDonationsEvent {}

class GetPaymentKeyEvent extends PaymentDonationsEvent {
  final String firstName, lastName, email, phone;
  final int amount;
  const GetPaymentKeyEvent(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phone,
      required this.amount});
}

class SetDonationReport extends PaymentDonationsEvent{
  final DonationModel donationModel;

  const SetDonationReport({required this.donationModel});
}

class GetDonationsEvent extends PaymentDonationsEvent{}
