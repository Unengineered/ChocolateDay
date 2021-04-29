import 'dart:convert';

import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/constants/url.dart';
import 'package:chocolate_day/pages/orders_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class AccountPage extends StatelessWidget {
  final Future<http.Response> accountInfo = http
      .get(Uri.parse('$kUserDataUrl/${FirebaseAuth.instance.currentUser.uid}'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: FutureBuilder(
                    future: accountInfo,
                    builder: (context, response) {
                      if (response.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black));
                      }

                      if (response.hasError) {
                        return Text('Error loading account data');
                      }

                      if (response.hasData) {
                        final body = jsonDecode(response.data.body);
                        final coupon = body['coupon'];
                        print(body.toString());

                        if (coupon != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your info", style: kTitle1Style),
                              SizedBox(height: 20),
                              Text(
                                  "Email: ${FirebaseAuth.instance.currentUser.email}"),
                              SizedBox(height: 20),
                              if (coupon['name'] != null)
                                Text("Name: ${coupon['name']}"),
                              SizedBox(height: 20),
                              if (coupon['class'] != null)
                                Text("Class: ${coupon['class']}"),
                              SizedBox(height: 20),
                              if (coupon['roll_no'] != null)
                                Text("Roll no: ${coupon['roll_no']}"),
                              SizedBox(height: 20),
                              if (coupon['address'] != null)
                                Text("Address: ${coupon['address']}"),
                              SizedBox(height: 20),
                              if (coupon['city'] != null)
                                Text("City: ${coupon['city']}"),
                              SizedBox(height: 20),
                              if (coupon['postcode'] != null)
                                Text("Pincode: ${coupon['postcode']}"),
                              SizedBox(height: 20),
                              if (coupon['state'] != null)
                                Text("State: ${coupon['state']}"),
                              SizedBox(height: 20),
                              if (coupon['phone_number'] != null)
                                Text("Phone Number: ${coupon['phone_number']}"),
                              SizedBox(height: 20),
                            ],
                          );
                        }
                        buildOrdersButton(context, body['orders']);
                      }

                      return Container();
                    }),
              ),
              SizedBox(height: 20),
              RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Hive.box('cart').clear();
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                },
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFF2600),
                            Color(0xFFFF0000),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(color: kShadowColor, blurRadius: 16.0)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                    child: Center(
                      child: Text("Log Out",
                          style: kSubtitleStyle.copyWith(color: Colors.white)),
                    )),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  RawMaterialButton buildOrdersButton(
      BuildContext context, List<dynamic> orderList) {
    List<Map<String, dynamic>> orders;

    if (orderList == null || orderList.length == 0) {
      orders = [];
    } else
      orders = List<Map<String, dynamic>>.from(orderList);

    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrdersPage(orders: orders)));
      },
      child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF00FF04),
                  Color(0xFF00FF66),
                ],
              ),
              boxShadow: [BoxShadow(color: kShadowColor, blurRadius: 16.0)],
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Center(
            child: Text("Orders",
                style: kSubtitleStyle.copyWith(color: Colors.black)),
          )),
    );
  }
}
