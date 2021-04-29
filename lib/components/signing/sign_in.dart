import 'package:chocolate_day/constants/style_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String errorMsg = '';
  bool obscurePassword = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset('asset/illustrations/login-background.png'),
          Column(
            children: [
              //Title
              Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Send your feelings",
                          style: kLargeTitleStyle.copyWith(color: Colors.white),
                          textAlign: TextAlign.center),
                      Text("with chocolates",
                          style: kLargeTitleStyle.copyWith(color: Colors.white),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
              //Form
              Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null || value == '')
                                      return 'Please enter an email address';
                                    RegExp regex =
                                        RegExp(r"^[0-9a-zA-Z.]+@ves.ac.in");
                                    if (!regex.hasMatch(value))
                                      return "Enter a ves.ac.in email id";
                                    return null;
                                  },
                                  decoration: kFormInputDecoration.copyWith(
                                      hintText: "Email",
                                      icon: Icon(CupertinoIcons.mail,
                                          color: Colors.black, size: 20)),
                                  controller: email),
                              SizedBox(height: 10),
                              TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  obscureText: obscurePassword,
                                  decoration: kFormInputDecoration.copyWith(
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
                                                : CupertinoIcons.eye_slash,
                                            size: 15,
                                          )),
                                      hintText: "Password",
                                      icon: Icon(CupertinoIcons.lock,
                                          color: Colors.black, size: 20)),
                                  controller: password),
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
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        !isLoading
                            ? RawMaterialButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    print('Validation successful, logging in');
                                    setState(() {
                                      isLoading = true;
                                    });
                                    firebaseSignIn(
                                        email: email.text,
                                        password: password.text);
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
                                            color: kShadowColor,
                                            blurRadius: 16.0)
                                      ],
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 15),
                                  child: Text("Login",
                                      style: kSubtitleStyle.copyWith(
                                          color: Colors.white)),
                                ),
                              )
                            : CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void firebaseSignIn(
      {@required String email, @required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        setState(() {
          errorMsg = "Email not registered";
        });
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        setState(() {
          errorMsg = "Incorrect password";
        });
      }

      setState(() {
        isLoading = false;
      });
    }
  }
}
