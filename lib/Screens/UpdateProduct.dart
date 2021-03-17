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

class UpdateProduct extends StatefulWidget {

  Product product;
  UpdateProduct({this.product});

  @override
  _UpdateProductState createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {

  String currentCategory;
  List<DropdownMenuItem<String>> dropDownCategoryItems;
  List categoryList = ["1st Category","2nd Category","3rd Category","4th Category","5th Category","6th Category",];
  PickedFile _image;
  Uint8List bytes;
  DBHelper dbHelper;


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

  void changedDropDownRegionItem(String selectedRegion) {
    setState(() {
      currentCategory = selectedRegion;
      widget.product.categoryName = selectedRegion;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownCategoryItems = getDropDownMenuRegionItems();
    currentCategory = widget.product.categoryName;
    dbHelper = DBHelper();
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar.getNavigationAppBar(title: "Update Product", context: context, color: kPrimaryColor, onPressed: (){Navigator.pop(context);}),
      body: Form(
        key: formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            SizedBox(height: 10,),
            FieldLabel("Product ID :"),
            TextFieldContainer(
              child: TextFormField(
                enabled: false,
                initialValue: widget.product.productId,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter Product ID";
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.product.productId = value;
                },
                keyboardType: TextInputType.number,
                autocorrect: false,
                cursorColor: Color(0xFF6F35A5),
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.red),
                  hintText: 'Enter Product ID',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 10,),
            FieldLabel("Product name :"),
            TextFieldContainer(
              child: TextFormField(
                initialValue: widget.product.productName,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter Product name";
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.product.productName = value;
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
                  initialValue: widget.product.productDesc,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter Product Description";
                    }
                    return null;
                  },
                  maxLines: null,
                  onChanged: (value) {
                    widget.product.productDesc = value;
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
                initialValue: widget.product.price,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter Product Price";
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.product.price = value;
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
                    child: _image == null ? Container(child: Image.memory(widget.product.productPic),) : Container(child: Image.file(File(_image.path),)),
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
                  onPressed: onUpdateProduct,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Update Product",style: TextStyle(color: kPrimaryLightColor,fontSize: 16),),
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

  _imgFromGallery() async {
    try {
      final pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery,imageQuality: 100);
      setState(() {
        bytes = null;
        _image = pickedFile;
        bytes = File(_image.path).readAsBytesSync();
        widget.product.productPic = bytes;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //BUTTON ION TAP FOR UPDATE
  onUpdateProduct() async {
    if(formKey.currentState.validate()){
      if(widget.product.productPic == null){
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar("You have to select Product Picture for your future reference"));
      }
      else{

        if(widget.product.productId == widget.product.productId){
          //ADD PRODUCT TO DATABASE
          updateProduct(widget.product);
          ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Your Product updated successfully"));
          Navigator.pop(context);
        }
        else{
          //CHECK THE PRODUCT ID IS UNIQUE OR NOT
          List ids = await dbHelper.getAllProductID();
          if(ids.contains(widget.product.productId)){
            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("This Product ID already exist"));
          }
          else{
            //ADD PRODUCT TO DATABASE
            updateProduct(widget.product);
            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Your Product updated successfully"));
            Navigator.pop(context);
          }
        }
      }
    }
    else{}
  }

  //UPDATE AND INSERT PRODUCT INTO DATABASE
  updateProduct(Product product){
    dbHelper.update(product).then((value){
      print(value);
    });
  }
}
