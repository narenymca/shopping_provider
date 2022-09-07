import 'package:flutter/material.dart';
import 'package:shopping/provider/products_provider.dart';
import 'package:shopping/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const UserProductItem(
      {Key key,
      @required this.title,
      @required this.imageUrl,
      @required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldMessager = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  scaffoldMessager.showSnackBar(
                      // Scaffold messager with of context will not work as it is inside the try catch so define the scaffold above
                      const SnackBar(
                          content: Text(
                    'Some Error in deleting',
                    textAlign: TextAlign.center,
                  )));
                }
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
