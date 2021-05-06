import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/pages/razorpay_checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CartTotal extends StatefulWidget {
  final double cartValue;

  const CartTotal({Key key, this.cartValue}) : super(key: key);

  @override
  _CartTotalState createState() => _CartTotalState();
}

class _CartTotalState extends State<CartTotal> {
  @override
  Widget build(BuildContext context) {
    print("Rebuilding cartTotal");
    return SlidingUpPanel(
      onPanelClosed: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      backdropEnabled: true,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: kShadowColor,
          offset: Offset(0, -12),
          blurRadius: 32,
        )
      ],
      minHeight: 75,
      color: kCardPopupBackgroundColor,
      panel: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 12, bottom: 16),
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                    color: Color(0xFFC5CBD6),
                    borderRadius: BorderRadius.circular(40)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Text("Total", style: kTitle1Style.copyWith(fontSize: 40)),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Bill(cartValue: widget.cartValue),
          )
        ],
      ),
    );
  }
}

class Bill extends StatefulWidget {
  final double cartValue;

  const Bill({Key key, @required this.cartValue}) : super(key: key);

  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {
  final cart = Hive.box('cart');
  double donation = 0.0;
  double processingFees = 0.0;
  double total = 0.0;
  final donationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    donationController.text = "0";
    calculateTotal();
  }

  @override
  Widget build(BuildContext context) {
    calculateTotal();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Subtotal:"), Text("Rs. ${widget.cartValue}")],
          ),
          SizedBox(height: 20),

          Text(
              "The world needs more kind people like you to extend their generosity and support the sick and old with Khushiyan organization and SMIT old age home and care centre. A little penny for you, is a whole lot of hope for them.",
              style: kSubtitleStyle.copyWith(fontSize: 10)),

          SizedBox(height: 20),
          TextField(
            onChanged: (value) {
              print("Value on donation $value");
              if (value != '')
                setState(() {
                  donation = double.parse(value);
                });
              else
                setState(() {
                  donation = 0.0;
                });
            },
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Donation",
                labelStyle: kSubtitleStyle,
                prefix: Text("Rs. "),
                fillColor: Colors.black,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            controller: donationController,
          ),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  QuickDonationButton(
                    amount: 10,
                    controller: donationController,
                    updateDonation: updateDonation,
                  ),
                  SizedBox(width: 5),
                  QuickDonationButton(
                      amount: 20,
                      controller: donationController,
                      updateDonation: updateDonation),
                  SizedBox(width: 5),
                  QuickDonationButton(
                      amount: 30,
                      controller: donationController,
                      updateDonation: updateDonation),
                ],
              ),
              Container(
                  height: 50,
                  width: 50,
                  child: Image.asset('asset/illustrations/sort.png')),
            ],
          ),
          SizedBox(height: 20),

          //Processing fees
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Processing Fees:"),
              Text("Rs. ${processingFees.toStringAsFixed(2)}")
            ],
          ),
          SizedBox(height: 10),

          //Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total:"),
              Text("Rs. $total", style: kTitle2Style.copyWith(fontSize: 25))
            ],
          ),
          SizedBox(height: 20),
          (total != 0.0)
              ? Column(
                  children: [
                    RawMaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        print("Sending to checkout page");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RazorpayCheckout(
                                donation: donation, key: UniqueKey())));
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 35, vertical: 15),
                          child: Center(
                            child: Text("Checkout",
                                style: kSubtitleStyle.copyWith(
                                    color: Colors.white)),
                          )),
                    ),
                  ],
                )
              : RawMaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {},
                  child: Container(
                      height: 50,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                      child: Center(
                        child: Text("Total is zero",
                            style:
                                kSubtitleStyle.copyWith(color: Colors.white)),
                      )),
                ),
        ],
      ),
    );
  }

  void updateDonation(double amount) {
    setState(() {
      donation = amount;
    });
  }

  void calculateTotal() {
    print("calculating total");
    double newProcessingFees = (widget.cartValue + donation) * 0.05.toDouble();
    double newTotal = widget.cartValue + donation + newProcessingFees;

    print(newTotal);

    if (newTotal != total) {
      print("Changing total");
      setState(() {
        processingFees = newProcessingFees;
        total = newTotal;
      });
    }
  }
}

class QuickDonationButton extends StatelessWidget {
  final int amount;
  final TextEditingController controller;
  final Function updateDonation;

  const QuickDonationButton({
    Key key,
    @required this.amount,
    @required this.controller,
    @required this.updateDonation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final donationText =
            controller.text != '' ? double.parse(controller.text) : 0;
        final donation = (donationText + amount);
        controller.text = donation.toString();
        updateDonation(donation);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(amount.toString(), style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
