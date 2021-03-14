import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

final formKey = GlobalKey<FormState>();
GlobalKey<ScaffoldState> scaffoldKey;


void showToast(String msg,BuildContext context, {int duration, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity,backgroundColor: kPrimaryLightColor,textColor: kPrimaryColor);
}

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
