import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/blocs/payment_donations_bloc/payment_donations_bloc.dart';
import 'package:charity/layout/app_layout.dart';
import 'package:charity/widgets/animated_text.dart';
import 'package:charity/widgets/snackBar.dart';
import 'package:donation_repository/donation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ThankYouView extends StatefulWidget {
  final DonationModel donationModel;

  const ThankYouView({super.key, required this.donationModel});

  @override
  State<ThankYouView> createState() => _ThankYouViewState();
}

class _ThankYouViewState extends State<ThankYouView> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentDonationsBloc>(
      create: (context) => PaymentDonationsBloc(FirebaseDonationRepository()),
      child: BlocConsumer<PaymentDonationsBloc, PaymentDonationsState>(
        listener: (context, state) {
          if (state is SetDonationReportSuccess) {
            showSnackBar(
                context: context,
                text: getLang(context, "success")!,
                color: Colors.green);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return const AppLayout();
            }), (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60.0,
                  ),
                  Image.asset(
                    'assets/images/thanks.png',
                    height: 130.0,
                    width: 130.0,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Center(
                    child: AnimatedTextWriter(
                      text: getLang(context, "thanks")!,
                      onTextWritingDone: (bool val) {
                        if (val) {
                          // Get the current date and time
                          final now = DateTime.now();

                          // Format the date and time as desired
                          final formattedDate = DateFormat('yyyy-MM-dd').format(now);
                          final formattedTime = DateFormat('HH:mm:ss').format(now);
                          DonationModel donationModel = widget.donationModel;
                          donationModel = donationModel.editUserId(
                            time: formattedTime,
                            date: formattedDate,
                          );
                          context.read<PaymentDonationsBloc>().add(
                                SetDonationReport(
                                    donationModel: donationModel),
                              );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: state is SetDonationReportProcess,
                    child: Column(
                      children: [
                        const CircularProgressIndicator(
                          color: Colors.green,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          getLang(context, "make report")!,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: state is SetDonationReportFailure,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/failure.png',
                          height: 80.0,
                          width: 80.0,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          getLang(context, "failure")!,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
