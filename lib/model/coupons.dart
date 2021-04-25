import 'package:flutter/material.dart';

class Coupon {
  final String title;
  final String illustration;
  final LinearGradient background;
  final int price;

  Coupon(
      {@required this.title,
      @required this.illustration,
      @required this.background,
      @required this.price});
}

var coupons = [
  Coupon(
      title: "Chocolate day\ncoupon",
      illustration: "love.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(156, 95, 95, 1.0),
            Color.fromRGBO(84, 35, 35, 1)
          ]),
      price: 30)
];
