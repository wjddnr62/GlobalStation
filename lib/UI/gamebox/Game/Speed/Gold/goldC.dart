import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/model/Speed/answerList.dart';
import 'package:lms_flutter/theme.dart';

int answer = 0;

class GoldC extends StatefulWidget {

  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;

  GoldC({Key key, this.level, this.chapter, this.stage, this.question_num,this.title,
    this.question})
      : super(key: key);

  @override
  Gold createState() => Gold();
}

class Gold extends State<GoldC> {
  final String goldBrick = "assets/gamebox/img/speed/brick.png";

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
        builder: (context, snapshot){
          if(snapshot.hasData) {
            String jsonValue = snapshot.data;
            List<AnswerList> answerList = speedBloc.answerListToList(jsonValue);

            return Stack(
              children: <Widget>[
                Image.asset(
                  "assets/gamebox/img/speed/speed_gold_1.png",
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: size.height / 7.5,
                  width: size.width - 20,
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child:Image.asset(
                            "assets/gamebox/img/speed/gold_que1.png",
                            fit: BoxFit.contain,
                          ),
                        ),

                        Positioned(
                          top: 25,
                          left: 55,
                          child: Container(
                            width: size.width - 100,
                            child:Center(
                              child: Text(
                                widget.question,
                                style: speedGoldQuestionStyle,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height / 2.55,
                  child: Container(
                    width: size.width,
                    child: Center(
                      child: Text(
                        widget.title,
                        style: speedGoldTitleTextC,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height / 2.22,
                  child: brick("A", size,1),
                ),
                Positioned(
                  top: size.height / 1.8,
                  child: brick( "B", size,2),
                ),
                Positioned(
                  top: size.height / 1.52,
                  child: brick("C", size,3),
                ),
                Positioned(
                  top: size.height / 1.315,
                  child: brick("D", size,4),
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

  Widget brick(String text, Size size, int idx) {
    return Container(
      width: size.width - 20,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: (){
          answer = idx;
          speedBloc.answer = answer;
          setState(() {
            clickAnswer = idx;
          });
        },
        child: Stack(
          children: <Widget>[
            Image.asset(
              goldBrick,
              width: (idx == clickAnswer) ? size.width - 30: size.width - 50,
              height: 60,
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
