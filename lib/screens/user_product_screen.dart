import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import './edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key key}) : super(key: key);
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productItems = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productItems.items.length,
          itemBuilder: (ctx, index) => Column(
            children: <Widget>[
              UserProductItem(
                id: productItems.items[index].id,
                title: productItems.items[index].title,
                imageUrl: productItems.items[index].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
