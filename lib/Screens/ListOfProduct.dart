import 'dart:ui';

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
        actions: [
          IconButton(icon: Icon(Icons.refresh_sharp), onPressed: (){
            setState(() {
              isProductsLoad = true;
              getALLProducts();
            });
          }),
        ],
        leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                setState(() {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: kPrimaryColor,
                      content: Text(
                        "Are you sure to Delete Database??",
                        style: TextStyle(
                            color: kPrimaryLightColor,
                            fontWeight: FontWeight.bold),
                      ),
                      action: SnackBarAction(
                        label: "Delete",
                        onPressed: () {
                          isProductsLoad = true;
                          deleteAllProduct();},
                      )));
                });
              });
            }),
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
      body: isProductsLoad ? Center(child: CircularProgressIndicator(backgroundColor: kPrimaryColor,)) : Container(
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
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: MemoryImage(products.products[index].productPic,),
              fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0,left: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width:100,child: Text(products.products[index].productName,style: TextStyle(color: kPrimaryColor,fontSize: 15,fontWeight: FontWeight.bold),)),
                        SizedBox(width:100,child: Text(products.products[index].productDesc,style: TextStyle(color: Colors.black,fontSize: 12),)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0,bottom: 4.0),
                      child: Text("Rs."+products.products[index].price,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  backgroundColor: kPrimaryLightColor,
                  child: IconButton(
                    onPressed: (){
                      deleteProductFromGrid(products.products[index].productName);
                    },
                    icon: Icon(Icons.delete,color: kPrimaryColor,size: 20,),),
                ),
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

  deleteAllProduct(){
    dbHelper.truncateTable().then((value){
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Your all Product(s) are removed"));
      getALLProducts();
    });
  }

  deleteProductFromGrid(String productName){
    dbHelper.delete(productName).then((value){
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Your Product $productName removed"));
      getALLProducts();
    });
  }
}
