import 'package:auctionapp/model/productModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  static const collectionProduct = 'Products';
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  static Future<void> addProduct(ProductModel productModel) {
    final WriteBatch = _db.batch();
    final productDoc = _db.collection(collectionProduct).doc();
    productModel.id = productDoc.id;
    WriteBatch.set(productDoc, productModel.toMap());
    return WriteBatch.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllProducts() =>
      _db.collection(collectionProduct).snapshots();

  static Stream<DocumentSnapshot<Map<String, dynamic>>> fetchProductByProductId(
          String productId) =>
      _db.collection(collectionProduct).doc(productId).snapshots();

  static Future<void> updateImageUrl(String url, String productId) {
    final doc = _db.collection(collectionProduct).doc(productId);
    return doc.update({'productImage': url});
  }
}
