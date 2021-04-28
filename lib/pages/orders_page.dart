import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrdersPage({Key key, @required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final List<Map<String, dynamic>> chocolates =
                  List<Map<String, dynamic>>.from(order['chocolates']);
              return Column(
                children: [
                  Text(
                      "${index + 1}. ${order['orderId']} : ${order['orderStatus']}"),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: chocolates.length,
                      itemBuilder: (context, index) {
                        final chocolate = chocolates[index];
                        return Text(
                            "${chocolate['chocolateName']} to ${chocolate['receiverEmail']}");
                      }),
                  SizedBox(height: 20)
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
