import 'dart:convert';
import 'dart:html' as html;

import 'package:chocolate_day/components/aasra/donation_amount_board.dart';
import 'package:chocolate_day/components/aasra/donation_controller.dart';
import 'package:chocolate_day/components/aasra/foundation_details.dart';
import 'package:chocolate_day/components/aasra/highlight_board.dart';
import 'package:chocolate_day/components/cards/aasra_card.dart';
import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/constants/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AasraPage extends StatefulWidget {
  @override
  _AasraPageState createState() => _AasraPageState();
}

class _AasraPageState extends State<AasraPage> {
  @override
  Widget build(BuildContext context) {
    final userAgent = html.window.navigator.userAgent.toString().toLowerCase();
    // smartphone
    if (!(userAgent.contains("iphone") || userAgent.contains("android")))
      return Scaffold(
          body: Center(
              child: Text(
        "This web page is only available on mobile",
        style: kTitle2Style,
      )));

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: Hero(tag: "aasra_card", child: AasraCard()),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: DonationCollector(),
                ),
                SizedBox(height: 30),
                FutureBuilder(
                    future: http.get(Uri.parse(kDonationInfoUrl)),
                    builder: (context, response) {
                      if (response.hasError) {
                        return Container(child: Text("Error getting stats"));
                      }

                      if (response.hasData) {
                        final body = jsonDecode(response.data.body);

                        return Column(
                          children: [
                            DonationAmountBoard(totalDonation: body['amount']),
                            SizedBox(height: 30),
                            HighlightBoard(
                                name: "Top\nDonors",
                                donations: List<Map<String, dynamic>>.from(
                                    body['highest'])),
                            SizedBox(height: 30),
                            HighlightBoard(
                                name: "Recent\nDonors",
                                donations: List<Map<String, dynamic>>.from(
                                    body['latest'])),
                            SizedBox(height: 30),
                          ],
                        );
                      }

                      return Container(child: Text("Loading"));
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: FoundationDetails(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> fakeDonations = [
  {"email": "2019advait.bansode@ves.ac.in", "donation": 1000},
  {"email": "2019advait.bansode@ves.ac.in", "donation": 2583},
  {"email": "2019advait.bansode@ves.ac.in", "donation": 10},
  {"email": "2019advait.bansode@ves.ac.in", "donation": 10},
  {"email": "2019advait.bansode@ves.ac.in", "donation": 10}
];

double fakeTotalDonation = 200000.0;
