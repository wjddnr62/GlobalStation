import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class SpeedPhonics extends StatefulWidget{
  @override
  Phonics createState() => Phonics();
}

class Phonics extends State<SpeedPhonics>{
  String title = "Listen and choose the correct word.";

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: body(MediaQuery.of(context).size),);
  }
  
  Widget body(Size size){
    return Stack(
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          child: Image.asset("assets/gamebox/img/speed/speed/speed_phonics_bg.png",
          fit: BoxFit.cover,
          width: size.width,
          height: size.height,),
        ),

        Positioned(
          top: size.height / 2,
          child: Container(
            width: double.infinity,
            child: Center(child: Text(title),),
          ),
        ),

        Positioned(
          top: size.height / 2.5,
          right: 30,
          child: questionText("test1"),
        ),
        Positioned(
          top: size.height / 2.5,
          left: 30,
          child: questionText("test2"),
        ),
        Positioned(
          top: size.height / 4,
          right: 30,
          child: questionText("test3"),
        ),
        Positioned(
          top: size.height / 4,
          left: 30,
          child: questionText("test4"),
        ),

      ],
    );
  }

  Widget questionPicture(String data){
    return Stack(
      children: <Widget>[
        Image.asset("assets/gamebox/img/speed/balloon.png",
          width: 120,
          height: 200,
        ),
        Center(
          child: Image.network(data),
        ),
      ],
    );
  }
  Widget questionText(String data){
    return Stack(
      children: <Widget>[
        Image.asset("assets/gamebox/img/speed/balloon.png",
          width: 120,
          height: 200,
        ),
        Center(
            child: Text(data),
        ),
      ],
    );
  }

  Widget nextBtn(){

  }

}