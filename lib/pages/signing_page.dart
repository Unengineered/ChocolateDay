import 'package:chocolate_day/components/nav_bar/nav_bar.dart';
import 'package:chocolate_day/components/signing/sign_in.dart';
import 'package:chocolate_day/components/signing/sign_up.dart';
import 'package:chocolate_day/pages/forgot_password_page.dart';
import 'package:flutter/material.dart';

class SigningPage extends StatefulWidget {
  @override
  _SigningPageState createState() => _SigningPageState();
}

class _SigningPageState extends State<SigningPage> {
  bool signIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: NavBar(navBarStyle: NavBarStyle.LoggedOut),
            ),
            Container(
              decoration: BoxDecoration(color: Color(0x2FF1F4FB)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  signIn ? SignIn() : SignUp(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              signIn = !signIn;
                            });
                          },
                          child: Text(signIn ? "Create account" : "Sign in")),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                        },
                        child: Text("Forgot password"),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              signIn = !signIn;
                            });
                          },
                          child: Text("Privacy Policy")),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ForgotPasswordPage()));
                        },
                        child: Text("Terms & Conditions"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
