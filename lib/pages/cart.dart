import 'package:chocolate_day/components/cart/cart_items.dart';
import 'package:chocolate_day/components/cart/cart_total.dart';
import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/model/products/chocolate_product.dart';
import 'package:chocolate_day/model/products/coupon_product.dart';
import 'package:chocolate_day/model/products/product.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: Hive.openBox('cart'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return CartItemList();
            } else
              return Scaffold(
                body: Center(
                  child: Text("loading"),
                ),
              );
          },
        ),
      ),
    );
  }
}

class CartItemList extends StatefulWidget {
  @override
  _CartItemListState createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  final cart = Hive.box('cart');

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      // ignore: deprecated_member_use
      child: WatchBoxBuilder(
        box: cart,
        builder: (builder, cart) {
          double cartValue = 0.0;
          for (int i = 0; i < cart.length; i++) {
            final product = cart.getAt(i);
            products.add(product);

            if (product is ChocolateProduct) {
              if (product.countPrice) cartValue += product.cost;
            }

            if (product is CouponProduct) {
              cartValue += 30.0;
            }
          }

          return Stack(
            children: [
              SafeArea(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 80.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 28.0, left: 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                        color:
                                            kPrimaryLabelColor.withOpacity(0.8),
                                      ),
                                      child: Icon(Icons.close,
                                          color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child:
                                        Text("Cart", style: kLargeTitleStyle),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            CartItems(cart: cart),
                          ],
                        ),
                      ))),
              CartTotal(cartValue: cartValue)
            ],
          );
        },
      ),
    );
  }
}
