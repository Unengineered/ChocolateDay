import 'package:flutter/material.dart';

import '../../constants/style_constants.dart';

class OrderCard extends StatelessWidget {
  final String orderStatus;
  final String orderId;

  const OrderCard({Key key, @required this.orderStatus, @required this.orderId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String status;
    Color textColor;
    if (orderStatus == 'captured') {
      status = "Payment successful";
      textColor = Colors.black;
    } else if (orderStatus == 'payment_pending') {
      status = "Payment pending";
      textColor = Colors.white;
    } else if (orderStatus == 'failed') {
      status = "Payment failed";
      textColor = Colors.white;
    }

    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //Shadow
            Container(
              height: MediaQuery.of(context).size.width * 9 / 16 * 0.15,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color:
                      orderBackgrounds[orderStatus].colors[0].withOpacity(0.35),
                  offset: Offset(0, 12),
                  blurRadius: 32,
                ),
                BoxShadow(
                  color:
                      orderBackgrounds[orderStatus].colors[1].withOpacity(0.35),
                  offset: Offset(0, 12),
                  blurRadius: 32,
                )
              ]),
            ),

            //Card
            Container(
              decoration: BoxDecoration(
                gradient: orderBackgrounds[orderStatus],
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.width * 9 / 16 * 0.9,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(orderId,
                              style: kTitle1Style.copyWith(
                                  fontSize: 28, color: textColor)),
                          Text(status,
                              style: kSubtitleStyle.copyWith(
                                  fontSize: 18, color: textColor))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
