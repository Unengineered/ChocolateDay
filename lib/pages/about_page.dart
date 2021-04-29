import 'package:chocolate_day/constants/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              CupertinoIcons.xmark,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'About',
            style: TextStyle(fontSize: 20),
          )),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: Image.asset(
                            'asset/illustrations/cult-white-final.png',
                            fit: BoxFit.contain)),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Send your feelings with chocolates",
                    style: kLargeTitleStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                    "In this past year of massive disconnect (literally and figuratively), we’ve all looked for alternate ways to communicate with the ones we care about. Zoom, Google Meet, Snapchat (ahem), Telegram and even Tinder. This is our attempt at giving a twist to that communication :)",
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Contact Us",
                    style: kLargeTitleStyle.copyWith(
                        fontSize: 20.0, color: Colors.white)),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("cultural.vesit@ves.ac.in",
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("v1.0",
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
