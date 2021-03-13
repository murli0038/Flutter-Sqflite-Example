
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar {

  static getNavigationAppBar({@required String title,@required BuildContext context,@required Color color,@required Function onPressed}) {
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 17,), onPressed: onPressed,),
      automaticallyImplyLeading: false,
      title: Text(title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            fontFamily: "Popmed",
            color: Colors.white
        ),),
      elevation: 0,
      centerTitle: true,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
    );
  }
}