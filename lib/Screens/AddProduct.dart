import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_app/Constants/Constants.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropDownCategoryItems = getDropDownMenuRegionItems();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.getNavigationAppBar(title: "Add Product", context: context, color: kPrimaryColor, onPressed: (){Navigator.pop(context);}),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: BouncingScrollPhysics(),
        children: [
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
                // employeeName = value;
              },
              keyboardType: TextInputType.text,
              autocorrect: false,
              cursorColor: Color(0xFF6F35A5),
              decoration: InputDecoration(
                errorStyle: TextStyle(color: kPrimaryColor),
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
                  // employeeName = value;
                },
                keyboardType: TextInputType.multiline,
                autocorrect: false,
                cursorColor: Color(0xFF6F35A5),
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: kPrimaryColor),
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
                // employeeName = value;
              },
              keyboardType: TextInputType.number,
              autocorrect: false,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                errorStyle: TextStyle(color: kPrimaryColor),
                hintText: 'Enter Product Price',
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 10,),
          FieldLabel("Product category :"),
          TextFieldContainer(
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                hint: Text("Select category"),
                value: currentCategory,
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
                onPressed: (){},
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
    );
  }

  void changedDropDownRegionItem(String selectedRegion) {
    setState(() {
      currentCategory = selectedRegion;
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

  _imgFromGallery() async {
    try {
      final pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery,);
      setState(() {
        _image = pickedFile;
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
