import 'dart:io';

import 'package:auctionapp/constructor/dbHelper.dart';
import 'package:auctionapp/model/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];

  Future<void> saveProduct(ProductModel productModel) {
    return DBHelper.addProduct(productModel);
  }

  void getAllProducts() {
    DBHelper.fetchAllProducts().listen((event) {
      productList = List.generate(event.docs.length,
          (index) => ProductModel.fromMap(event.docs[index].data()));
      notifyListeners();
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getProductByProductId(
      String productId) {
    return DBHelper.fetchProductByProductId(productId);
  }

  Future<void> uploadImage(
      File imageFile, String? productId, String? productName) async {
    final rootRef = FirebaseStorage.instance.ref();
    final imageRef = rootRef.child(
        '$productName/${productName}_${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = imageRef.putFile(imageFile);
    final snapshot =
        await uploadTask.whenComplete(() {}).catchError((error) {});
    final url = await snapshot.ref.getDownloadURL();
    await updateImageUrl(url, productId!);
  }

  Future<void> updateImageUrl(String url, String productId) {
    return DBHelper.updateImageUrl(url, productId);
  }
}
