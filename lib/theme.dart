import 'package:flutter/material.dart';

//---size-----------------------------
final defaultFontSize = 16.0;
final unitFontSize = 12.0;
//------------------------------------

//---color----------------------------
final black = Colors.black;
final white = Colors.white;
final dialogBoxColor = Color.fromARGB(255, 253, 209, 64);
final dialogBoxShadow = Color.fromARGB(255, 225, 148, 53);
final dialogBackground = Color.fromARGB(255, 214, 233, 234);
final quizPhonicsColor = Color.fromARGB(255, 254, 227, 77);
final quizPhonicsSelectColor = Color.fromARGB(255, 254, 227, 244);
final quizBronzeColor = Color.fromARGB(255, 247, 81, 86);
final quizBronzeSelectColor = Color.fromARGB(255, 247, 81, 244);
final quizSilverColor = Color.fromARGB(255, 44, 173, 151);
final quizSilverSelectColor = Color.fromARGB(255, 44, 173, 244);
final quizGoldColor = Color.fromARGB(255, 51, 143, 208);
final quizGoldSelectColor = Color.fromARGB(255, 51, 143, 255);
final quizDiamondColor = Color.fromARGB(255, 117, 65, 180);
final quizDiamondSelectColor = Color.fromARGB(255, 117, 65, 255);
final beige = Color.fromARGB(255 ,255, 255, 231);
final skyBlue = Color.fromARGB(255, 215, 234, 235);

//------------------------------------

//---textStyle------------------------
final defaultTextStyle = TextStyle(fontSize: defaultFontSize, color: black);
final dialogTextStyle = TextStyle(
    fontSize: defaultFontSize,
    color: black,
    fontFamily: 'Jua',
    fontWeight: FontWeight.bold); // + 주아체
final questionTextStyle = TextStyle(
  fontSize: defaultFontSize,
  color: black,
  fontFamily: 'Jua',
  fontWeight: FontWeight.w500,
);
final titleTextStyle = TextStyle(
  fontSize: defaultFontSize - 2,
  color: black,
  fontFamily: 'Jua',
  fontWeight: FontWeight.bold,

);
final quizTitleTextStyle = TextStyle(
  fontSize: defaultFontSize + 8,
  color: black,
  fontFamily: 'Jua',
  fontWeight: FontWeight.bold,
);

final levelTextStyle = TextStyle(
  fontSize: defaultFontSize - 2,
  color: black,
  fontFamily: 'Jua',
  fontWeight: FontWeight.bold,
);

final resultTextStyle = TextStyle(
  fontSize: defaultFontSize + 12,
  color: white,
  fontFamily: 'Jua',
  fontWeight: FontWeight.bold,
);

//color
final WhiteColor = Color(0xFFFFFFFF);
final bookboxmainColor = Color(0xFFFB6969);
final backgroudDefaultColor = Color(0xFFF6F6F6);
final lineColor = Color(0xFFDDDDDD);
final greenColor = Color(0xFF2AA787);
final yellowColor = Color(0xFFFCCA20);
final unitColor = Color(0xFFFFFBF6);
final backbtnbackgroundColor = Color(0xFFE8E8E8);
final backbtnColor = Color(0xFF8A8A8A);
final resultStageColor = Color(0xFFF76666);
final StatusBarLeftColor = Color(0xFF29a787);
final StatusBarRightColor = Color(0xFFffd851);
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

final quizPhonicsBoxContainer = BoxDecoration(
  color: quizPhonicsColor,
  borderRadius: BorderRadius.circular(5.0),
);

final quizPhonicsSelectBoxContainer = BoxDecoration(
  color: quizPhonicsSelectColor,
  borderRadius: BorderRadius.circular(5.0),
);

final quizBronzeBoxContainer = BoxDecoration(
  color: quizBronzeColor,
  borderRadius: BorderRadius.circular(5.0),
);

final quizBronzeSelectBoxContainer = BoxDecoration(
  color: quizBronzeSelectColor,
  borderRadius: BorderRadius.circular(5.0),
);

final quizSilverBoxContainer = BoxDecoration(
  color: quizSilverColor,
  borderRadius: BorderRadius.circular(5.0),
);

final quizSilverSelectBoxContainer = BoxDecoration(
  color: quizSilverSelectColor,
  borderRadius: BorderRadius.circular(5.0),
);

final quizGoldBoxContainer = BoxDecoration(
  color: quizGoldColor,
  borderRadius: BorderRadius.circular(5.0),
);

final quizGoldSelectBoxContainer = BoxDecoration(
  color: quizGoldSelectColor,
  borderRadius: BorderRadius.circular(5.0),
);

final quizDiamondBoxContainer = BoxDecoration(
  color: quizDiamondColor,
  borderRadius: BorderRadius.circular(5.0),
);

final quizDiamondSelectBoxContainer = BoxDecoration(
  color: quizDiamondSelectColor,
  borderRadius: BorderRadius.circular(5.0),
);
//------------------------------------
