import 'package:charity/widgets/card_info_widget.dart';
import 'package:charity/widgets/payment_item_info.dart';
import 'package:charity/widgets/total_price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThankYouCard extends StatelessWidget {
  const ThankYouCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Color(0xFFEDEDED),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 50 + 16, left: 22, right: 22),
        child: Column(
          children: [
            Text(
              'Thank You',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Your Donation Was Successful !',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            PaymentItemInfo(title: 'Date', value: '24/4/2024'),
            SizedBox(
              height: 30,
            ),
            PaymentItemInfo(title: 'Time', value: '10:15 AM'),
            Divider(
              height: 70,
              thickness: 2,
            ),
            TotalPrice(title: 'Total', value: '100 LE'),
            SizedBox(
              height: 30,
            ),
            CardInfoWidget(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  FontAwesomeIcons.barcode,
                  size: 65,
                ),
                Container(
                  width: 113,
                  height: 58,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.50, color: Colors.green),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Center(
                    child: Text('Paid',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 0,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: (MediaQuery.sizeOf(context).height * 0.2 + 20) / 2 - 29,
            )
          ],
        ),
      ),
    );
  }
}
