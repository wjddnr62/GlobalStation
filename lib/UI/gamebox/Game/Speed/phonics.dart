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
    return body(MediaQuery.of(context).size);
  }
  
  Widget body(Size size){
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,

            child: Image.asset("assets/gamebox/img/speed/speed_phonics_bg.png",
              fit: BoxFit.cover,
              width: size.width,
              height: size.height,),
          ),

          Positioned(
            top: size.height / 3.8,
            child: Container(
              width: size.width,
              child: Center(child: Text(title,style: titleTextStyle,),),
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
            top: size.height / 1.8,
            right: 30,
            child: questionText("test3"),
          ),
          Positioned(
            top: size.height / 1.8,
            left: 30,
            child: questionText("test4"),
          ),

          Positioned(
            bottom: 10,
            child: nextBtn(size),
          )
        ],
      ),
    );
  }

  Widget questionPicture(String data){
    return Container(
      width: 150,
      height: 250,
      child: Stack(
        children: <Widget>[
          Image.asset("assets/gamebox/img/speed/balloon.png",
            width: 150,
            height: 250,
            fit: BoxFit.contain,
          ),

          Align(
            alignment: AlignmentDirectional.topCenter,
            child: Container(
              width: 100,
              height: 100,
              child: Center(
                child: Image.network(data),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget questionText(String data){
    return Container(
      width: 150,
      height: 250,
      child: Stack(
        children: <Widget>[
          Image.asset("assets/gamebox/img/speed/balloon.png",
            width: 150,
            height: 250,
            fit: BoxFit.contain,
          ),

          Align(
            alignment: AlignmentDirectional.topCenter,
            child: Container(
              width: 100,
              height: 100,
              child: Center(
                child: Text(data,style: questionTextStyle,),
              ),
            ),
          ),
        ],
      ),
    );

  }

  Widget nextBtn(Size size){
    return Container(
      width: size.width,
      height: 55,
      child: Image.asset("assets/gamebox/img/next_btn.png",
      width: 100,
      height: 55,),
    );
  }

}