import 'package:chocolate_day/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonationAmountBoard extends StatelessWidget {
  final double totalDonation;

  const DonationAmountBoard({Key key, @required this.totalDonation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inRs = NumberFormat.currency(locale: 'HI');
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 20),
              blurRadius: 15,
            )
          ]),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 18.0, right: 18.0, left: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total\nDonation",
                    style: kLargeTitleStyle.copyWith(
                        color: Colors.white, fontSize: 28)),
                CircularProgressIndicator(
                  value: totalDonation / 25000,
                  backgroundColor: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(right: 18.0, left: 18.0, bottom: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Rs. ${inRs.format(totalDonation).replaceAll("INR", '').split('.')[0]}",
                        style: kTitle1Style.copyWith(
                            color: Colors.white, fontSize: 20)),
                    Text("Goal: 25,000",
                        style: kSubtitleStyle.copyWith(fontSize: 12))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
