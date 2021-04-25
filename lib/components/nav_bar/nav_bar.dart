import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum NavBarStyle{
 LoggedOut,
 LoggedIn
}

class NavBar extends StatelessWidget {
  final NavBarStyle navBarStyle;
  const NavBar({Key key, @required this.navBarStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Image.asset('asset/illustrations/logo.png'),
          ),
          Spacer(),
          (navBarStyle == NavBarStyle.LoggedIn) ?  Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed('/cart');
              },
              child: Icon(
                CupertinoIcons.bag,
                color: Colors.white,
              ),
            ),
          ) : Container(),

          (navBarStyle == NavBarStyle.LoggedIn)
              ? Padding(
                  padding: EdgeInsets.only(right: 8.0),
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
              : Container()
        ],
      ),
    );
  }
}
