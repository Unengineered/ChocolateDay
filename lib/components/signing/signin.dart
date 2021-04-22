import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(controller: email),
          TextField(controller: password),
          TextButton(onPressed: () async{
            try {
              UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email.text,
                  password: password.text
              );
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          }, child: Text("Login"))
        ],
      ),
    );
  }
}
