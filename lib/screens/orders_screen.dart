import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/provider/orders.dart';
import 'package:shopping/widgets/app_drawer.dart';
import 'package:shopping/widgets/order_items.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScreen({Key key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  Future
      _ordersFuture; // future and future function is added so that the provider dont run inside the build function and if the widget rebuild then it will go in infinite loop

  Future _obtainOrderFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((value) async {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });

    // setState(() {        // future delayed hack is not required
    //   _isLoading = true;
    //   Provider.of<Orders>(context, listen: false)
    //       .fetchAndSetOrders()
    //       .then((value) {
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   });
    // });

    _ordersFuture = _obtainOrderFuture();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('checking infinite loop');
    //final ordersData = Provider.of<Orders>(context);
    // if we have two provider then the build function will go into infinite loop as the lister will be called again and again the the widget keeps on building

    return Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                // error handling
                return const Center(
                  child: Text('Error has occured'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.orders.length,
                      itemBuilder: (context, index) =>
                          OrderItemsW(order: value.orders[index]),
                    );
                  },
                );
              }
            }
          },
        ));
  }
}
