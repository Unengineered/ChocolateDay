import 'package:chocolate_day/constants/chocolate_type.dart';
import 'package:flutter/material.dart';

final double divider = 5.0;

class Chocolate {
  final String title;
  final String illustration;
  final LinearGradient background;
  final double price;
  final ChocolateType chocolateType;

  Chocolate(
      {@required this.chocolateType,
      @required this.title,
      @required this.illustration,
      @required this.background,
      @required this.price});
}

var chocolates = [
  Chocolate(
      chocolateType: ChocolateType.Homie,
      title: "Homie",
      illustration: "homie.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(150, 102, 255, 1),
            Color.fromRGBO(109, 86, 254, 1)
          ]),
      price: 10 / divider),
  Chocolate(
      chocolateType: ChocolateType.IplBuddies,
      title: "IPL\nBuddies",
      illustration: "friendzone.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(102, 215, 255, 1),
            Color.fromRGBO(86, 153, 254, 1)
          ]),
      price: 10 / divider),
  Chocolate(
      chocolateType: ChocolateType.DiscordGang,
      title: "Discord\nGang",
      illustration: "discord_gang.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(255, 117, 102, 1),
            Color.fromRGBO(254, 86, 86, 1)
          ]),
      price: 20 / divider),
  Chocolate(
      chocolateType: ChocolateType.Imposter,
      title: "Imposter",
      illustration: "imposter.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(77, 76, 76, 1),
            Color.fromRGBO(37, 29, 29, 1)
          ]),
      price: 10 / divider),
  Chocolate(
      chocolateType: ChocolateType.BestSenior,
      title: "Best\nSenior",
      illustration: "best_senior.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(68, 113, 205, 1),
            Color.fromRGBO(77, 30, 210, 1)
          ]),
      price: 80 / divider),
  Chocolate(
      chocolateType: ChocolateType.Love,
      title: "Love",
      illustration: "love.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(195, 84, 150, 1),
            Color.fromRGBO(192, 40, 40, 1)
          ]),
      price: 70 / divider),
  Chocolate(
      chocolateType: ChocolateType.LockdownBuddy,
      title: "Lockdown\nBuddy",
      illustration: "lockdown_buddy.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(238, 183, 81, 1),
            Color.fromRGBO(252, 205, 36, 1)
          ]),
      price: 35 / divider),
  Chocolate(
      chocolateType: ChocolateType.Jugaadu,
      title: "Jugaadu",
      illustration: "jugaadu.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(238, 77, 78, 1.0),
            Color.fromRGBO(243, 82, 83, 1.0)
          ]),
      price: 30 / divider),
  Chocolate(
      chocolateType: ChocolateType.SpecialDedication,
      title: "Special\nDedication",
      illustration: "special_dedication.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(91, 55, 57, 1.0),
            Color.fromRGBO(64, 30, 32, 1.0)
          ]),
      price: 99 / divider),
  Chocolate(
      chocolateType: ChocolateType.RightSwipe,
      title: "Right\nSwipe",
      illustration: "right_swipe.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(232, 172, 0, 1.0),
            Color.fromRGBO(158, 72, 22, 1.0)
          ]),
      price: 20 / divider),
  Chocolate(
      chocolateType: ChocolateType.BestFriend,
      title: "Best\nFriend",
      illustration: "best_friend.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(248, 58, 73, 1.0),
            Color.fromRGBO(186, 69, 76, 1.0)
          ]),
      price: 40 / divider),
  Chocolate(
      chocolateType: ChocolateType.Crush,
      title: "Crush",
      illustration: "crush.png",
      background: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(89, 46, 183, 1.0),
            Color.fromRGBO(37, 38, 99, 1.0)
          ]),
      price: 45 / divider),
];