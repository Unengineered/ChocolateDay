import 'package:chocolate_day/constants/class.dart';
import 'package:chocolate_day/constants/india_state.dart';
import 'package:chocolate_day/model/products/poduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

part 'coupon_product.g.dart';

@HiveType(typeId: 3)
class CouponProduct implements Product {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final Class studentClass;

  @HiveField(2)
  final String address;

  @HiveField(3)
  final String city;

  @HiveField(4)
  final IndiaState state;

  @HiveField(5)
  final String pinCode;

  @HiveField(6)
  final String phoneNumber;

  @HiveField(7)
  final String email;

  @HiveField(8)
  final int rollNo;

  CouponProduct({
    @required this.name,
    @required this.studentClass,
    @required this.address,
    @required this.city,
    @required this.state,
    @required this.pinCode,
    @required this.phoneNumber,
    @required this.email,
    @required this.rollNo,
  });
}
