import 'package:sqflite_app/Models/Product.dart';

class Products{
  Products();

  List<Product> products;

  factory Products.fromMap(Map<String,dynamic> json) {
    return Products()
      ..products = json['products'] as List<Product>;
  }

  Map<String, dynamic> toJson(Products instance) => <String, dynamic> {
    'users' : instance.products
  };
}