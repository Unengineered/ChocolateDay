import 'package:chocolate_day/components/lists/order_card_list.dart';
import 'package:chocolate_day/constants/style_constants.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  List<Map<String, dynamic>> orders;

  OrdersPage({Key key, @required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    orders = orders.reversed.toList();

    return Scaffold(
        body: (orders.length == 0)
            ? Center(
                child: Text(
                  "You have no orders :(",
                  style: kSubtitleStyle,
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 28.0),
                child: Column(children: [OrderCardList(orders: orders)]),
              )

        // Column(
        //         children: [
        //           ListView.builder(
        //             shrinkWrap: true,
        //             itemCount: orders.length,
        //             itemBuilder: (context, index) {
        //               final order = orders[index];
        //               final List<Map<String, dynamic>> chocolates =
        //                   List<Map<String, dynamic>>.from(order['chocolates']);
        //               return Column(
        //                 children: [
        //                   Text(
        //                       "${index + 1}. ${order['orderId']} : ${order['orderStatus']}"),
        //                   ListView.builder(
        //                       shrinkWrap: true,
        //                       itemCount: chocolates.length,
        //                       itemBuilder: (context, index) {
        //                         final chocolate = chocolates[index];
        //                         return Text(
        //                             "${chocolate['chocolateName']} to ${chocolate['receiverEmail']}");
        //                       }),
        //                   SizedBox(height: 20)
        //                 ],
        //         );
        //       },
        //     )
        //   ],
        // ),
        );
  }
}
