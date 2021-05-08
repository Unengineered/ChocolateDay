import 'dart:convert';
import 'dart:html';
import 'dart:js' as js;

import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/constants/url.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DonationCheckout extends StatefulWidget {
  final double donation;
  final String email;

  const DonationCheckout(
      {Key key, @required this.donation, @required this.email})
      : super(key: key);

  @override
  _DonationCheckoutState createState() => _DonationCheckoutState();
}

class _DonationCheckoutState extends State<DonationCheckout> {
  Map<String, dynamic> checkout = Map<String, dynamic>();
  FToast fToast;
  String status = 'Getting order from server';
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
    checkout['uid'] = (FirebaseAuth.instance.currentUser != null)
        ? FirebaseAuth.instance.currentUser.uid
        : null;
    checkout['email'] = widget.email;
    checkout['order'] = Map<String, dynamic>();
    checkout['order']['donation'] = widget.donation;
    checkout['order']['chocolates'] = [];
    checkout['couponData'] = null;

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

                    return Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x085E636B),
                                offset: Offset(0, 12),
                                blurRadius: 16,
                              )
                            ]),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Donation: "),
                                  Text("Rs.${widget.donation}")
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Processing fees(5%): "),
                                  Text("Rs.${widget.donation * 5 / 100}")
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total: "),
                                  Text("Rs.${body['amount'] / 100}")
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Order id: "),
                                  Text("${body['id']}")
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            RawMaterialButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {
                                js.context.callMethod('open', [
                                  '/checkout.html?amount=${body['amount']}&order_id=${body['id']}'
                                ]);
                              },
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
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
                                            color: kShadowColor,
                                            blurRadius: 16.0)
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
                        ),
                      ),
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
