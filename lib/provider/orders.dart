import 'package:flutter/cupertino.dart';
import 'package:shopping/provider/cart.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItems({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItems> _orders = [];

  List<OrderItems> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final timestamp = DateTime.now();
    const url =
        'https://shopping-a4907-default-rtdb.firebaseio.com/orders.json';
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'quantity': e.quantity,
                    'title': e.title,
                    'price': e.price,
                  })
              .toList()
        }));

    _orders.insert(
        0,
        OrderItems(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: timestamp));
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    const url =
        'https://shopping-a4907-default-rtdb.firebaseio.com/orders.json';

    final response = await http.get(url);
    final List<OrderItems> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((key, value) {
      loadedOrders.add(OrderItems(
          id: key,
          amount: value['amount'],
          products: (value['products'] as List<dynamic>).map((e) {
            CartItem(
                id: e['id'],
                title: e['title'],
                quantity: e['quantity'],
                price: e['price']);
          }).toList(),
          dateTime: DateTime.parse(value['dateTime'])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
