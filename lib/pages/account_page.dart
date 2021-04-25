import 'package:chocolate_day/constants/style_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: RawMaterialButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
            child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFF2600),
                        Color(0xFFFF0000),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(color: kShadowColor, blurRadius: 16.0)
                    ],
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                child: Center(
                  child: Text("Log Out",
                      style: kSubtitleStyle.copyWith(color: Colors.white)),
                )),
          ),
        ),
      ),
    );
  }
}
