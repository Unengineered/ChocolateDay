import 'dart:convert';
import 'dart:html';
import 'dart:js' as js;

import 'package:chocolate_day/constants/url.dart';
import 'package:chocolate_day/model/products/chocolate_product.dart';
import 'package:chocolate_day/model/products/coupon_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class IosCheckout extends StatefulWidget {
  final double donation;

  const IosCheckout({Key key, this.donation = 0.0}) : super(key: key);

  @override
  _IosCheckoutState createState() => _IosCheckoutState();
}

class _IosCheckoutState extends State<IosCheckout> {
  Map<String, dynamic> checkout = Map<String, dynamic>();
  BroadcastChannel channel;
  final cart = Hive.box('cart');
  FToast fToast;
  String text = 'INITIAL_ADDING_BROAD';
  Function eventHandler;
  Future<http.Response> orderRequest;

  @override
  void initState() {
    super.initState();
    eventHandler = (event) {
      final windowEvent = event as MessageEvent;
      print(windowEvent.data);
      setState(() {
        text = windowEvent.data;
      });

      if (windowEvent.data == "RAZORPAY_DISMISSED") Navigator.of(context).pop();
    };
    print("Making checkout JSON");
    fToast = FToast();
    fToast.init(context);
    checkout['uid'] = FirebaseAuth.instance.currentUser.uid;
    checkout['email'] = FirebaseAuth.instance.currentUser.email;
    checkout['order'] = Map<String, dynamic>();
    checkout['order']['donation'] = widget.donation;
    checkout['order']['chocolates'] = [];
    checkout['couponData'] = null;

    for (int i = 0; i < cart.length; i++) {
      final product = cart.getAt(i);
      if (product is ChocolateProduct) {
        Map<String, dynamic> chocolate = {
          "chocolateName": product.chocolateType.toString().split('.')[1],
          "anonymous": (product.senderName == null || product.senderName == '')
              ? true
              : false,
          "senderName": product.senderName,
          "receiverClass": product.toClass.toString().split('.')[1],
          "receiverEmail": product.toName,
          "receiverMessage": product.message,
        };

        checkout['order']['chocolates'].add(chocolate);
      }

      if (product is CouponProduct) {
        checkout['couponData'] = {
          "name": product.name,
          "class": product.studentClass.toString().split('.')[1],
          "roll_no": product.rollNo,
          "address": product.address,
          "city": product.city,
          "state": product.state.toString().split('.')[1],
          "postcode": int.parse(product.pinCode),
          "email": product.email,
          "phone_number": product.phoneNumber
        };
      }
    }
    orderRequest = http.post(Uri.parse('$kRazorPayUrl'),
        body: jsonEncode(checkout),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    window.addEventListener("message", eventHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: [
          Text(text),
          FutureBuilder(
              future: orderRequest,
              builder: (context, response) {
                if (response.hasData) {
                  final body = jsonDecode(response.data.body);
                  print(body.toString());
                  return TextButton(
                      onPressed: () {
                        js.context.callMethod('open', [
                          '/razorpay.html?amount=${body['amount']}&order_id=${body['id']}'
                        ]);
                      },
                      child: Text("Buy now ${body['id']}"));
                }
                return Container(
                  child: Text("loading order"),
                );
              })
        ],
      ),
    ));
  }

  // void activateRazorPay() async {
  //   print(jsonEncode(checkout));
  //   print("Getting order id from chocolate factory");
  //   final response = await http.post(Uri.parse('$kRazorPayUrl'),
  //       body: jsonEncode(checkout),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       });
  //   final body = jsonDecode(response.body);
  //   print(body.toString());
  //   setState(() {
  //     text = 'GOT ORDER FROM SERVER ${body['amount']} : ${body['id']}';
  //   });
  //   js.context.callMethod('open', ['/razorpay.html?amount=${body['amount']}&order_id=${body['id']}']);
  // }

  @override
  void dispose() {
    print('removing event listeners');
    window.removeEventListener("message", eventHandler);
    super.dispose();
  }
}
