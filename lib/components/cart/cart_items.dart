import 'package:chocolate_day/components/cards/chocolate_cart_card.dart';
import 'package:chocolate_day/components/cards/coupon_card.dart';
import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/model/products/chocolate_product.dart';
import 'package:chocolate_day/model/products/coupon_product.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Box cart;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WatchBoxBuilder(
      box: cart,
      builder: (context, box) {
        if (cart.length == 0) {
          return Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 20),
                  child: Text("Your cart is empty :(",
                      style: kCaptionLabelStyle, textAlign: TextAlign.center)));
        }

        return Column(
          children: [
            ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: cart.length,
                itemBuilder: (builder, index) {
                  var product = cart.getAt(index);
                  if (product is ChocolateProduct) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: ChocolateCartCard(
                        chocolateProduct: product,
                        delete: () {
                          cart.deleteAt(index);
                        },
                      ),
                    );
                  }
                  if (product is CouponProduct) {
                    return CouponCard.fromCouponProduct(
                        product: product,
                        delete: () {
                          cart.deleteAt(index);
                        });
                  }
                  return Container();
                }),
          ],
        );
      },
    );
  }
}
