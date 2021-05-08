import 'package:chocolate_day/constants/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AasraCard extends StatelessWidget {
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
              height: MediaQuery.of(context).size.width * 9 / 16 * 0.08,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: aasraGradient.colors[0].withOpacity(0.35),
                  offset: Offset(0, 12),
                  blurRadius: 32,
                ),
                BoxShadow(
                  color: aasraGradient.colors[1].withOpacity(0.35),
                  offset: Offset(0, 12),
                  blurRadius: 32,
                )
              ]),
            ),

            //Card
            Container(
              decoration: BoxDecoration(
                gradient: aasraGradient,
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
                        Image.asset("asset/illustrations/aasra_logo2.png",
                            scale: 1.5),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset("asset/illustrations/sort.png",
                              height: 50, width: 50),
                          Text("Aasra\nFundraiser",
                              style: kLargeTitleStyle.copyWith(
                                  fontSize: 25, color: Colors.white)),
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
