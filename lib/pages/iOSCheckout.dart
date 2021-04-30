import 'dart:convert';
import 'dart:html';
import 'dart:js' as js;

import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/constants/url.dart';
import 'package:chocolate_day/model/products/chocolate_product.dart';
import 'package:chocolate_day/model/products/coupon_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  String status = 'INITIAL_ADDING_BROAD';
  Function eventHandler;
  Future<http.Response> orderRequest;

  @override
  void initState() {
    super.initState();
    eventHandler = (event) {
      final windowEvent = event as MessageEvent;
      print(windowEvent.data);
      setState(() {
        status = windowEvent.data;
      });

      if (windowEvent.data == "RAZORPAY_DISMISSED") {
        Widget toast = Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.redAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.xmark,
                color: Colors.black,
              ),
              SizedBox(
                width: 12.0,
              ),
              Text("Payment cancelled",
                  style: kSubtitleStyle.copyWith(color: Colors.black)),
            ],
          ),
        );

        fToast.showToast(
          child: toast,
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
        Navigator.of(context, rootNavigator: true).pop();
      } else if (windowEvent.data == "RAZORPAY_SUCCESS") {
        cart.clear();
        Widget toast = Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.lightGreenAccent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                CupertinoIcons.check_mark,
                color: Colors.black,
              ),
              SizedBox(
                width: 12.0,
              ),
              Text("Payment successful",
                  style: kSubtitleStyle.copyWith(color: Colors.black)),
            ],
          ),
        );

        fToast.showToast(
          child: toast,
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 2),
        );
        Navigator.of(context, rootNavigator: true).pop();
      }
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder(
                future: orderRequest,
                builder: (context, response) {
                  if (response.hasData) {
                    final body = jsonDecode(response.data.body);
                    print(body.toString());

                    return Column(
                      children: [
                        Text("Total: Rs.${body['amount'] / 100}"),
                        Text("Order id: ${body['id']}"),
                        SizedBox(height: 10.0),
                        RawMaterialButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            js.context.callMethod('open', [
                              '/razorpay.html?amount=${body['amount']}&order_id=${body['id']}'
                            ]);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF00AEFF),
                                      Color(0xFF0076FF),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: kShadowColor, blurRadius: 16.0)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 15),
                              child: Center(
                                child: Text("Pay",
                                    style: kSubtitleStyle.copyWith(
                                        color: Colors.white)),
                              )),
                        ),
                      ],
                    );
                  }
                  if (response.hasError)
                    return Container(child: Text("Error loading order"));
                  return Container(
                    child: Text("Loading order"),
                  );
                })
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    print('removing event listeners');
    window.removeEventListener("message", eventHandler);
    super.dispose();
  }
}
