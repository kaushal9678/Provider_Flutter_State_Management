import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItemCell extends StatelessWidget {
  // const CartItemCell({Key key}) : super(key: key);
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItemCell(this.id, this.productId, this.price, this.quantity, this.title);
  Widget buildFirstRow(Cart product) {
    print(product);
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(title),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(price.toString()),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.add_circle),
          onPressed: () {},
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(quantity.toString()),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(width: 2.0),
              ),
              constraints: BoxConstraints(
                minWidth: 30,
                minHeight: 30,
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.remove_circle),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Do you want to delete the item from the cart?"),
            actions: <Widget>[
              FlatButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              )
            ],
          ),
        );
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            Provider.of<Cart>(context).removeItem(productId);
          },
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(2),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          '\$$price',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    title: Text(title),
                    subtitle: Text('Total: \$${(price * quantity)}'),
                    trailing: Text('$quantity'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
