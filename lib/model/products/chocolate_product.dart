import 'dart:core';

import 'package:chocolate_day/constants/chocolate_type.dart';
import 'package:chocolate_day/constants/class.dart';
import 'package:chocolate_day/model/products/poduct.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'chocolate_product.g.dart';

@HiveType(typeId: 0)
class ChocolateProduct implements Product {
  @HiveField(0)
  final ChocolateType chocolateType;

  @HiveField(1)
  final String toName;

  @HiveField(2)
  final Class toClass;

  @HiveField(3)
  final String senderName;

  @HiveField(4)
  final String message;

  @HiveField(5)
  final int cost;

  ChocolateProduct({
    @required this.chocolateType,
    @required this.toClass,
    @required this.toName,
    this.senderName,
    @required this.message,
    @required this.cost,
  });
}