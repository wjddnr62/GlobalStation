import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';
import 'package:lms_flutter/model/Speed/answerList.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';

class BronzeB extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;

  BronzeB({Key key, this.level, this.chapter, this.stage, this.question_num,this.title})
      : super(key: key);

  @override
  Bronze createState() => Bronze();
}

class Bronze extends State<BronzeB> {


  final String A_POSTIT = "assets/gamebox/img/speed/postitA.png";
  final String B_POSTIT = "assets/gamebox/img/speed/postitB.png";

  @override
  Widget build(BuildContext context) {
    speedBloc.getLevel(widget.level);
    speedBloc.getChapter(widget.chapter);
    speedBloc.getStage(widget.stage);
    return body(MediaQuery.of(context).size);
  }

  Widget body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      child: StreamBuilder(
        stream: speedBloc.getAnswerList(widget.question_num),
        builder: (context, snapshot){
          print("BB");
          print(snapshot.hasData);
          if(snapshot.hasData){
            String jsonValue = snapshot.data;
            print(jsonValue);
            List<AnswerList> answerList = speedBloc.answerListToList(jsonValue);

            return Stack(
              children: <Widget>[
                Image.asset(
                  "assets/gamebox/img/speed/speed_bronze_1.png",
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: size.height / 3.5,
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
                  left: 20,
                  top: size.height / 2.5,
                  child: postIt("A", answerList[0].contents),
                ),
                Positioned(
                  right: 20,
                  top: size.height / 2.5,
                  child: postIt("B", answerList[1].contents),
                ),
                Positioned(
                  left: 20,
                  top: size.height / 1.6,
                  child: postIt("B", answerList[2].contents),
                ),
                Positioned(
                  right: 20,
                  top: size.height / 1.6,
                  child: postIt("A", answerList[3].contents),
                ),
                
//                Align(
//                  alignment: AlignmentDirectional.bottomCenter,
//                  child: nextBtn(size),
//                ),
              ],
            );
          }

          return CircularProgressIndicator();
        },
      )
    );
  }

  Widget postIt(String type, String text) {
    return Container(
      width: 150,
      height: 160,
      child: Stack(
        children: <Widget>[
          Image.asset(
            (type == "A") ? A_POSTIT : B_POSTIT,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
          Center(child: Text(text),)
        ],
      ),
    );
  }

  Widget nextBtn(Size size) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: size.width,
        height: 40,
        child: Image.asset(
          "assets/gamebox/img/next_btn.png",
          width: 100,
          height: 40,
        ),
      ),
    );

  }
}
