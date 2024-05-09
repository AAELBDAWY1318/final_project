import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:charity/paymob_manager/paymob_manager.dart';
import 'package:equatable/equatable.dart';

part 'payment_donation_event.dart';
part 'payment_donation_state.dart';

class PaymentDonationBloc
    extends Bloc<PaymentDonationEvent, PaymentDonationState> {
  PaymentDonationBloc() : super(PaymentDonationInitial()) {
    on<GetPaymentKeyEvent>((event, emit) async{
      try{
        emit(GetPaymentKeyProcess());
        String paymentKey = await PayMobManager().getPaymentKey(
            amount: event.amount,
            currency: event.currency,
            email: event.email,
            phone: event.phone,
            firstName: event.firstName,
            lastName: event.lastName);
        log(paymentKey);
        emit(GetPaymentKeySuccess(paymentKey: paymentKey));
      }catch(e){
        log(e.toString());
        emit(GetPaymentKeyFailure());
      }
    });
  }
}
