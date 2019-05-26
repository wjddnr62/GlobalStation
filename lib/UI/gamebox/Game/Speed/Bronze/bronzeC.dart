import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/theme.dart';

int answer = 0;

class BronzeC extends StatefulWidget {

  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;

  BronzeC({Key key, this.level, this.chapter, this.stage, this.question_num,this.title,
    this.question})
      : super(key: key);

  @override
  Bronze createState() => Bronze();
}

class Bronze extends State<BronzeC> {
//  String title = "Listen and choose the correct answer.";
//  String question = "Good morning. How are You?asdkgafasd";

  final String C_POSTIT = "assets/gamebox/img/speed/postitC.png";
  final String D_POSTIT = "assets/gamebox/img/speed/postitD.png";

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
      child: Stack(
        children: <Widget>[
          Image.asset(
            "assets/gamebox/img/speed/speed_bronze_2.png",
            width: size.width,
            height: size.height,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: size.height / 5.5,
            width: size.width - 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                children: <Widget>[
                  Image.asset(
                    "assets/gamebox/img/speed/bronze_que.png",
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    top: 23,
                    left: 50,
                    child: Container(
                      width: size.width - 100,
                      height: 30,
                      child: Text(widget.question,style: speedBronzeQuestionStyle,),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height / 2.35,
            child: Container(
              width: size.width,
              child: Center(
                child: Text(
                  widget.title,
                  style: speedBronzeTitleStyle,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height / 2.15,
            child: postIt("D", "A", size,1),
          ),
          Positioned(
            top: size.height / 1.78,
            child: postIt("C", "B", size,2),
          ),
          Positioned(
            top: size.height / 1.52,
            child: postIt("D", "C", size,3),
          ),
          Positioned(
            top: size.height / 1.33,
            child: postIt("C", "D", size,4),
          ),

//          Positioned(
//            bottom: 10,
//            child: nextBtn(size),
//          ),
        ],
      ),
    );
  }

  int clickAnswer = 0;

  Widget postIt(String type, String text, Size size,int idx) {
    return Container(
      width: size.width - 10,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: (){
          answer = idx;
          speedBloc.answer = answer;
          setState(() {
            clickAnswer = idx;
            print(clickAnswer.toString());
          });
        },
        child: Stack(
          children: <Widget>[
            Image.asset(
              (type == "C") ? C_POSTIT : D_POSTIT,
              width: (idx == clickAnswer)? size.width - 30 : size.width - 50,
              height: 50,
              fit: BoxFit.cover,
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

  Widget nextBtn(Size size) {
    return Container(
      width: size.width,
      height: 50,
      child: Image.asset(
        "assets/gamebox/img/next_btn.png",
        width: 100,
        height: 50,
      ),
    );
  }
}
