import 'package:flutter/material.dart';
import 'package:shopping/provider/cart.dart';
import 'package:shopping/provider/orders.dart';
import 'package:shopping/provider/products_provider.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/screens/orders_screen.dart';
import 'package:shopping/screens/product_detail_screen.dart';
import 'package:shopping/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName:(context) => OrdersScreen(),
        },
        home: ProductOverviewScreen(),
      ),
    );
  }
}
