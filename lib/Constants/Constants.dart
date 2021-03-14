import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

final formKey = GlobalKey<FormState>();
GlobalKey<ScaffoldState> scaffoldKey;

showSnackBar(String msg){
  return SnackBar(
    backgroundColor: kPrimaryColor,
    content: Text(msg,style: TextStyle(color: kPrimaryLightColor,fontWeight: FontWeight.bold),),
    // action: SnackBarAction(
    //   label: "OK",
    //   onPressed: () {
    //     // Some code to undo the change.
    //   },
    // ),
  );
}
