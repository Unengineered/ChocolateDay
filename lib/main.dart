import 'dart:html' as html;

import 'package:chocolate_day/constants/chocolate_type.dart';
import 'package:chocolate_day/constants/class.dart';
import 'package:chocolate_day/constants/india_state.dart';
import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/model/products/coupon_product.dart';
import 'package:chocolate_day/pages/aasra_page.dart';
import 'package:chocolate_day/pages/account_page.dart';
import 'package:chocolate_day/pages/home_page.dart';
import 'package:chocolate_day/pages/signing_page.dart';
import 'package:chocolate_day/pages/verify_account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/products/chocolate_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(ChocolateProductAdapter());
  Hive.registerAdapter(ChocolateTypeAdapter());
  Hive.registerAdapter(ClassAdapter());
  Hive.registerAdapter(CouponProductAdapter());
  Hive.registerAdapter(IndiaStateAdapter());
  Hive.openBox('cart');
  FirebaseAuth.instance;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chocolate Day',
      routes: {
        '/': (context) => MainScreen(),
        //'/cart': (context) => Cart(),
        '/account': (context) => AccountPage(),
        '/aasra': (context) => AasraPage(),
      },
      initialRoute: '/',
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

class MainScreen extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

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

    if (auth.currentUser != null) return HomePage();
    return Scaffold(
      body: StreamBuilder(
          stream: auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data == null) return SigningPage();
              if (!auth.currentUser.emailVerified) return VerifyAccountPage();
              return HomePage();
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              );
            }
          }),
    );
  }
}
