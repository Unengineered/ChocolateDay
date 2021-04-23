import 'package:chocolate_day/constants/chocolate_type.dart';
import 'package:chocolate_day/constants/class.dart';
import 'package:chocolate_day/pages/cart.dart';
import 'package:chocolate_day/pages/home_page.dart';
import 'package:chocolate_day/pages/signing_page.dart';
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
        '/' : (context) => MainScreen(),
        '/cart' : (context) => Cart(),
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
    return Scaffold(
        body: StreamBuilder(
          stream: auth.authStateChanges(),
          builder: (context, user){

            final bool loggedIn = user.data != null;

            print(user.data);
            return loggedIn ? HomePage() : SigningPage();
            //return HomePage();
          },
        )
    );
  }
}


