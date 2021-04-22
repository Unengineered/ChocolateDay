import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextField(controller: email),
            TextButton(
                onPressed: () async {
                  FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                },
                child: Text("Reset"))
          ],
        ),
      ),
    );
  }
}
