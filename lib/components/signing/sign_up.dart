import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SignUp extends StatelessWidget {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordVerify = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset('asset/illustrations/login-background.png'),
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Create an account",
                          style: kLargeTitleStyle.copyWith(color: Colors.white), textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x085E636B),
                                offset: Offset(0, 12),
                                blurRadius: 16,
                              )
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle:
                                    TextStyle(color: Color(0x31000000)),
                                    icon: Icon(CupertinoIcons.mail_solid,
                                        color: Colors.black, size: 20),
                                  ),
                                  controller: email),
                              SizedBox(
                                height: 1,
                                child: Container(
                                  decoration:
                                  BoxDecoration(color: Color(0x31000000)),
                                ),
                              ),
                              TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle:
                                    TextStyle(color: Color(0x31000000)),
                                    icon: Icon(CupertinoIcons.lock,
                                        color: Colors.black, size: 20),
                                  ),
                                  controller: password),
                              TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Verify Password",
                                    hintStyle:
                                    TextStyle(color: Color(0x31000000)),
                                    icon: Icon(CupertinoIcons.lock,
                                        color: Colors.black, size: 20),
                                  ),
                                  controller: passwordVerify),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      RawMaterialButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () async {
                          firebaseSignUp(
                              email: email.text, password: password.text);
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
                                  BoxShadow(
                                      color: kShadowColor,
                                      blurRadius: 16.0)
                                ],
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 35, vertical: 15),
                            child: Text("Create account",
                                style: kHeadlineLabelStyle.copyWith(
                                    color: Colors.white))),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void firebaseSignUp({@required String email, @required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
