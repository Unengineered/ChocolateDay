import 'package:chocolate_day/model/products/chocolate_product.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
            }
            else
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

class CartItemList extends StatelessWidget {
  final cart = Hive.box('cart');
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cart.length,
        itemBuilder: (builder, index){
          final product = cart.get(index) as ChocolateProduct;
          return Text(product.chocolateType.toString());
        }
    );
  }
}
