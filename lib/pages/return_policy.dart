import 'package:chocolate_day/constants/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              CupertinoIcons.xmark,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            'About',
            style: TextStyle(fontSize: 20),
          )),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.3,
                        child: Image.asset(
                            'asset/illustrations/cult-white-final.png',
                            fit: BoxFit.contain)),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Refund Policy",
                    style: kLargeTitleStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                    "Last updated: April 29, 2021\nThank you for shopping at Chocolate Day.\nIf, for any reason, You are not completely satisfied with a purchase We invite You to review our policy on refunds and returns. This Return and Refund Policy has been created with the help of the Return and Refund Policy Generator.\nThe following terms are applicable for any products that You purchased with Us.",
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Interpretation and Definitions",
                    style: kLargeTitleStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Interpretation",
                    style: kLargeTitleStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                    "The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.",
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Definitions",
                    style: kLargeTitleStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                    'For the purposes of this Return and Refund Policy:\nCompany (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to Cultural Council VESIT, Chembur.\nGoods refer to the items offered for sale on the Service.\nOrders mean a request by You to purchase Goods from Us.\nService refers to the Website.\nWebsite refers to Chocolate Day, accessible from chocolateday.in\nYou means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.',
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Your Order Cancellation Rights",
                    style: kLargeTitleStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                    '''You are entitled to cancel Your Order within 7 days without giving any reason for doing so.

The deadline for cancelling an Order is 7 days from the date on which You received the Goods or on which a third party you have appointed, who is not the carrier, takes possession of the product delivered.

In order to exercise Your right of cancellation, You must inform Us of your decision by means of a clear statement. You can inform us of your decision by:

By email: cultural.vesit@ves.ac.in
We will reimburse You no later than 14 days from the day on which We receive the returned Goods. We will use the same means of payment as You used for the Order, and You will not incur any fees for such reimbursement.''',
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Conditions for Returns",
                    style: kLargeTitleStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                    '''In order for the Goods to be eligible for a return, please make sure that:

The Goods were purchased in the last 7 days
The Goods are in the original packaging
The following Goods cannot be returned:

The supply of Goods made to Your specifications or clearly personalized.
The supply of Goods which according to their nature are not suitable to be returned, deteriorate rapidly or where the date of expiry is over.
The supply of Goods which are not suitable for return due to health protection or hygiene reasons and were unsealed after delivery.
The supply of Goods which are, after delivery, according to their nature, inseparably mixed with other items.
We reserve the right to refuse returns of any merchandise that does not meet the above return conditions in our sole discretion.

Only regular priced Goods may be refunded. Unfortunately, Goods on sale cannot be refunded. This exclusion may not apply to You if it is not permitted by applicable law.''',
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Returning Goods",
                    style: kLargeTitleStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                    '''You are responsible for the cost and risk of returning the Goods to Us. You should send the Goods at the following address:

Chembur

We cannot be held responsible for Goods damaged or lost in return shipment. Therefore, We recommend an insured and trackable mail service. We are unable to issue a refund without actual receipt of the Goods or proof of received return delivery.''',
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Gifts",
                    style: kLargeTitleStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                    '''If the Goods were marked as a gift when purchased and then shipped directly to you, You'll receive a gift credit for the value of your return. Once the returned product is received, a gift certificate will be mailed to You.

If the Goods weren't marked as a gift when purchased, or the gift giver had the Order shipped to themselves to give it to You later, We will send the refund to the gift giver.''',
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Contact Us",
                    style: kLargeTitleStyle.copyWith(color: Colors.white)),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                    '''If you have any questions about our Returns and Refunds Policy, please contact us:

By email: cultural.vesit@ves.ac.in''',
                    style: kSubtitleStyle.copyWith(
                        height: 1.8, color: Colors.white)),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
