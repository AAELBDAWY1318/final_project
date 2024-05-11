import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:charity/paymob_manager/paymob_manager.dart';
import 'package:donation_repository/scr/donation_repos.dart';
import 'package:donation_repository/scr/models/donation_model.dart';
import 'package:equatable/equatable.dart';

part 'payment_donations_event.dart';
part 'payment_donations_state.dart';

class PaymentDonationsBloc
    extends Bloc<PaymentDonationsEvent, PaymentDonationsState> {
  final DonationRepository donationRepository ;
  PaymentDonationsBloc(this.donationRepository) : super(PaymentDonationsInitial()) {
    on<GetAuthTokenEvent>((event, emit) async {
      try {
        emit(GetAuthTokenProcess());
        await PayMobManager().getAuthToken();
        emit(GetAuthTokenSuccess());
      } catch (e) {
        log(e.toString());
        emit(GetAuthTokenFailure());
      }
    });
    on<GetPaymentKeyEvent>((event, emit) async {
      try {
        emit(GetPaymentKeyProcess());
        String visaUrl = await PayMobManager().getOrderRegistrationID(
            amount: (event.amount * 100).toString(),
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            phone: event.phone);
        emit(GetPaymentKeySuccess(visaUrl: visaUrl));
      } catch (e) {
        log(e.toString());
        emit(GetPaymentKeyFailure());
      }
    });
    on<SetDonationReport>((event, emit) async{
      try{
        emit(SetDonationReportProcess());
        await donationRepository.setDonation(event.donationModel);
        emit(SetDonationReportSuccess());
      }catch(e){
        log(e.toString());
        emit(SetDonationReportFailure());
      }
    });
    on<GetDonationsEvent>((event, emit) async{
      try{
        emit(GetDonationsProcess());
        List<DonationModel>list = await donationRepository.getDonationReports();
        emit(GetDonationsSuccess(list: list));
      }catch(e){
        log(e.toString());
        emit(GetDonationsFailure());
      }
    });
  }
}
