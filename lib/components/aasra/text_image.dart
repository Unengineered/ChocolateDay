import 'package:chocolate_day/constants/style_constants.dart';
import 'package:flutter/material.dart';

class TextImage extends StatelessWidget {
  final String path;
  final String text;

  const TextImage({Key key, @required this.path, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          offset: Offset(0, 20),
          blurRadius: 15,
        )
      ]),
      width: MediaQuery.of(context).size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset("$path",
                width: MediaQuery.of(context).size.width * 0.8),
            Padding(
              padding: EdgeInsets.only(left: 18.0, bottom: 18.0),
              child: Text(text,
                  style: kLargeTitleStyle.copyWith(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
