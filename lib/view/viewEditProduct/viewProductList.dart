import 'package:auctionapp/provider/productProvider.dart';
import 'package:auctionapp/view/viewEditProduct/productDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatefulWidget {
  ProductListPage({Key? key}) : super(key: key);
  static const String routeNames = 'ProductListPage';

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductProvider _productProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = Provider.of<ProductProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: _productProvider.productList.length,
        itemBuilder: (context, index) {
          final product = _productProvider.productList[index];
          return ListTile(
            onTap: (() => Navigator.pushNamed(
                context, productDetails.routeNames,
                arguments: [product.id, product.name])),
            title: Text(product.name!),
            subtitle: Text(product.description!),
            trailing: Text('BDT ${product.price}'),
          );
        },
      ),
    );
  }
}
