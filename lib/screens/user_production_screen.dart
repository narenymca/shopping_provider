import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/provider/products_provider.dart';
import 'package:shopping/screens/edit_product_screen.dart';
import 'package:shopping/widgets/app_drawer.dart';
import 'package:shopping/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductScreen({Key key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: productData.items.length,
              itemBuilder: (context, index) => Column(
                children: [
                  UserProductItem(
                    title: productData.items[index].title,
                    imageUrl: productData.items[index].imageUrl,
                    id: productData.items[index].id,
                  ),
                  Divider(),
                ],
              ),
            )),
      ),
    );
  }
}
