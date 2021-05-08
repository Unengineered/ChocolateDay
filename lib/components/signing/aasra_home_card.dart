import 'package:chocolate_day/constants/style_constants.dart';
import 'package:flutter/material.dart';

class AasraHomeCard extends StatelessWidget {
  const AasraHomeCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/aasra');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
            color: Color.fromRGBO(32, 33, 92, 1),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Color(0x085E636B),
                offset: Offset(0, 12),
                blurRadius: 16,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                'asset/illustrations/aasra_logo2.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(width: 1),
            Expanded(
              child: Text(
                "Donate to Aasra fundraiser.",
                style:
                    kSubtitleStyle.copyWith(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
