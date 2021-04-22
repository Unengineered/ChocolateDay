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
    return Container(
      decoration: BoxDecoration(
        color: Color(0x2FF1F4FB)
      ),
      child: Column(
        children: [
          signIn ? SignIn() : SignUp(),
          TextButton(
              onPressed: () {
                setState(() {
                  signIn = !signIn;
                });
              },
              child: Text(signIn ? "Sign up" : "Sign in")),
          TextButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
            },
            child: Text("Forgot password?"),
          )
        ],
      ),
    );
  }
}
