import 'dart:ui';

import 'package:chocolate_day/constants/style_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class VerifyAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: RawMaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Hive.box('cart').clear();
                      FirebaseAuth.instance.signOut();
                    },
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.25,
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
                        child: Center(
                          child: Text("Log Out",
                              style:
                                  kSubtitleStyle.copyWith(color: Colors.white)),
                        )),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
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
                    SizedBox(height: 40),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text("Verify your account",
                                    style: kTitle1Style.copyWith(
                                        color: Colors.white, fontSize: 30))),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Text(
                                    "We need you to verify that this email belongs to you by clicking on the link sent to you via email. This is done so that people can't create accounts with each other's ves id.",
                                    style: kSubtitleStyle.copyWith(
                                        color: Colors.white60, height: 1.5))),
                          ],
                        ),
                        SizedBox(height: 30),
                        RawMaterialButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () async {
                            FirebaseAuth.instance.currentUser
                                .sendEmailVerification();
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF00AEFF),
                                      Color(0xFF0076FF),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: kShadowColor, blurRadius: 16.0)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 15),
                              child: Center(
                                child: Text("Verify email",
                                    style: kSubtitleStyle.copyWith(
                                        color: Colors.white)),
                              )),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
