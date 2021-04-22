import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(onPressed:(){
        FirebaseAuth.instance.signOut();
      } ,child : Text("LogOut")),
    );
  }
}
