import 'package:auctionapp/constructor/dashCardDesign.dart';
import 'package:auctionapp/provider/productProvider.dart';
import 'package:auctionapp/view/addProduct.dart';
import 'package:auctionapp/view/viewEditProduct/viewProductList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDash extends StatefulWidget {
  static const String routeNames = 'Product_DashPage';
  ProductDash({Key? key}) : super(key: key);

  @override
  State<ProductDash> createState() => _ProductDashState();
}

class _ProductDashState extends State<ProductDash> {
  late ProductProvider _productProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _productProvider = Provider.of<ProductProvider>(context, listen: false);
    _productProvider.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashScreen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          children: [
            dashScreenCard(
                text: 'Add Product',
                image: 'assets/add.png',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => addproduct()));
                }),
            dashScreenCard(
              text: 'View Product',
              image: 'assets/viewproduct.png',
              onPressed: () {
                Navigator.pushNamed(context, ProductListPage.routeNames);
              },
            ),
            dashScreenCard(
              text: 'categories',
              image: 'assets/categories.png',
              onPressed: () {},
            ),
            dashScreenCard(
              text: 'History',
              image: 'assets/order.png',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
