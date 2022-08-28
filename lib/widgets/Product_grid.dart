import 'package:flutter/material.dart';
import 'package:shopping/provider/products_provider.dart';

import '../provider/product.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool showOnlyFav;

  const ProductGrid({Key key, @required this.showOnlyFav}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        showOnlyFav ? productsData.favoriteitems : productsData.items;

    return GridView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
              // create: (context) => products[index],
              value: products[index],
              child: ProductItem(),
            ));
  }
}
