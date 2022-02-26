import 'dart:io';

import 'package:auctionapp/constructor/customProgressbar.dart';
import 'package:auctionapp/model/productModel.dart';
import 'package:auctionapp/provider/productProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class productDetails extends StatefulWidget {
  productDetails({Key? key}) : super(key: key);
  static const String routeNames = 'ProductDetailsPage';

  @override
  State<productDetails> createState() => _productDetailsState();
}

class _productDetailsState extends State<productDetails> {
  late ProductProvider _productProvider;
  String? _productId;
  String? _productName;
  bool _isUploading = false;
  ImageSource _imageSource = ImageSource.camera;
  @override
  void didChangeDependencies() {
    _productProvider = Provider.of<ProductProvider>(context);
    super.didChangeDependencies();
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    _productId = argList[0];
    _productName = argList[1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_productName!),
      ),
      body: Center(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: _productProvider.getProductByProductId(_productId!),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final product = ProductModel.fromMap(snapshot.data!.data()!);
              return Stack(
                children: [
                  ListView(
                    children: [
                      product.productImage == null
                          ? Image.asset(
                              'assets/noimage.png',
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              product.productImage!,
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              _imageSource = ImageSource.gallery;
                              _getImage();
                            },
                            icon: const Icon(Icons.photo_camera),
                            label: const Text('Capture'),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              _imageSource = ImageSource.gallery;
                              _getImage();
                            },
                            icon: const Icon(Icons.photo),
                            label: const Text('Gallery'),
                          ),
                        ],
                      )
                    ],
                  ),
                  if (_isUploading)
                    const CustomProgressDialog('Please Wait Image is Updating'),
                ],
              );
            }
            if (snapshot.hasError) {
              return const Text('Failed to Fetch Data');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  void _getImage() async {
    final imageFile =
        await ImagePicker().pickImage(source: _imageSource, imageQuality: 75);
    if (imageFile != null) {
      setState(() {
        _isUploading = true;
      });
      _productProvider
          .uploadImage(File(imageFile.path), _productId, _productName)
          .then((value) {
        setState(() {
          _isUploading = false;
        });
      }).catchError((error) {
        setState(() {
          _isUploading = false;
        });
      });
    }
  }
}
