import 'package:chocolate_day/components/cards/coupon_card.dart';
import 'package:chocolate_day/constants/class.dart';
import 'package:chocolate_day/constants/india_state.dart';
import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/model/coupons.dart';
import 'package:chocolate_day/model/products/coupon_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CouponHeroPage extends StatefulWidget {
  @override
  _CouponHeroPageState createState() => _CouponHeroPageState();
}

class _CouponHeroPageState extends State<CouponHeroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Back Button
              Padding(
                padding: EdgeInsets.only(top: 28.0, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: kPrimaryLabelColor.withOpacity(0.8),
                        ),
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              //Coupon Card
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                        tag: coupons[0].title,
                        child: CouponCard(coupon: coupons[0])),
                  ],
                ),
              ),
              //Form
              CouponForm()
            ],
          ),
        ),
      ),
    );
  }
}

class CouponForm extends StatefulWidget {
  @override
  _CouponFormState createState() => _CouponFormState();
}

class _CouponFormState extends State<CouponForm> {
  final _formKey = GlobalKey<FormState>();

  void addToCart(CouponProduct couponProduct) {
    final cart = Hive.box('cart');
    cart.add(couponProduct);
  }

  Class classValue = Class.D7B;
  final nameController = TextEditingController();
  final rollnoController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final pincodeController = TextEditingController();
  final cityController = TextEditingController();
  IndiaState stateValue = IndiaState.Maharashtra;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //Form
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(right: 28.0, left: 28.0, top: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Your details", style: kTitle1Style),
                    ],
                  ),
                  SizedBox(height: 18),

                  //Name
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    decoration: kFormInputDecoration.copyWith(hintText: "Name"),
                  ),
                  SizedBox(height: 18),

                  //Class
                  DropdownButtonFormField<Class>(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    )),
                    hint: Text("Class"),
                    value: classValue,
                    onChanged: (value) {
                      setState(() {
                        classValue = value;
                      });
                    },
                    items: Class.values.map((Class item) {
                      return DropdownMenuItem<Class>(
                          value: item,
                          child: Text(item.toString().split('.')[1]));
                    }).toList(),
                  ),
                  SizedBox(height: 18),

                  //Roll number
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value == '')
                        return 'Please enter your roll number';
                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration:
                        kFormInputDecoration.copyWith(hintText: "Roll no."),
                    controller: rollnoController,
                  ),
                  SizedBox(height: 18),

                  //Phone number
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value == '')
                        return 'Please enter your phone number';

                      RegExp regex = RegExp(r"^(?:[+0]9)?[0-9]{10}$");
                      if (!regex.hasMatch(value))
                        return 'Enter a valid phone number';

                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.phone,
                    decoration: kFormInputDecoration.copyWith(
                      prefix: Text("+91 "),
                      hintText: "Phone no.",
                    ),
                    controller: phoneController,
                  ),
                  SizedBox(height: 22),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Your address", style: kTitle1Style),
                    ],
                  ),
                  SizedBox(height: 18),

                  //Address
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                    decoration: kFormInputDecoration.copyWith(
                      hintText: "Address",
                    ),
                    controller: addressController,
                  ),
                  SizedBox(height: 18),

                  //Pincode
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value == '')
                        return 'Please enter your pincode';

                      RegExp regex = RegExp(r"^[1-9][0-9]{5}$");
                      if (!regex.hasMatch(value))
                        return 'Enter a valid pincode';

                      return null;
                    },
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    decoration:
                        kFormInputDecoration.copyWith(hintText: "Pincode"),
                    controller: pincodeController,
                  ),
                  SizedBox(height: 18),

                  //City
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value == '')
                        return 'Please enter your city';
                      return null;
                    },
                    decoration: kFormInputDecoration.copyWith(
                      hintText: "City",
                    ),
                    controller: cityController,
                  ),

                  SizedBox(height: 18),

                  //State
                  Container(
                    child: DropdownButtonFormField<IndiaState>(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black))),
                      hint: Text("State"),
                      value: stateValue,
                      onChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      items: IndiaState.values.map((IndiaState item) {
                        return DropdownMenuItem<IndiaState>(
                            value: item,
                            child: Text(
                              item.toString().split('.')[1],
                              style: TextStyle(fontSize: 15),
                            ));
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Space
          SizedBox(height: 20),

          //TODO: Add checker for if the document does not exist.
          //Button
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                print(FirebaseAuth.instance.currentUser.uid);

                if (snapshot.hasError) {
                  return Text('Error loading coupon status');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.black));
                }

                try {
                  if (snapshot.data['coupon'] != null) {
                    return RawMaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {},
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFFF2600),
                                  Color(0xFFFF0000),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(color: kShadowColor, blurRadius: 16.0)
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 15),
                          child: Center(
                            child: Text("Only 1 coupon allowed",
                                style: kSubtitleStyle.copyWith(
                                    color: Colors.white)),
                          )),
                    );
                  }
                } catch (e) {
                  print(e);
                  print("Coupon not found in firebase, checking local cart");

                  // ignore: deprecated_member_use
                  return WatchBoxBuilder(
                    box: Hive.box('cart'),
                    builder: (context, cart) {
                      for (var i = 0; i < cart.length; i++) {
                        if (cart.getAt(i) is CouponProduct) {
                          print('Found coupon in cart');
                          return Container(
                            child: RawMaterialButton(
                              materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onPressed: () {},
                              child: Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFFF2600),
                                          Color(0xFFFF0000),
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
                                  child: Center(
                                    child: Text("Only 1 coupon allowed",
                                        style: kSubtitleStyle.copyWith(
                                            color: Colors.white)),
                                  )),
                            ),
                          );
                        }
                      }
                      print("Not coupon found in local cart");
                      return Container(
                        child: RawMaterialButton(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              print("Form validated, adding to cart");
                              addToCart(CouponProduct(
                                  name: nameController.text,
                                  studentClass: classValue,
                                  address: addressController.text,
                                  city: cityController.text,
                                  state: stateValue,
                                  pinCode: pincodeController.text,
                                  phoneNumber: phoneController.text,
                                  email:
                                  FirebaseAuth.instance.currentUser.email));
                              Navigator.of(context).pop();
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
                                    BoxShadow(
                                        color: kShadowColor, blurRadius: 16.0)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 35, vertical: 15),
                              child: Center(
                                child: Text("Add to cart",
                                    style: kSubtitleStyle.copyWith(
                                        color: Colors.white)),
                              )),
                        ),
                      );
                    },
                  );
                }

                return Container();
              }),
          //Space
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
