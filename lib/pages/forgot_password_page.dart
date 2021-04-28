import 'package:chocolate_day/constants/style_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value == '')
                        return 'Please enter an email address';
                      RegExp regex = RegExp(r"^[0-9a-zA-Z.]+@ves.ac.in");
                      if (!regex.hasMatch(value))
                        return "Enter a ves.ac.in email id";
                      return null;
                    },
                    controller: email,
                    decoration:
                        kFormInputDecoration.copyWith(hintText: "Email"))),
            TextButton(
                onPressed: () async {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email.text);
                },
                child: RawMaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email.text);
                  },
                  child: Container(
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
                          BoxShadow(color: kShadowColor, blurRadius: 16.0)
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                    child: Text("Send Reset Email",
                        style: kSubtitleStyle.copyWith(color: Colors.white)),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
