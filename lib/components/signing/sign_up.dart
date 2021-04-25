import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/style_constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordVerify = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool obscurePassword = true;
  String errorMsg = '';

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
                          style: kLargeTitleStyle.copyWith(color: Colors.white),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                    TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null || value == '')
                                            return 'Please enter an email address';
                                          RegExp regex = RegExp(
                                              r"^[0-9a-zA-Z.]+@ves.ac.in");
                                          if (!regex.hasMatch(value))
                                            return "Enter a ves.ac.in email id";
                                          return null;
                                        },
                                        decoration:
                                            kFormInputDecoration.copyWith(
                                                hintText: "Email",
                                                icon: Icon(CupertinoIcons.mail,
                                                    color: Colors.black,
                                                    size: 20)),
                                        controller: email),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                        obscureText: obscurePassword,
                                        decoration:
                                            kFormInputDecoration.copyWith(
                                                suffix: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        obscurePassword =
                                                            !obscurePassword;
                                                      });
                                                    },
                                                    child: Icon(
                                                      obscurePassword
                                                          ? CupertinoIcons.eye
                                                          : CupertinoIcons
                                                              .eye_slash,
                                                      size: 15,
                                                    )),
                                                hintText: "Password",
                                                icon: Icon(CupertinoIcons.lock,
                                                    color: Colors.black,
                                                    size: 20)),
                                        controller: password),
                                    SizedBox(height: 10),
                                    TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value != password.text)
                                            return "Passwords don't match";
                                          return null;
                                        },
                                        obscureText: obscurePassword,
                                        decoration:
                                            kFormInputDecoration.copyWith(
                                                suffix: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        obscurePassword =
                                                            !obscurePassword;
                                                      });
                                                    },
                                                    child: Icon(
                                                      obscurePassword
                                                          ? CupertinoIcons.eye
                                                          : CupertinoIcons
                                                              .eye_slash,
                                                      size: 15,
                                                    )),
                                                hintText: "Password",
                                                icon: Icon(CupertinoIcons.lock,
                                                    color: Colors.black,
                                                    size: 20)),
                                        controller: passwordVerify),
                                    SizedBox(height: 10),
                                    (errorMsg != '')
                                        ? Text(errorMsg,
                                            style: kSubtitleStyle.copyWith(
                                                color: Colors.red))
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RawMaterialButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                print("Validation successful");
                                firebaseSignUp(
                                    email: email.text, password: password.text);
                              } else {
                                print("Validation failed");
                              }
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
                                          color: kShadowColor, blurRadius: 16.0)
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

  void firebaseSignUp(
      {@required String email, @required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        setState(() {
          errorMsg = "Weak password";
        });
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        setState(() {
          errorMsg = "Email already taken";
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
