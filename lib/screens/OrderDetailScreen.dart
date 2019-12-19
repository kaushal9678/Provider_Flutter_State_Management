import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';
import '../widgets/order_item.dart' as ord;
import '../widgets/app_drawer.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({Key key}) : super(key: key);
  static const routeName = '/order-summary';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("Order Summary"),
        ),
        body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: (ctx, index) => ord.OrderItem(ordersData.orders[index]),
        ));
  }
}
