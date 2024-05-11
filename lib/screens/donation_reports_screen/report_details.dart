import 'package:charity/app_locale/app_locale.dart';
import 'package:charity/constant/my_colors.dart';
import 'package:charity/widgets/animated_text.dart';
import 'package:charity/widgets/back_compoent.dart';
import 'package:charity/widgets/details_component.dart';
import 'package:donation_repository/donation_repository.dart';
import 'package:flutter/material.dart';
import '../../widgets/second_default_text.dart';

class ReportDetails extends StatefulWidget {
  final DonationModel donationModel;
  const ReportDetails({super.key, required this.donationModel});

  @override
  State<ReportDetails> createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const Back(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SecondDefaultText(
                    text: getLang(context, "details")!,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: double.infinity,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: MyColors.myBlue,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(8, 8),
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: AnimatedTextWriter(
                        color: Colors.white,
                        text:
                        "${getLang(context, "donate for")!} ${getLang(context, widget.donationModel.category)!}",
                        onTextWritingDone: (val) {
                          flag = val;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: flag,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20.0,
                              offset: Offset(8, 8),
                            ),
                          ]),
                      child: Column(
                        children: [
                          DetailsCom(
                            what: getLang(context, "date")!,
                            res: widget.donationModel.date,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          DetailsCom(
                            what: getLang(context, "time")!,
                            res: widget.donationModel.time,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          DetailsCom(
                            what: getLang(context, "donation amount")!,
                            res: widget.donationModel.donationAmount,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          DetailsCom(
                            what: getLang(context, "cost")!,
                            res: widget.donationModel.managementCost,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
