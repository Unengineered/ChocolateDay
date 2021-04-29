import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;

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

//conditional import
import '../razorpay/UiFake.dart' if (dart.library.html) 'dart:ui' as ui;


class Checkout extends StatefulWidget {
  final double donation;

  Checkout({Key key, this.donation = 0.0}) : super(key: key) {
    print(key);
  }

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool showRazorPay = false;
  String htmlDoc = '';
  Map<String, dynamic> checkout = Map<String, dynamic>();
  final cart = Hive.box('cart');
  FToast fToast;

  @override
  void initState() {
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

    print(jsonEncode(checkout));
    activateRazorPay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (showRazorPay) {
      //register view factory
      ui.platformViewRegistry.registerViewFactory("rzp-html-${widget.key}",
          (int viewId) {
        IFrameElement element = IFrameElement();

        //Event Listener
        window.onMessage.forEach((element) {
          print(element);
          print('Event Received in callback: ${element.data}');
          if (element.data == 'MODAL_CLOSED') {
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
          } else if (element.data == 'SUCCESS_PAYMENT') {
            print('PAYMENT SUCCESSFUL!!!!!!!');
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
        });

        element.id = 'unengineered-iframe';
        element.sandbox.value =
            "allow-forms allow-modals allow-popups allow-popups-to-escape-sandbox allow-top-navigation allow-scripts allow-same-origin allow-orientation-lock";
        element.requestFullscreen();
        element.srcdoc = htmlDoc;
        element.style.border = 'none';
        return element;
      });
    }

    return (showRazorPay)
        ? HtmlElementView(key: UniqueKey(), viewType: 'rzp-html-${widget.key}')
        : Container();
  }

  void activateRazorPay() async {
    print(jsonEncode(checkout));
    print("Getting order id from chocolate factory");
    final response = await http.post(Uri.parse('$kRazorPayUrl'),
        body: jsonEncode(checkout),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    final body = jsonDecode(response.body);
    print(body.toString());

    final html = '''
        <!DOCTYPE html><html>
        <meta name="viewport" content="width=device-width">
        <head><title>RazorPay Web Payment</title></head>
        <body>
        
        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
        <script>
                    var options = {
                      "key": "rzp_test_y20tkZBsylJHtH",
                       "amount": ${body['amount']},
                       "currency": "INR",
                       "order_id": "${body['id']}",
                       "name": "Cultural Council VESIT",
                       "description": "Chocolate Day Transaction",
                       "image": "https://example.com/your_logo",
                       "handler": function (response){
                          window.parent.postMessage("SUCCESS_PAYMENT","*"); 
                       },
                       "modal": {
                         "ondismiss": function(){
                            window.parent.postMessage("MODAL_CLOSED","*");   //3
                         }
                       }
                    };
        
                    var rzp1 = new Razorpay(options);
                    window.onload = function(e){  //1
                         rzp1.open();
                         e.preventDefault();
                    }
             </script>
        </body>
        </html>
    
    ''';

    setState(() {
      showRazorPay = true;
      htmlDoc = html;
    });
  }
}
