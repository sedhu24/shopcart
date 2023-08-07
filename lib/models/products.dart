// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:shopcart/models/rating.dart';

class Products {
  final String? id;

  final String productName;
  final String description;
  final String category;
  final int quantity;
  final double price;
  final List<String> imageUrls;
  final List<Rating>? rating;
  Products({
    this.id,
    required this.productName,
    required this.description,
    required this.category,
    required this.quantity,
    required this.price,
    required this.imageUrls,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'description': description,
      'category': category,
      'quantity': quantity,
      'price': price,
      'images': imageUrls,
      'rating': rating,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['_id'] != null ? map['_id'] as String : null,
      productName: map['productName'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      quantity: map['quantity'] as int,
      price: map['price']?.toDouble() ?? 0.0,
      imageUrls: List<String>.from(
        (map['images'] as List<dynamic>),
      ),
      rating: map['ratings'] != null
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source) as Map<String, dynamic>);
}
