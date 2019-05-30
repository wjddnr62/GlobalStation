import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'package:lms_flutter/model/Speed/answerList.dart';
import 'package:lms_flutter/theme.dart';

int answer = 0;

class GoldD1 extends StatefulWidget {

  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;
  final String question;
  final AudioPlayer audioPlayer;

  GoldD1({Key key, this.level, this.chapter, this.stage, this.question_num,this.title,
    this.question, this.audioPlayer})
      : super(key: key);

  @override
  Gold createState() => Gold();
}

class Gold extends State<GoldD1> {
//  String title = "Listen and choose the correct answer.";
//  String question = "Christina will bring some French Fries to the ________ _____ next week.";

  final String glodBrick = "assets/gamebox/img/speed/brick.png";

  AudioCache audioCache = AudioCache();
  AudioPlayer advancedPlayer = AudioPlayer();

  playSound(String level, String chapter,String stage, String question_num) {
    setState(() {
      advancedPlayer
          .play("http://ga.oig.kr/laon_api/api/asset/sound/${level}/${chapter}/S${stage}/${question_num}");
    });
  }

  @override
  void initState() {
    super.initState();
    playSound(widget.level, widget.chapter.toString(), widget.stage.toString(), widget.question_num.toString());
  }

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
    final bool iphonex = MediaQuery.of(context).size.height >= 812.0;

    return Container(
      width: size.width,
      height: (iphonex) ? size.height - 97 : size.height - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: StreamBuilder(
        stream: speedBloc.getAnswerList(widget.question_num),
        builder: (context, snapshot){
          if(snapshot.hasData){

            String jsonValue = snapshot.data;
            List<AnswerList> answerList = speedBloc.answerListToList(jsonValue);

            return Stack(
              children: <Widget>[
                Image.asset(
                  "assets/gamebox/img/speed/speed_gold_2.png",
                  width: size.width,
                  height: size.height,
                  fit: BoxFit.fill,
                ),
                Positioned(
                  top: size.height / 3.3,
                  width: size.width - 20,
                  child: Container(
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Image.asset(
                            "assets/gamebox/img/speed/gold_que2.png",
                            fit: BoxFit.contain,
                          ),
                        ),

                        Positioned(
                          top: 30,
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
                  top: size.height / 3.9,
                  child: Container(
                    width: size.width,
                    child: Center(
                      child: Text(
                        widget.title,
                        style: speedGoldTitleText,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: size.height / 2.22,
                  child: brick("A", answerList[0].contents, size,1),
                ),
                Positioned(
                  top: size.height / 1.8,
                  child: brick("B", answerList[1].contents, size,2),
                ),
                Positioned(
                  top: size.height / 1.52,
                  child: brick("C", answerList[2].contents, size,3),
                ),
                Positioned(
                  top: size.height / 1.315,
                  child: brick("D", answerList[3].contents, size,4),
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

  Widget brick(String type, String text, Size size,int idx) {
    return Container(
      width: size.width - 20,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child:InkWell(
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
              glodBrick,
              width: size.width - 20,
              height: 600,
              fit: BoxFit.fill,
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Text(text, style: speedGoldQuestionStyle,),
            ),
            Align(
                alignment: AlignmentDirectional.centerStart,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(type, style: speedGoldQuestionStyle,),
                )
            )
          ],
        ),
      ),
    );
  }

}
