import 'package:chocolate_day/model/chocolates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/style_constants.dart';

class ChocolateOrderCard extends StatelessWidget {
  final String email;
  final String chocolateName;

  ChocolateOrderCard(
      {Key key, @required this.email, @required this.chocolateName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double scale = 0.7;

    final Chocolate chocolate = chocolates.singleWhere((element) =>
        element.chocolateType.toString().split('.')[1] == chocolateName);

    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0 * scale),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //Shadow
            Container(
              height: MediaQuery.of(context).size.width * 9 / 16 * 0.15 * scale,
              width: MediaQuery.of(context).size.width * 0.6 * scale,
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
                borderRadius: BorderRadius.circular(20 * scale),
              ),
              height: MediaQuery.of(context).size.width * 9 / 16 * 0.9 * scale,
              width: MediaQuery.of(context).size.width * 0.8 * scale,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20 * scale),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                            "asset/chocolates/${chocolate.illustration}"),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0 * scale),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getNameFromEmail(email),
                                  style: kTitle1Style.copyWith(
                                      fontSize: 28 * scale,
                                      color: Colors.white)),
                              Text(chocolate.title,
                                  style: kSubtitleStyle.copyWith(
                                    fontSize: 15 * scale,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
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

  String getNameFromEmail(String email) {
    String sub = email.substring(0, 5);

    if (sub.contains(RegExp(r'[0-9]'))) {
      email = email.substring(3);
    }

    RegExp reg1 = new RegExp(r'[a-z]\w+');
    Iterable matches = reg1.allMatches(email);
    return (email.substring(matches.first.start, matches.first.end));
  }
}
