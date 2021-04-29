import 'package:chocolate_day/components/cards/order_card.dart';
import 'package:flutter/material.dart';

import '../../constants/style_constants.dart';

class OrderCardList extends StatefulWidget {
  final List<Map<String, dynamic>> orders;

  const OrderCardList({Key key, this.orders}) : super(key: key);

  @override
  _OrderCardListState createState() => _OrderCardListState();
}

class _OrderCardListState extends State<OrderCardList> {
  List<Widget> orderListWidgets() {
    List<Widget> cards = [];

    for (var order in widget.orders) {
      cards.add(
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: OrderCard(
              orderId: order['orderId'], orderStatus: order['orderStatus']),
        ),
      );
    }

    cards.add(Padding(
        padding: EdgeInsets.only(top: 12, bottom: 20),
        child: Text(
          "No more orders to view",
          style: kCaptionLabelStyle,
          textAlign: TextAlign.center,
        )));

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: orderListWidgets(),
      ),
    );
  }
}
