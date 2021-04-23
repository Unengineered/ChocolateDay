import 'dart:core';
import 'package:chocolate_day/constants/chocolate_type.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:chocolate_day/constants/class.dart';

part 'chocolate_product.g.dart';

@HiveType(typeId: 0)
class ChocolateProduct{
  
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

  ChocolateProduct({
      @required this.chocolateType,
      @required this.toClass,
      @required this.toName,
      this.senderName,
      @required this.message
    });
}