import 'package:chocolate_day/components/cards/chocolate_card.dart';
import 'package:chocolate_day/constants/class.dart';
import 'package:chocolate_day/model/chocolates.dart';
import 'package:chocolate_day/model/products/chocolate_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../constants/style_constants.dart';

class HeroChocolatePage extends StatefulWidget {
  final Chocolate chocolate;

  HeroChocolatePage({Key key, @required this.chocolate}) : super(key: key);

  @override
  _HeroChocolatePageState createState() => _HeroChocolatePageState();
}

class _HeroChocolatePageState extends State<HeroChocolatePage> {
  final _formKey = GlobalKey<FormState>();

  String selectedName = '';
  Class selectedClass;

  void addToCart(ChocolateProduct chocolateProduct) {
    final cart = Hive.box('cart');
    cart.add(chocolateProduct);
  }

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
                  padding: EdgeInsets.only(right: 18.0, left: 18.0, top: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Your details", style: kTitle1Style),
                        ],
                      ),
                      SizedBox(height: 18),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: "Name",
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)))),
                      ),
                      SizedBox(height: 18),
                      Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Message",
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //Space
              SizedBox(height: 20),

              //Add to cart button
              RawMaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () async {
                  addToCart(ChocolateProduct(
                      chocolateType: widget.chocolate.chocolateType,
                      toClass: Class.D7B,
                      toName: "Akshita",
                      message: "Hey there",
                      cost: widget.chocolate.price));
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
                      child: Text("Add to cart",
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
