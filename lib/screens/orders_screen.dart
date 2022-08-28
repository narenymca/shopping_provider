import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/provider/orders.dart';
import 'package:shopping/widgets/app_drawer.dart';
import 'package:shopping/widgets/order_items.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersData.orders.length,
        itemBuilder: (context, index) =>
            OrderItemsW(order: ordersData.orders[index]),
      ),
    );
  }
}
