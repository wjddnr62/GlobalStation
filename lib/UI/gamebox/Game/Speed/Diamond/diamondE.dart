import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/theme.dart';

String answer="";

class DiamondE extends StatefulWidget {

  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;

  DiamondE({Key key, this.level, this.chapter, this.stage, this.question_num,this.title,
    this.question})
      : super(key: key);


  @override
  Diamond createState() => Diamond();
}

class Diamond extends State<DiamondE> {

  final String diaMessage = "assets/gamebox/img/speed/dia_ans.png";

  @override
  Widget build(BuildContext context) {
    speedBloc.answerType = 2;
    return body(MediaQuery.of(context).size);
  }

  Widget body(Size size) {
    return Container(
      width: size.width,
      height: size.height - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/gamebox/img/speed/speed_dia_4.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: size.height / 3.8,
            child: Container(
              width: size.width,
              child: Center(
                child: Text(
                  widget.title,
                  style: titleTextStyle,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height / 2.2,
            child: message("A", "___", size),
          ),
        ],
      ),
    );
  }

  Widget message(String type, String text, Size size) {
    return Container(
      width: size.width - 20,
      height: 50,
      padding: const EdgeInsets.only(left: 40,right: 10),
      child: Stack(
        children: <Widget>[
          Image.asset(
            diaMessage,
            width: size.width - 20,
            height: 50,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: AlignmentDirectional.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: input(),
            ),
          ),
        ],
      ),
    );
  }

  Widget input(){
    return TextField(
      decoration: InputDecoration(
        hintText: "_______________________",
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      onChanged: (value){
        speedBloc.answerA = value;
      },
    );
  }
}
