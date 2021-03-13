class Category {
  Category();

  static String table = 'product_categories';

  String categoryName;
  int categoryId;

  factory Category.fromMap(Map<String, dynamic> map){
    return Category()
        ..categoryId = map['categoryId']
        ..categoryName = map['categoryName'];
  }
  Map<String, dynamic> toMap(Category instance) => <String, dynamic> {
    "categoryId" : instance.categoryId,
    "categoryName" : instance.categoryName
  };
}