import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_app/Constants/Constants.dart';
import 'package:sqflite_app/Database/DBHelper.dart';
import 'package:sqflite_app/Models/Product.dart';
import 'package:sqflite_app/Widgets/CustomAppbar.dart';
import 'package:sqflite_app/Widgets/TextFieldContainer.dart';
import 'package:sqflite_app/Widgets/staticFieldlabel.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  String currentCategory;
  List<DropdownMenuItem<String>> dropDownCategoryItems;
  List categoryList = ["1st Category","2nd Category","3rd Category","4th Category","5th Category","6th Category",];
  PickedFile _image;
  Product product;
  DBHelper dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    product = Product();
    dropDownCategoryItems = getDropDownMenuRegionItems();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar.getNavigationAppBar(title: "Add Product", context: context, color: kPrimaryColor, onPressed: (){Navigator.pop(context);}),
      body: Form(
        key: formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          // physics: BouncingScrollPhysics(),
          children: [
            // SizedBox(height: 10,),
            // FieldLabel("Product ID :"),
            // TextFieldContainer(
            //   child: TextFormField(
            //     validator: (value) {
            //       if (value.isEmpty) {
            //         return "Please enter Product ID";
            //       }
            //       return null;
            //     },
            //     onChanged: (value) {
            //       // product.id = int.parse(value);
            //     },
            //     keyboardType: TextInputType.number,
            //     autocorrect: false,
            //     cursorColor: Color(0xFF6F35A5),
            //     decoration: InputDecoration(
            //       errorStyle: TextStyle(color: Colors.red),
            //       hintText: 'Enter Product ID',
            //       border: InputBorder.none,
            //     ),
            //   ),
            // ),
            SizedBox(height: 10,),
            FieldLabel("Product name :"),
            TextFieldContainer(
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter Product name";
                  }
                  return null;
                },
                onChanged: (value) {
                  product.productName = value;
                },
                keyboardType: TextInputType.text,
                autocorrect: false,
                cursorColor: Color(0xFF6F35A5),
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                  hintText: 'Enter Product Name',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 10,),
            FieldLabel("Product description :"),
            SizedBox(
              height: 140,
              child: TextFieldContainer(
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter Product Description";
                    }
                    return null;
                  },
                  maxLines: null,
                  onChanged: (value) {
                    product.productDesc = value;
                  },
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  cursorColor: Color(0xFF6F35A5),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    hintText: 'Enter Product Description',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            FieldLabel("Product price :"),
            TextFieldContainer(
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter Product Price";
                  }
                  return null;
                },
                onChanged: (value) {
                  product.price = value;
                },
                keyboardType: TextInputType.number,
                autocorrect: false,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                  hintText: 'Enter Product Price',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 10,),
            FieldLabel("Product category :"),
            TextFieldContainer(
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0,right: 5.0,top: 10,bottom: 10),
                child: DropdownButtonFormField(
                  decoration: InputDecoration.collapsed(hintText: ''),
                  validator: (value) => value == null
                      ? 'Please select category' : null,
                  hint: Text("Select category"),
                  value: currentCategory,
                  isExpanded: true,
                  items: dropDownCategoryItems,
                  onChanged: changedDropDownRegionItem,
                ),
              ),
            ),
            SizedBox(height: 10,),
            FieldLabel("Product Picture :"),
            SizedBox(
              height: 300,
              child: GestureDetector(
                onTap: _imgFromGallery,
                child: TextFieldContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _image == null ? Icon(
                      Icons.add_a_photo_rounded,
                      size: 100,
                      color: kPrimaryColor,
                    ) : Container(child:  Image.file(File(_image.path),)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),topLeft: Radius.circular(30)),
                ),
                child: TextButton(
                  onPressed: onAddProduct,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Save Product",style: TextStyle(color: kPrimaryLightColor,fontSize: 16),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  void changedDropDownRegionItem(String selectedRegion) {
    setState(() {
      currentCategory = selectedRegion;
      product.categoryName = selectedRegion;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuRegionItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String category in categoryList) {
      items.add(new DropdownMenuItem(
          value: category,
          child: new Text(category, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black, fontFamily: "Popmed",)))
      );
    }
    return items;
  }

  Uint8List bytes;

  _imgFromGallery() async {
    try {
      final pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      setState(() {
        bytes = null;
        _image = pickedFile;
        bytes = File(_image.path).readAsBytesSync();
        product.productPic = bytes;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  onAddProduct(){
    if(formKey.currentState.validate()){
      if(product.productPic == null){
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar("You have to select Product Picture for your future reference"));
      }
      else{
        //ADD PRODUCT TO DATABASE
        insertProduct(product);
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Your Product saved successfully"));
        Navigator.pop(context);
      }
    }
    else{}
  }

  //INSERT PRODUCT INTO DATABASE
  insertProduct(Product product){
    dbHelper.save(product).then((value){
      print(value);
    });
  }


}
