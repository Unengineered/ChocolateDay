import 'package:badges/badges.dart';
import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/pages/about_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum NavBarStyle { LoggedOut, LoggedIn }

class NavBar extends StatelessWidget {
  final NavBarStyle navBarStyle;

  NavBar({Key key, @required this.navBarStyle}) : super(key: key);

  final cart = Hive.box('cart');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(color: Colors.black),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Image.asset(
              'asset/illustrations/logo2.png',
              height: 35,
            ),
          ),
          Spacer(),
          (navBarStyle == NavBarStyle.LoggedIn)
              ? Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/cart');
                    },
                    // ignore: deprecated_member_use
                    child: WatchBoxBuilder(
                      box: cart,
                      builder: (context, box) {
                        return (box.length != 0)
                            ? Badge(
                                badgeColor: Colors.white,
                                toAnimate: true,
                                animationType: BadgeAnimationType.scale,
                                animationDuration: Duration(milliseconds: 500),
                                position: BadgePosition.topEnd(),
                                badgeContent: Text("${box.length}",
                                    style: kSubtitleStyle.copyWith(
                                        color: Colors.black, fontSize: 10)),
                                child: Icon(
                                  CupertinoIcons.bag,
                                  color: Colors.white,
                                ),
                              )
                            : Icon(
                                CupertinoIcons.bag,
                                color: Colors.white,
                              );
                      },
                    ),
                  ),
                ) : Container(),

          (navBarStyle == NavBarStyle.LoggedIn)
              ? Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/account');
                    },
                    child: Icon(
                      CupertinoIcons.person,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(),
          (navBarStyle != NavBarStyle.LoggedIn)
              ? Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AboutPage()));
                      },
                      child: Text("About",
                          style: kSubtitleStyle.copyWith(color: Colors.white))),
                )
              : Container()
        ],
      ),
    );
  }
}

