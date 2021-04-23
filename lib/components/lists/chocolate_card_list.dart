import 'package:chocolate_day/components/cards/chocolate_card.dart';
import 'package:chocolate_day/model/chocolates.dart';
import 'package:chocolate_day/pages/chocolate_hero_page.dart';
import 'package:flutter/material.dart';

import '../../constants/style_constants.dart';

class ChocolateCardList extends StatefulWidget {

  @override
  _ChocolateCardListState createState() => _ChocolateCardListState();
}

class _ChocolateCardListState extends State<ChocolateCardList> {
  List<Widget> chocolateListWidgets(){
    List<Widget> cards = [];

    for (var chocolate in chocolates){
      cards.add(
        Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => HeroChocolatePage(chocolate: chocolate)));
                },
                child: Hero(tag: chocolate.title,child: ChocolateCard(chocolate: chocolate)),
            ),
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
        physics: BouncingScrollPhysics(),
        children: chocolateListWidgets(),
      ),
    );
  }
}
