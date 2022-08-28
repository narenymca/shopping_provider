import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartItemW extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String productId;
  CartItemW({
    Key key,
    @required this.id,
    @required this.price,
    @required this.quantity,
    @required this.title,
    @required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('\$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
