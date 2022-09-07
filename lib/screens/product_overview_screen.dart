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
  var _isInit = true;
  var _isLoading = false;

  // @override
  // void initState() {
  //   Provider.of<Products>(context, listen: false).fetchAndSetProducts();  //THIS WILL NOT WORK BECAUSE OF INHERIT WIDGET OF(CONTEXT) ARE NOT ALLOWED IN INIT STATE
  //   // Future.delayed(Duration.zero).then((value) {
  //   //   Provider.of<Products>(context).fetchAndSetProducts();
  //   // });

  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(showOnlyFav: _showOnlyFavorites),
    );
  }
}
