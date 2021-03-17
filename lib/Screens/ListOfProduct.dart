import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sqflite_app/Constants/Constants.dart';
import 'package:sqflite_app/Database/DBHelper.dart';
import 'package:sqflite_app/Models/Products.dart';
import 'package:sqflite_app/Screens/AddProduct.dart';
import 'package:sqflite_app/Screens/UpdateProduct.dart';

class ListOfProduct extends StatefulWidget {
  @override
  _ListOfProductState createState() => _ListOfProductState();
}

class _ListOfProductState extends State<ListOfProduct> with SingleTickerProviderStateMixin {

  DBHelper dbHelper;
  static Products products;
  bool isProductsLoad = true;
  bool isPlaying = false;
  AnimationController _animationController;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    setState(() {
      isProductsLoad = true;
      getALLProducts();
    });
    _refreshController.refreshCompleted();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isProductsLoad = true;
    });
    dbHelper = DBHelper();
    getALLProducts();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){return SystemNavigator.pop(animated: false);},
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("WishList",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize:25,
                fontFamily: "FredokaOne",
                color: Colors.white
            ),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            splashColor: kPrimaryLightColor,
            icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
          ),
          onPressed: () {
            setState(() {
              isPlaying = !isPlaying;
              isPlaying ? _animationController.forward() : _animationController.reverse();
            });
          },
        ),
          actions: [
            IconButton(
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
          ],
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
        body: isProductsLoad ? Center(child: CircularProgressIndicator(backgroundColor: kPrimaryColor,)) :
        Container(
            padding: EdgeInsets.all(8.0),
            child: GridOfProduct()
        )
      ),
    );
  }

  // ignore: non_constant_identifier_names, missing_return
  Widget GridOfProduct(){
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: WaterDropHeader(),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: GridView.builder(
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
                          SizedBox(width:100,height: 30,child: Text(products.products[index].productDesc,style: TextStyle(color: Colors.black,fontSize: 12),)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0,bottom: 4.0),
                        child: Text("Rs."+products.products[index].price,style: TextStyle(color: Colors.black,fontSize: 12,fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                ),
                if(isPlaying) Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        deleteProductFromGrid(productId: products.products[index].productId,productName: products.products[index].productName);
                        setState(() {
                          isPlaying = false;
                          _animationController.reverse();
                        });
                      },
                      icon: Icon(Icons.delete,color: kPrimaryLightColor,size: 20,),),
                  ),
                ),
                if(isPlaying) Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProduct(product: products.products[index],)));
                        setState(() {
                          isPlaying = false;
                          _animationController.reverse();
                        });
                      },
                      icon: Icon(Icons.edit,color: kPrimaryLightColor,size: 20,),),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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

  deleteProductFromGrid({@required String productName, @required productId}){
    dbHelper.delete(productId).then((value){
      ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Your Product $productName removed"));
      getALLProducts();
    });
  }
}
