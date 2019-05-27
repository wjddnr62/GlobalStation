import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/model/Speed/answerList.dart';
import 'package:lms_flutter/theme.dart';

class PhonicsB extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;

  PhonicsB(
      {Key key,
      this.level,
      this.chapter,
      this.stage,
      this.question_num,
      this.title})
      : super(key: key);

  @override
  Phonics createState() => Phonics();
}

class Phonics extends State<PhonicsB> {
//  String title = "Listen and choose the correct word.";

  @override
  Widget build(BuildContext context) {
    speedBloc.answerType = 1;
    speedBloc.getLevel(widget.level);
    speedBloc.getChapter(widget.chapter);
    speedBloc.getStage(widget.stage);
    speedBloc.question_num = widget.question_num;
    clickAnswer = speedBloc.answer;
    return body(MediaQuery.of(context).size);
  }

  Widget body(Size size) {
    return Container(
      width: size.width,
      height: size.height - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: StreamBuilder(
          stream: speedBloc.getAnswerList(widget.question_num),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String jsonValue = snapshot.data;
              List<AnswerList> answerList =
                  speedBloc.answerListToList(jsonValue);
              return Stack(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: size.height,
                    child: Image.asset(
                      "assets/gamebox/img/speed/speed_phonics_bg.png",
                      fit: BoxFit.fill,
                      width: size.width,
                      height: size.height,
                    ),
                  ),
                  Positioned(
                    top: size.height / 3.6,
                    child: Container(
                      width: size.width,
                      child: Center(
                        child: Text(
                          widget.title,
                          style: speedPhonicsTitleStyle,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height / 2.5,
                    right: 30,
                    child: questionText(answerList[0].contents, 1),
                  ),
                  Positioned(
                    top: size.height / 2.5,
                    left: 30,
                    child: questionText(answerList[1].contents, 2),
                  ),
                  Positioned(
                    top: size.height / 1.8,
                    right: 30,
                    child: questionText(answerList[2].contents, 3),
                  ),
                  Positioned(
                    top: size.height / 1.8,
                    left: 30,
                    child: questionText(answerList[3].contents, 4),
                  ),
                ],
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }

  int clickAnswer = 0;

  Widget questionText(String data, int idx) {
    return Container(
      width: 160,
      height: 270,
      child: InkWell(
        onTap: () {
          speedBloc.answer = idx;
          setState(() {
            clickAnswer = idx;
          });
        },
        child: Stack(
          children: <Widget>[
            Image.asset(
              "assets/gamebox/img/speed/balloon.png",
              width: 160,
              height: 270,
              fit: BoxFit.contain,
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Container(
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                    data,
                    textScaleFactor: (clickAnswer == idx) ? 1.5 : 1.0,
                    style: questionTextStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
