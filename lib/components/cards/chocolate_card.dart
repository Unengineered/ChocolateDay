import 'package:chocolate_day/model/chocolates.dart';
import 'package:flutter/material.dart';

import '../../constants/style_constants.dart';

class ChocolateCard extends StatelessWidget {
  final Chocolate chocolate;
  const ChocolateCard({Key key, @required this.chocolate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //Shadow
            Container(
              height: MediaQuery.of(context).size.width * 9 / 16 * 0.15,
              width: MediaQuery.of(context).size.width * 0.6 ,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: chocolate.background.colors[0].withOpacity(0.35),
                  offset: Offset(0, 12),
                  blurRadius: 32,
                ),
                BoxShadow(
                  color: chocolate.background.colors[1].withOpacity(0.35),
                  offset: Offset(0, 12),
                  blurRadius: 32,
                )
              ]),
            ),

            //Card
            Container(
              decoration: BoxDecoration(
                gradient: chocolate.background,
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.width * 9 / 16 * 0.9,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset("asset/chocolates/${chocolate.illustration}"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(chocolate.title, style: kTitle1Style.copyWith(fontSize: 28,color: Colors.white)),
                          Text(chocolate.price, style: kSubtitleStyle.copyWith(fontSize: 18,color: Colors.white))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}