import 'package:flutter/material.dart';
import 'package:shopping/widgets/product_item.dart';

import '../models/product.dart';
import '../widgets/Product_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  ProductOverviewScreen({Key key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
      ),
      body: ProductGrid(),
    );
  }
}


