import 'package:chocolate_day/components/lists/order_card_list.dart';
import 'package:chocolate_day/constants/style_constants.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  OrdersPage({Key key, @required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(orders.reversed.toList());
    return Scaffold(
        body: (orders.length == 0)
            ? Center(
                child: Text(
                  "You have no orders :(",
                  style: kSubtitleStyle,
                ),
              )
            : SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 28.0, left: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: kPrimaryLabelColor.withOpacity(0.8),
                            ),
                            child: Icon(Icons.close, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text("Orders", style: kLargeTitleStyle),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  OrderCardList(orders: orders.reversed.toList())
                ]),
              ));
  }
}
