part of 'payment_donation_bloc.dart';

sealed class PaymentDonationEvent extends Equatable {
  const PaymentDonationEvent();

  @override
  List<Object> get props => [];
}

class GetPaymentKeyEvent extends PaymentDonationEvent {
  final int amount;
  final String currency, email, phone, firstName, lastName;

  const GetPaymentKeyEvent(
      {required this.amount,
      required this.currency,
      required this.email,
      required this.phone,
      required this.firstName,
      required this.lastName});
}
