import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  String? name;
  String? description;
  String? productImage;
  num price;
  Timestamp? productTimestamp;
  int year;
  int month;
  int day;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.productImage,
    this.price = 0.0,
    this.productTimestamp,
    required this.year,
    required this.month,
    required this.day,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'productImage': productImage,
      'price': price,
      'timestamp': productTimestamp,
      'year': year,
      'month': month,
      'day': day,
    };
    return map;
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      productImage: map['productImage'],
      price: map['price'] ?? 0,
      productTimestamp: map['timestamp'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
    );
  }
}
