class Product{

  Product();

  // static String table = 'products';
  // int id;
  String productName;
  String categoryName;
  String productDesc;
  String price;
  String productPic;

  factory Product.fromMap(Map<String, dynamic> map){
    return Product()
        // ..id = map['id'] as int
        ..productName = map['productName'] as String
        ..categoryName = map['categoryName'] as String
        ..productDesc = map['productDesc'] as String
        ..price = map['price'] as String
        ..productPic = map['productPic'] as String;
  }

  Map<String, dynamic> toMap(Product instance) => <String, dynamic> {
    // "id" : instance.id,
    "productName" : instance.productName,
    "categoryName" : instance.categoryName,
    "productDesc" : instance.productDesc,
    "price" : instance.price,
    "productPic" : instance.productPic
  };

}