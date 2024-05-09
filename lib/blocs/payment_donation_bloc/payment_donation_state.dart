part of 'payment_donation_bloc.dart';

sealed class PaymentDonationState extends Equatable {
  const PaymentDonationState();

  @override
  List<Object> get props => [];
}

class PaymentDonationInitial extends PaymentDonationState {}

class GetPaymentKeyProcess extends PaymentDonationState{}
class GetPaymentKeySuccess extends PaymentDonationState{
  final String paymentKey;

  const GetPaymentKeySuccess({required this.paymentKey});
}
class GetPaymentKeyFailure extends PaymentDonationState{}
