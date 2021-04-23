import 'package:chocolate_day/components/lists/chocolate_card_list.dart';
import 'package:chocolate_day/components/nav_bar/nav_bar.dart';
import 'package:chocolate_day/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        NavBar(navBarStyle: NavBarStyle.LoggedIn),
        Padding(
          padding: EdgeInsets.only(top: 28.0),
          child: Center(
            child: Container(
              child: Text("Choose your feeling", style: kLargeTitleStyle),
            ),
          ),
        ),
        SizedBox(height: 20),
        ChocolateCardList(),
      ],
    ));
  }
}


