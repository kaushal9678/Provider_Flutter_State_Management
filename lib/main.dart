import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/product_overview_screen.dart';
import './screens/product_details_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './screens/OrdersScreen.dart';
import './providers/orders.dart';
import './screens/user_product_screen.dart';
import './screens/edit_product_screen.dart';

//void main() => runApp(MyApp());
void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          //create: (context) => ProductsProvider(),
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          //create: (context) => ProductsProvider(),
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          //create: (context) => ProductsProvider(),
          value: Orders(),
        ),
      ],
      child: MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartView.routeName: (ctx) => CartView(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductScreen.routeName: (ctx) => UserProductScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          }),
    );
  }
}
