import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_app/Constants/Constants.dart';
import 'package:sqflite_app/Screens/ListOfProduct.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openStartPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPrimaryLightColor,
      body: Stack(
        children: [
          Center(
              child: Text("WishList",style: TextStyle(color: kPrimaryColor,fontSize: 30,fontWeight: FontWeight.w600,fontFamily: "FredokaOne"),)
          ),
          Align(
            alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("SqfLite"),
                    Text("Version 1.0.0")
                  ],
                ),
              ))
        ],
      ),
    );
  }

  openStartPage() async {
    await Future.delayed(
        Duration(seconds: 2),
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => ListOfProduct()))
    );
  }
}
