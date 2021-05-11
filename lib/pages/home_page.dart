import 'package:chocolate_day/components/lists/chocolate_card_list.dart';
import 'package:chocolate_day/components/nav_bar/nav_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Column(
        children: [
          NavBar(navBarStyle: NavBarStyle.LoggedIn),
          ChocolateCardList(),
        ],
      )),
    );
  }
}


