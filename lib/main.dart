import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_app/Constants/Constants.dart';
import 'package:sqflite_app/Screens/ListOfProduct.dart';
import 'package:sqflite_app/Screens/SplashScreen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    statusBarBrightness: Brightness.dark,//status bar brigtness
    statusBarIconBrightness:Brightness.dark , //status barIcon Brightness
    systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        accentColor: kPrimaryLightColor
      ),
    );
  }
}
