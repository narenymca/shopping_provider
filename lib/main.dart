import 'package:flutter/material.dart';
import 'package:shopping/provider/products_provider.dart';
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
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        },
        home: ProductOverviewScreen(),
      ),
    );
  }
}
