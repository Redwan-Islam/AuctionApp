import 'package:auctionapp/constructor/productItem.dart';
import 'package:auctionapp/provider/productProvider.dart';
import 'package:auctionapp/view/addProduct.dart';
import 'package:auctionapp/view/viewEditProduct/ProductDash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class dashScreen extends StatefulWidget {
  dashScreen({Key? key}) : super(key: key);
  static const String routeNames = '/DashScreenPage';

  @override
  State<dashScreen> createState() => _dashScreenState();
}

class _dashScreenState extends State<dashScreen> {
  late ProductProvider _productProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = Provider.of<ProductProvider>(context);
    _productProvider.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dash Screen'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ProductDash.routeNames);
        },
        child: const Icon(Icons.add),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 0.55,
        children: _productProvider.productList
            .map((product) => ProductItem(product))
            .toList(),
      ),
    );
  }
}
