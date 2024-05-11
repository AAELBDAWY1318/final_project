import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/payment_donations_bloc/payment_donations_bloc.dart';
import 'package:charity/screens/donation_reports_screen/report_details.dart';
import 'package:charity/size.dart';
import 'package:charity/widgets/animated_loading.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/report_component.dart';
import 'package:donation_repository/donation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationReportsScreen extends StatelessWidget {
  const DonationReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig()..init(context);
    return BlocProvider<PaymentDonationsBloc>(
      create: (context) => PaymentDonationsBloc(FirebaseDonationRepository())
        ..add(
          GetDonationsEvent(),
        ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Back(),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeConfig.screenWidth! * 0.05),
                  child:
                      BlocBuilder<PaymentDonationsBloc, PaymentDonationsState>(
                          builder: (context, state) {
                    if (state is GetDonationsFailure) {
                      return Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/failure.png',
                              height: 120.0,
                              width: 120.0,
                            ),
                            Text(
                              getLang(context, "failure")!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is GetDonationsSuccess) {
                      if (state.list.isNotEmpty) {
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ReportComponent(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReportDetails(
                                              donationModel:
                                                  state.list[index])),
                                    );
                                  },
                                  text:
                                      '${getLang(context, "at")!} ${state.list[index].date}');
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 7.0,
                              );
                            },
                            itemCount: state.list.length);
                      } else {
                        return Center(
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/empty-box.png',
                                height: 120.0,
                                width: 120.0,
                              ),
                              Text(
                                getLang(context, "empty")!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      return const Center(child: LoadingAnimation());
                    }
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
