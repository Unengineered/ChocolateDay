import 'package:chocolate_day/constants/style_constants.dart';
import 'package:chocolate_day/model/coupons.dart';
import 'package:chocolate_day/model/products/coupon_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  Function delete;

  CouponCard({Key key, @required this.coupon, this.delete}) : super(key: key);

  factory CouponCard.fromCouponProduct(
      {CouponProduct product, Function delete}) {
    return CouponCard(coupon: coupons[0], delete: delete);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            //Shadow
            Container(
              height: MediaQuery.of(context).size.width * 9 / 16 * 0.15,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: coupon.background.colors[0].withOpacity(0.35),
                  offset: Offset(0, 12),
                  blurRadius: 32,
                ),
                BoxShadow(
                  color: coupon.background.colors[1].withOpacity(0.35),
                  offset: Offset(0, 12),
                  blurRadius: 32,
                )
              ]),
            ),

            //Card
            Container(
              decoration: BoxDecoration(
                gradient: coupon.background,
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.width * 9 / 16 * 0.9,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset("asset/chocolates/${coupon.illustration}"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(coupon.title,
                              style: kTitle1Style.copyWith(
                                  fontSize: 28, color: Colors.white)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Rs. ${coupon.price}",
                                  style: kPriceStyle.copyWith(
                                      fontSize: 18, color: Colors.white)),
                              (delete != null)
                                  ? GestureDetector(
                                      onTap: delete,
                                      child: Icon(
                                        CupertinoIcons.delete_solid,
                                        color: Colors.white,
                                      ))
                                  : Container()
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
