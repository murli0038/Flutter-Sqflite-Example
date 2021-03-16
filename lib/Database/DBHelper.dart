import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import 'package:sqflite_app/Models/Product.dart';
import 'package:sqflite_app/Models/Products.dart';

class DBHelper{
  static Database _db;
  static const String TABLE = "products";
  static const String PRODUCT_ID = "productId";
  static const String PRODUCT_NAME = "productName";
  static const String CATEGORY_NAME = "categoryName";
  static const String PRODUCT_DESCRIPTION = "productDesc";
  static const String PRICE = "price";
  static const String PRODUCT_PIC = "productPic";
  static const String DB_NAME = "products.db";

  Future<Database> get db async
  {
    if(null != _db){
      return _db;
    }
    _db = await initDB();
    getAllProductID();
    return _db;
  }

  initDB() async
  {
    // GET THE DEVICE'S DOCUMENT DIRECTORY TO STORE DATA TO OFFLINE DATABASE
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print(documentsDirectory.path);
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async
  {
    //CREATE THE DATABASE TABLE
    await db.execute("CREATE TABLE $TABLE ($PRODUCT_ID TEXT,$PRODUCT_NAME TEXT, $CATEGORY_NAME TEXT, $PRODUCT_DESCRIPTION TEXT, $PRICE TEXT, $PRODUCT_PIC BLOB)");
  }

  Future<Product> save(Product product) async {
    var dbClient = await db;
    // THIS LINE WILL INSERT THE ALBUM OBJECT TO THE DATABASE AFTER CONVERTING IT TO A JSON
    await dbClient.insert(TABLE, product.toMap(product));
    return product;
  }

  //METHOD TO FETCH ALL ALBUMS FROM DATABASE
  Future<Products> getAllProducts() async {
    var dbClient = await db;
    // SPECIFY THE COLUMN NAMES YOU WANT IN THR RESULT SET
    List<Map> maps = await dbClient.query(TABLE, columns: [PRODUCT_ID,PRODUCT_NAME,CATEGORY_NAME,PRODUCT_DESCRIPTION,PRICE,PRODUCT_PIC]);
    Products allProducts = Products();
    List<Product> products = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        products.add(Product.fromMap(maps[i]));
      }
    }
    allProducts.products = products;
    return allProducts;
  }

  // METHOD TO DELETE AN ALBUM FROM DATABASE
  Future<int> delete(String productId) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$PRODUCT_ID = ?', whereArgs: [productId]);
  }

  // METHOD TO UPDATE AN ALBUM FROM DATABASE
  //   Future<int> update(Album album) async {
  //     var dbClient = await db;
  //     return await dbClient
  //         .update(TABLE, album.toJson(album), where: '$ID = ?', whereArgs: [album.id]);
  //   }

    // METHOD TO TRUNCATE THE TABLE
    Future<void> truncateTable() async {
      var dbClient = await db;
      return await dbClient.delete(TABLE);
    }

    // METHOD TO CLOSE THE DATABASE
    Future close() async {
      var dbClient = await db;
      dbClient.close();
    }


    //METHOD FOR RETRIVE THE ALL PRODUCT ID FROM DATABASE
    // ignore: missing_return
    Future<List> getAllProductID() async
    {
      var dbClient = await db;
      List<Map> maps = await dbClient.query(TABLE, columns: [PRODUCT_ID]);
      List ids = [];
      maps.forEach((element) {
        ids.add(element['productId']);
      });
      return ids;
    }

}