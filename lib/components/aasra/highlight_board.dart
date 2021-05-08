import 'package:chocolate_day/constants/style_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HighlightBoard extends StatelessWidget {
  final String name;
  final List<Map<String, dynamic>> donations;

  const HighlightBoard({Key key, @required this.name, @required this.donations})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> boardEntries = [];

    for (int i = 0; i < 5; i++) {
      boardEntries.add(BoardEntry(
          email: donations[i]['donor_email'],
          donation: donations[i]['amount']));
      boardEntries.add(SizedBox(height: 15));
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(0, 20),
            blurRadius: 15,
          )
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(name,
                    style: kLargeTitleStyle.copyWith(
                        color: Colors.white, fontSize: 38)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: boardEntries,
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}

class BoardEntry extends StatelessWidget {
  final String email;
  final double donation;

  const BoardEntry({Key key, @required this.email, @required this.donation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inRs = NumberFormat.currency(locale: 'HI');
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getNameFromEmail(email).capitalize(),
                    style: kParaStyle.copyWith(color: Colors.white)),
                Text("Rs. ${inRs.format(donation).replaceAll("INR", '')}",
                    style: kParaStyle.copyWith(color: Colors.white))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(email, style: kSubtitleStyle.copyWith(fontSize: 8))
              ],
            ),
          )
        ],
      ),
    );
  }
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

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
