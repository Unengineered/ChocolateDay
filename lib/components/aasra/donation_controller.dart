import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/pages/donation_checkout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonationCollector extends StatefulWidget {
  @override
  _DonationCollectorState createState() => _DonationCollectorState();
}

class _DonationCollectorState extends State<DonationCollector> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final donationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null)
      emailController.text = FirebaseAuth.instance.currentUser.email;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //Email
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value == '')
                    return 'Please enter an email address';
                  RegExp regex = RegExp(r"^[0-9a-zA-Z.]+@ves.ac.in");
                  if (!regex.hasMatch(value))
                    return "Enter a ves.ac.in email id";
                  return null;
                },
                decoration: kFormInputDecoration.copyWith(
                  hintText: "Email",
                ),
                controller: emailController,
              ),

              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value == '') {
                    return "Enter donation amount";
                  }

                  if (int.parse(value) <= 0) {
                    return "Donation amount must me greater than 0";
                  }

                  return null;
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: kFormInputDecoration.copyWith(
                  labelText: "Donation",
                  labelStyle: kSubtitleStyle,
                  prefix: Text("Rs. "),
                ),
                controller: donationController,
              ),

              SizedBox(height: 20),

              RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  print("Sending to checkout page");
                  if (_formKey.currentState.validate()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DonationCheckout(
                            donation: double.parse(donationController.text),
                            email: emailController.text)));
                  }
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
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
                    child: Center(
                      child: Text("Donate",
                          style: kSubtitleStyle.copyWith(color: Colors.white)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
