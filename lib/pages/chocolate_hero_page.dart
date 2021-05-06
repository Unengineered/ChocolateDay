import 'dart:convert';

import 'package:chocolate_day/components/cards/chocolate_card.dart';
import 'package:chocolate_day/constants/class.dart';
import 'package:chocolate_day/constants/url.dart';
import 'package:chocolate_day/model/chocolates.dart';
import 'package:chocolate_day/model/products/chocolate_product.dart';
import 'package:chocolate_day/name_drop_down/NameDropDown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../constants/style_constants.dart';

class HeroChocolatePage extends StatefulWidget {
  final Chocolate chocolate;

  HeroChocolatePage({Key key, @required this.chocolate}) : super(key: key);

  @override
  _HeroChocolatePageState createState() => _HeroChocolatePageState();
}

class _HeroChocolatePageState extends State<HeroChocolatePage> {
  final _formKey = GlobalKey<FormState>();
  UniqueKey key = UniqueKey();
  UniqueKey futureKey = UniqueKey();

  int buildNumber = 0;
  Class selectedClass = Class.Division;
  String selectedEmail = '';
  bool isAnonymous = false;
  bool countPrice = true;
  final messageController = TextEditingController();
  final senderNameController = TextEditingController();
  String error = '';
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void addToCart(ChocolateProduct chocolateProduct) {
    final cart = Hive.box('cart');
    cart.add(chocolateProduct);
  }

  @override
  Widget build(BuildContext context) {
    print(key.toString());

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
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

                //Chocolate Card
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                          tag: widget.chocolate.title,
                          child: ChocolateCard(chocolate: widget.chocolate)),
                    ],
                  ),
                ),

                //Form
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(right: 28.0, left: 28.0, top: 30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Stay Anonymous',
                                style: kSubtitleStyle.copyWith(
                                    color: Colors.black)),
                            Container(
                              height: 30,
                              width: 30,
                              child: CheckboxListTile(
                                  value: isAnonymous,
                                  onChanged: (value) {
                                    setState(() {
                                      isAnonymous = value;
                                    });
                                  }),
                            )
                          ],
                        ),
                        SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Send to", style: kTitle1Style),
                          ],
                        ),

                        SizedBox(height: 18),
                        //Class
                        DropdownButtonFormField<Class>(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == Class.Division)
                              return "Please choose a class";
                            return null;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          )),
                          hint: Text("Class"),
                          value: selectedClass,
                          onChanged: (value) {
                            setState(() {
                              selectedClass = value;
                              selectedEmail = '';
                              futureKey = UniqueKey();
                              key = UniqueKey();
                            });
                          },
                          items: Class.values.map((Class item) {
                            return DropdownMenuItem<Class>(
                                value: item,
                                child: Text(item.toString().split('.')[1]));
                          }).toList(),
                        ),
                        SizedBox(height: 20),

                        (selectedClass == Class.Division)
                            ? Container()
                            : new FutureBuilder<http.Response>(
                                key: futureKey,
                                future: http.get(Uri.parse(
                                    '$kAWSEmailsBaseUrl/${selectedClass.toString().split('.')[1]}')),
                                builder: (context, response) {
                                  if (response.hasError) {
                                    print(response.error.toString());
                                    return Text("Error getting student names");
                                  }

                                  if (response.hasData) {
                                    final body = jsonDecode(response.data.body);
                                    final List<String> names =
                                        new List<String>.from(body['emails']);
                                    print(
                                        "making drop down with $selectedClass -  ${names.toString()}");

                                    return NameDropDown.withData(
                                        key: key,
                                        dataSource:
                                            List<String>.from(body['emails']),
                                        defaultOptionText: "Name",
                                        valueReturned: (valueReturned) {
                                          setState(() {
                                            selectedEmail = valueReturned;
                                          });
                                        });
                                  }

                                  return Container();
                                }),

                        (selectedClass == Class.Division)
                            ? SizedBox(height: 20)
                            : Container(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Message", style: kTitle1Style),
                          ],
                        ),

                        SizedBox(height: 18),
                        //Message
                        TextFormField(
                          inputFormatters: [
                            new LengthLimitingTextInputFormatter(5000),
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: messageController,
                          validator: (value) {
                            if (value == null || value == '')
                              return "Write a message";
                            return null;
                          },
                          maxLines: null,
                          decoration: kFormInputDecoration.copyWith(
                              hintText: "Message (Limit: 5000)"),
                        ),
                        SizedBox(height: 18),

                        //Sender name
                        isAnonymous
                            ? Container()
                            : TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (isAnonymous) return null;
                                  if (value == '' || value == null)
                                    return "Enter your name";
                                  return null;
                                },
                                controller: senderNameController,
                                decoration: kFormInputDecoration.copyWith(
                                    hintText: "Name"),
                              ),

                        (error != '') ? Text(error) : Container()
                      ],
                    ),
                  ),
                ),

                //Space
                SizedBox(height: 20),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Donate to charity",
                          style: kSubtitleStyle.copyWith(color: Colors.black)),
                      Container(
                        height: 30,
                        width: 30,
                        child: CheckboxListTile(
                            value: countPrice,
                            onChanged: (value) {
                              setState(() {
                                countPrice = value;
                              });
                            }),
                      )
                    ],
                  ),
                ),

                //Space
                SizedBox(height: 20),

                //Add to cart button
                RawMaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (selectedEmail != '' &&
                          selectedEmail != null &&
                          selectedEmail != 'Choose Email') {
                        print(selectedEmail);
                        addToCart(ChocolateProduct(
                            chocolateType: widget.chocolate.chocolateType,
                            toClass: selectedClass,
                            senderName: (senderNameController.text == '' ||
                                    senderNameController.text == null)
                                ? null
                                : senderNameController.text,
                            toName: selectedEmail,
                            message: messageController.text,
                            cost: widget.chocolate.price,
                            countPrice: countPrice));

                        print("Showing toast");
                        Widget toast = Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.black,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                CupertinoIcons.bag,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Text("Item added to cart",
                                  style: kSubtitleStyle.copyWith(
                                      color: Colors.white)),
                            ],
                          ),
                        );

                        fToast.showToast(
                          child: toast,
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: Duration(seconds: 2),
                        );

                        Navigator.of(context).pop();
                      } else {
                        setState(() {
                          error = "Please choose an email";
                        });
                      }
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                      child: Center(
                        child: Text("Add to cart",
                            style:
                                kSubtitleStyle.copyWith(color: Colors.white)),
                      )),
                ),

                //Space
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
