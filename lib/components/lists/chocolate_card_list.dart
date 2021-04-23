import 'package:chocolate_day/components/cards/chocolate_card.dart';
import 'package:chocolate_day/model/chocolates.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ChocolateCardList extends StatelessWidget {

  List<Widget> chocolateListWidgets(){
    List<Widget> cards = [];

    for (var chocolate in chocolates){
      cards.add(
        Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: ChocolateCard(chocolate: chocolate),
        ),
      );
    }

    cards.add(Padding(
        padding: EdgeInsets.only(top: 12, bottom: 20),
        child: Text("No more chocolates to view", style: kCaptionLabelStyle, textAlign: TextAlign.center,)
    ));

    return cards;
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: chocolateListWidgets(),
      ),
    );
  }
}
