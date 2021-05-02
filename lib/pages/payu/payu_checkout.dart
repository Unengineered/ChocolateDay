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
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class PayUCheckout extends StatefulWidget {
  final double donation;

  const PayUCheckout({Key key, this.donation = 0.0}) : super(key: key);

  @override
  _PayUCheckoutState createState() => _PayUCheckoutState();
}

class _PayUCheckoutState extends State<PayUCheckout> {
  Map<String, dynamic> checkout = Map<String, dynamic>();
  final cart = Hive.box('cart');
  FToast fToast;
  String status = 'Getting order from server';
  Function eventHandler;
  Future<http.Response> orderRequest;
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print("Making checkout JSON");

    eventHandler = (event) {
      final windowEvent = event as MessageEvent;
      print(windowEvent.data);
      setState(() {
        status = windowEvent.data;
      });

      if (windowEvent.data == "PAYU_DISMISSED") {
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
      } else if (windowEvent.data == "PAYU_SUCCESS") {
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

    checkout['name'] =
        getNameFromEmail(FirebaseAuth.instance.currentUser.email);

    print(jsonEncode(checkout));
    orderRequest = http.post(Uri.parse('$kPayUUrl'),
        body: jsonEncode(checkout),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            FutureBuilder(
                future: orderRequest,
                builder: (context, response) {
                  if (response.hasError) {
                    return Text("${response.error}");
                  }

                  if (response.hasData) {
                    final body = jsonDecode(response.data.body);
                    print(body.toString());

                    return Column(
                      children: [
                        Text("Total: Rs.${body['amount']}"),
                        Text("Order id: ${body['txnid']}"),

                        SizedBox(height: 20.0),

                        //Phone number
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value == '')
                                return 'Please enter your phone number';

                              RegExp regex = RegExp(r"^(?:[+0]9)?[0-9]{10}$");
                              if (!regex.hasMatch(value))
                                return 'Enter a valid phone number';

                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.phone,
                            decoration: kFormInputDecoration.copyWith(
                              prefix: Text("+91 "),
                              hintText: "Phone no.",
                            ),
                            controller: phoneController,
                          ),
                        ),
                        SizedBox(height: 22),

                        RawMaterialButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              js.context.callMethod('open', [
                                '/checkoutpayu.html?amount=${body['amount']}&txnid=${body['txnid']}&email=${FirebaseAuth.instance.currentUser.email}&phone${phoneController.text}=&hash=${body['hash']}&name=${getNameFromEmail(FirebaseAuth.instance.currentUser.email)}'
                              ]);
                            }
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

                  return Container();
                })
          ],
        ),
      ),
    );
  }

  String getNameFromEmail(String email) {
    String sub = email.substring(0, 5);

    if (sub.contains(RegExp(r'[0-9]'))) {
      email = email.substring(3);
    }

    RegExp reg1 = new RegExp(r'[a-z]\w+');
    Iterable matches = reg1.allMatches(email);
    return (email.substring(matches.first.start, matches.first.end));
  }
}
