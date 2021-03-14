import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_app/Constants/Constants.dart';
import 'package:sqflite_app/Database/DBHelper.dart';
import 'package:sqflite_app/Models/Products.dart';
import 'package:sqflite_app/Screens/AddProduct.dart';

class ListOfProduct extends StatefulWidget {
  @override
  _ListOfProductState createState() => _ListOfProductState();
}

class _ListOfProductState extends State<ListOfProduct> {

  DBHelper dbHelper;
  static Products products;
  bool isProductsLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isProductsLoad = true;
    });
    dbHelper = DBHelper();
    getALLProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Wish-List",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize:25,
              fontFamily: "Popmed",
              color: Colors.white
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));},
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add,color: kPrimaryLightColor,),
      ),
      body: isProductsLoad ? Center(child: CircularProgressIndicator()) : Container(
          padding: EdgeInsets.all(8.0),
          child: GridOfProduct()
      )
    );
  }

  // ignore: non_constant_identifier_names, missing_return
  Widget GridOfProduct(){
    return GridView.builder(
      itemCount: products.products == null ? 0 : products.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0
      ),
      itemBuilder: (BuildContext context, int index)
      {
        return Container(
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(products.products[index].productName),
                  Text(products.products[index].productDesc),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.delete,color: kPrimaryColor,size: 20,),),
              ),
            ],
          ),
        );
      },
    );
  }

  getALLProducts(){
    dbHelper.getAllProducts().then((productsFromDatabase){
      setState(() {
        products = productsFromDatabase;
        print(products.products.length);
        isProductsLoad = false;
      });
    });
  }
}
