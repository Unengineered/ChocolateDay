import 'package:hive/hive.dart';

part 'chocolate_type.g.dart';

@HiveType(typeId: 2)
enum ChocolateType {
  @HiveField(0)
  BestFriend,
  @HiveField(1)
  BestSenior,
  @HiveField(2)
  Crush,
  @HiveField(3)
  DiscordGang,
  @HiveField(4)
  IplBuddies,
  @HiveField(5)
  Homie,
  @HiveField(6)
  Jugaadu,
  @HiveField(7)
  LockdownBuddy,
  @HiveField(8)
  Love,
  @HiveField(9)
  RightSwipe,
  @HiveField(10)
  SpecialDedication
}
