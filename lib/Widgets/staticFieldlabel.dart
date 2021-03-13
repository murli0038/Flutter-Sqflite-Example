import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_app/Constants/Constants.dart';

// ignore: non_constant_identifier_names, missing_return
Widget FieldLabel(String labelName){
  return Padding(
    padding: EdgeInsets.only(left: 15,right: 10,top: 5),
    child: Text(
      labelName,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: kPrimaryColor
      ),
    ),
  );
}