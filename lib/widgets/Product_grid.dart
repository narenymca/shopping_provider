import 'package:flutter/material.dart';
import 'package:shopping/provider/products_provider.dart';

import '../models/product.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
     final productData = Provider.of<Products>(context);
      final products = productData.items;

     return GridView.builder(
          itemCount: products.length,
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2),
          itemBuilder: (context, index) => ProductItem(
                id: products[index].id,
                imageUrl: products[index].imageUrl,
                title: products[index].title,
              ));
  }
}
