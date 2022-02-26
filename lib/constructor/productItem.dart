import 'package:auctionapp/model/productModel.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatefulWidget {
  final ProductModel product;
  const ProductItem(this.product);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 7,
      child: Column(
        children: [
          widget.product.productImage == null
              ? Image.asset(
                  'assets/noimage.png',
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  widget.product.productImage!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              widget.product.name!,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              '${widget.product.price}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Bid'))
        ],
      ),
    );
  }
}
