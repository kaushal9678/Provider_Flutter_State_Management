import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/CartItemCell.dart';

class CartView extends StatelessWidget {
  const CartView({Key key}) : super(key: key);
  static const routeName = '/cart-view';
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<Cart>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Items"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => CartItemCell(),
        itemCount: cartItems.length,
      ),
    );
  }
}
