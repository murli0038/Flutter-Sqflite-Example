class Product{

  Product();

  static String table = 'products';
  int id;
  String productName;
  int categoryId;
  String productDesc;
  double price;
  String productPic;

  factory Product.fromMap(Map<String, dynamic> map){
    return Product()
        ..id = map['id'] as int
        ..productName = map['productName'] as String
        ..categoryId = map['categoryId'] as int
        ..productDesc = map['productDesc'] as String
        ..price = map['price'] as double
        ..productPic = map['productPic'] as String;
  }

  Map<String, dynamic> toMap(Product instance) => <String, dynamic> {
    "id" : instance.id,
    "productName" : instance.productName,
    "categoryId" : instance.categoryId,
    "productDesc" : instance.productDesc,
    "price" : instance.price,
    "productPic" : instance.productPic
  };


}