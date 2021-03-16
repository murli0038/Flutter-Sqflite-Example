import 'dart:typed_data';

class Product{

  Product();

  // static String table = 'products';
  String productId;
  String productName;
  String categoryName;
  String productDesc;
  String price;
  Uint8List productPic;

  factory Product.fromMap(Map<String, dynamic> map){
    return Product()
        ..productId = map['productId'] as String
        ..productName = map['productName'] as String
        ..categoryName = map['categoryName'] as String
        ..productDesc = map['productDesc'] as String
        ..price = map['price'] as String
        ..productPic = map['productPic'] as Uint8List;
  }

  Map<String, dynamic> toMap(Product instance) => <String, dynamic> {
    "productId" : instance.productId,
    "productName" : instance.productName,
    "categoryName" : instance.categoryName,
    "productDesc" : instance.productDesc,
    "price" : instance.price,
    "productPic" : instance.productPic
  };

}