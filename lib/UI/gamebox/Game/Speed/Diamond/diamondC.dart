import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/model/Speed/answerList.dart';
import 'package:lms_flutter/theme.dart';

int answer = 0;

class DiamondC extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;

  DiamondC(
      {Key key,
      this.level,
      this.chapter,
      this.stage,
      this.question_num,
      this.title,
      this.question})
      : super(key: key);

  @override
  Diamond createState() => Diamond();
}

class Diamond extends State<DiamondC> {
  final String diamondMessage = "assets/gamebox/img/speed/message.png";

  @override
  Widget build(BuildContext context) {
    speedBloc.answerType = 1;
    speedBloc.getLevel(widget.level);
    speedBloc.getChapter(widget.chapter);
    speedBloc.getStage(widget.stage);
    speedBloc.question_num = widget.question_num;
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
            List<AnswerList> answerList = speedBloc.answerListToList(jsonValue);
            return Stack(
              children: <Widget>[
                Image.asset(
                  "assets/gamebox/img/speed/speed_dia_1.png",
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: size.height / 5.5,
                  width: size.width - 20,
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            "assets/gamebox/img/speed/dia_que.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          top: 23,
                          left: 55,
                          child: Container(
                            width: size.width - 100,
                            child: Center(
                              child: Text(
                                widget.question,
                                style: speedDiaQuestionStyle,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height / 2.4,
                  child: Container(
                    width: size.width,
                    child: Center(
                      child: Text(
                        widget.title,
                        style: speedDiaTitleTextC,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height / 2,
                  child: message("A", size, 1),
                ),
                Positioned(
                  top: size.height / 1.7,
                  child: message("B", size, 2),
                ),
                Positioned(
                  top: size.height / 1.48,
                  child: message("C", size, 3),
                ),
                Positioned(
                  top: size.height / 1.31,
                  child: message("D", size, 4),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  int clickAnswer = 0;

  Widget message(String text, Size size, int idx) {
    return Container(
      width: (idx == clickAnswer) ? size.width - 10 : size.width - 20,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: () {
          clickAnswer = idx;
          setState(() {
            speedBloc.answer = idx;
          });
        },
        child: Stack(
          children: <Widget>[
            Image.asset(
              diamondMessage,
              width: size.width - 20,
              height: 50,
              fit: BoxFit.fill,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
