part of 'payment_donations_bloc.dart';

sealed class PaymentDonationsState extends Equatable{
  const PaymentDonationsState();
  @override
  List<Object> get props => [];
}

class PaymentDonationsInitial extends PaymentDonationsState {}

class GetAuthTokenProcess extends PaymentDonationsState{}
class GetAuthTokenSuccess extends PaymentDonationsState{}
class GetAuthTokenFailure extends PaymentDonationsState{}

class GetPaymentKeyProcess extends PaymentDonationsState{}
class GetPaymentKeySuccess extends PaymentDonationsState{
  final String visaUrl;

  const GetPaymentKeySuccess({required this.visaUrl});
}
class GetPaymentKeyFailure extends PaymentDonationsState{}
