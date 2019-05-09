import 'package:flutter/material.dart';


//---size-----------------------------
final defaultFontSize = 16.0;
//------------------------------------

//---color----------------------------
final black = Colors.black;
final white = Colors.white;
final dialogBoxColor = Color.fromARGB(255, 253, 209, 64);
final dialogBoxShadow = Color.fromARGB(255, 225, 148, 53);
final dialogBackground = Color.fromARGB(255, 214, 233, 234);

//------------------------------------

//---textStyle------------------------
final defaultTextStyle = TextStyle(fontSize: defaultFontSize, color: black);
final dialogTextStyle = TextStyle(
    fontSize: defaultFontSize, color: black, fontWeight: FontWeight.bold); // + 주아체

//color
final WhiteColor = Color(0xFFFFFFFF);
final bookboxmainColor = Color(0xFFFB6969);
final backgroudDefaultColor = Color(0xFFF6F6F6);
final lineColor = Color(0xFFDDDDDD);
final greenColor = Color(0xFF2AA787);
//------------------------------------

//---boxDecoration--------------------
final dialogContainerDeco = BoxDecoration(
    color: dialogBoxColor,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: dialogBoxShadow,
        offset: Offset(0.0, 10.0),
      )
    ]);
//------------------------------------
