import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping/provider/orders.dart';
import 'package:intl/intl.dart';

class OrderItemsW extends StatefulWidget {
  final OrderItems order;
  const OrderItemsW({Key key, @required this.order}) : super(key: key);

  @override
  State<OrderItemsW> createState() => _OrderItemsWState();
}

class _OrderItemsWState extends State<OrderItemsW> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd MMM yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more)),
          ),
          if (_expanded)
            Container(
              padding: const EdgeInsets.all(10),
              height: min(widget.order.products.length * 20.0 + 50.0, 180.0),
              child: ListView(
                children: widget.order.products
                    .map(
                      (e) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${e.quantity} x \$${e.price}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
