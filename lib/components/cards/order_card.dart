import 'package:chocolate_day/components/cards/chocolate_order_card.dart';
import 'package:flutter/material.dart';

import '../../constants/style_constants.dart';

class OrderCard extends StatelessWidget {
  final String orderStatus;
  final String orderId;
  final List<Map<String, dynamic>> chocolates;
  final int index;

  const OrderCard(
      {Key key,
      @required this.orderStatus,
      @required this.orderId,
      this.chocolates,
      @required this.index})
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
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: EdgeInsets.all(20.0 * 0.7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$index",
                          style: kTitle1Style.copyWith(
                              fontSize: 28, color: textColor)),
                      buildChocolates(chocolates),
                      Text(status,
                          style: kSubtitleStyle.copyWith(
                              fontSize: 18, color: textColor))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChocolates(List<Map<String, dynamic>> chocolates) {
    List<Widget> chocolateOrderCards = [];

    for (int i = 0; i < chocolates.length; i++) {
      chocolateOrderCards.add(ChocolateOrderCard(
          email: chocolates[i]['receiverEmail'],
          chocolateName: chocolates[i]['chocolateName']));
      chocolateOrderCards.add(SizedBox(height: 20));
    }

    return Center(
      child: Column(
        children: chocolateOrderCards,
      ),
    );
  }
}
