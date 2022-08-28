import 'package:flutter/material.dart';
import 'package:shopping/provider/cart.dart';
import 'package:shopping/provider/products_provider.dart';
import 'package:shopping/screens/cart_screen.dart';
import 'package:shopping/widgets/app_drawer.dart';
import 'package:shopping/widgets/badge.dart';
import 'package:shopping/widgets/product_item.dart';

import '../provider/product.dart';
import '../widgets/Product_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({Key key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: FilterOptions.Favorites,
                child: Text('Only Favorites'),
              ),
              PopupMenuItem(
                value: FilterOptions.All,
                child: Text('Show All'),
              )
            ],
          ),
          Consumer<Cart>(
            builder: (context, value, ch) => Badge(
              value: value.itemCount.toString(),
              child: ch,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(showOnlyFav: _showOnlyFavorites),
    );
  }
}
