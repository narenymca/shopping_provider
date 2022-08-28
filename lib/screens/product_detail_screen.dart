import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/provider/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail-screen';
  const ProductDetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${loadedProduct.price}',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
