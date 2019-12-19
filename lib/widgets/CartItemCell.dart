import 'package:flutter/material.dart';

class CartItemCell extends StatelessWidget {
  // const CartItemCell({Key key}) : super(key: key);
  Widget buildFirstRow() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("Item"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Price"),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.add_circle),
          onPressed: () {},
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text("1"),
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
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  buildFirstRow(),
                ],
              )),
        ],
      ),
    );
  }
}
