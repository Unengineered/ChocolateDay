import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;

import 'package:chocolate_day/constants/url.dart';
import 'package:chocolate_day/model/products/chocolate_product.dart';
import 'package:chocolate_day/model/products/coupon_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

//conditional import
import '../razorpay/UiFake.dart' if (dart.library.html) 'dart:ui' as ui;

class Checkout extends StatefulWidget {
  final double donation;

  const Checkout({Key key, this.donation = 0.0}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool showRazorPay = false;
  String htmlDoc = '';
  Map<String, dynamic> checkout = Map<String, dynamic>();

  @override
  void initState() {
    print("Making checkout JSON");
    checkout['uid'] = FirebaseAuth.instance.currentUser.uid;
    checkout['order'] = Map<String, dynamic>();
    checkout['order']['donation'] = widget.donation;
    checkout['order']['chocolates'] = [];
    checkout['couponData'] = null;

    final cart = Hive.box('cart');
    for (int i = 0; i < cart.length; i++) {
      final product = cart.getAt(i);
      if (product is ChocolateProduct) {
        Map<String, dynamic> chocolate = {
          "chocolateName": product.chocolateType.toString().split('.')[1],
          "isAnonymous":
              (product.senderName == null || product.senderName == '')
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
          "postcode": product.pinCode,
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
      ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
        IFrameElement element = IFrameElement();

        //Event Listener
        window.onMessage.forEach((element) {
          print(element);
          print('Event Received in callback: ${element.data}');
          if (element.data == 'MODAL_CLOSED') {
            Navigator.pop(context);
          } else if (element.data == 'SUCCESS_HELLO') {
            print('PAYMENT SUCCESSFUL!!!!!!!');
            Navigator.pop(context);
          }
        });

        element.id = 'unengineered-iframe';
        element.requestFullscreen();
        element.srcdoc = htmlDoc;
        element.style.border = 'none';
        return element;
      });
    }

    return (showRazorPay) ? HtmlElementView(viewType: 'rzp-html') : Container();
  }

  void activateRazorPay() async {
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
                          window.parent.postMessage("SUCCESS_HELLO","*"); 
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
