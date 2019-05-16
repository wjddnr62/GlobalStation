import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

import 'Bronze/bronzeB.dart';
import 'Bronze/bronzeC.dart';

import 'package:lms_flutter/bloc/speed_game_bloc.dart';

import 'package:lms_flutter/model/Speed/questionList.dart';
import 'package:lms_flutter/model/Speed/answerList.dart';

//List<Widget> bronzeData = [];

//class SpeedBronze extends StatefulWidget{
//
//  String level;
//  int chapter;
//
//  SpeedBronze({Key key, this.level, this.chapter}) : super(key: key);
//
//  @override
//  Bronze createState() => Bronze();
//}
//
//class Bronze extends State<SpeedBronze>{
//
//  @override
//  Widget build(BuildContext context) {
////    if(widget.type == "B"){
////      return BronzeB();
////    }else
////      return BronzeC();
//
//    speedBloc.getLevel(widget.level.substring(0,1));
//    speedBloc.getChapter(widget.chapter);
//    speedBloc.getStage(1);
//
//    return StreamBuilder(
//      stream: speedBloc.getQuestionList(),
//      builder: (context, snapshot){
//        print(snapshot.hasData);
//        if(snapshot.hasData){
//          String jsonValue = snapshot.data;
//          List<QuestionList> qList = speedBloc.questListToList(jsonValue);
//          print(jsonValue);
//          List<Widget> bronzeData = [];
//          for(QuestionList question in qList){
//            if (question.type == "B") bronzeData.add(
//                BronzeB(level: widget.level.substring(0,1),
//                  stage: 1,chapter: widget.chapter,question_num:
//                  question.question_num,title: question.title,)
//            );
//            else if(question.type == "C") bronzeData.add(
//                BronzeC(level: widget.level.substring(0,1),
//                  stage: 1,chapter: widget.chapter,question_num:
//                  question.question_num,title: question.title,)
//            );
//          }
////          return BronzeB(level: widget.level.substring(0,1),
////          stage: 1,chapter: widget.chapter,question_num:
////            qList[0].question_num,title: qList[0].title,);
////          for(int i=0; i< qList.length;i++){
//////            if(qList[i].type == "B") return BronzeB();
//////            else if(qList[i].type == "C") return BronzeC();
////          }
////          return bronzeData;
//
//          return SizedBox(width: 0,height: 0,);
//        }
//
//        return SizedBox(width: 0,height: 0,);
//      },
//    );
//
//
//  }
//}

//class SpeedBronze {
//  List<Widget> bronzeData = [];
//  String level;
//  int chapter;
//
//  SpeedBronze({this.level, this.chapter});
//
//  Future getDatas() async {
//    speedBloc.getLevel(level.substring(0, 1));
//    speedBloc.getChapter(chapter);
//    speedBloc.getStage(1);
//
//    final String jsonValue = await speedBloc.getQuestionList();
//
//    return jsonValue;
//  }
//
//  List<Widget> getViews() {
////    getDatas().then((json) {
////      print("json = "+json);
////      List<QuestionList> qList = speedBloc.questListToList(json);
////      for (QuestionList question in qList) {
////        if (question.type == "B")
////          bronzeData.add(BronzeB(
////            level: level.substring(0, 1),
////            stage: 1,
////            chapter: chapter,
////            question_num: question.question_num,
////            title: question.title,
////          ));
////        else if (question.type == "C")
////          bronzeData.add(BronzeC(
////            level: level.substring(0, 1),
////            stage: 1,
////            chapter: chapter,
////            question_num: question.question_num,
////            title: question.title,
////          ));
////      }
////      return bronzeData;
////    });
////    return FutureBuilder(
////      future: getDatas(),
////      builder: (context, snapshot) {
////        List<QuestionList> qList = speedBloc.questListToList(snapshot.data);
////        for (QuestionList question in qList) {
////          if (question.type == "B") {
////            bronzeData.add(BronzeB(
////              level: level.substring(0, 1),
////              stage: 1,
////              chapter: chapter,
////              question_num: question.question_num,
////              title: question.title,
////            ));
////          } else if (question.type == "C") {
////            bronzeData.add(BronzeC(
////              level: level.substring(0, 1),
////              stage: 1,
////              chapter: chapter,
////              question_num: question.question_num,
////              title: question.title,
////            ));
////          }
////        }
////        return bronzeData;
////      },
////    );
//  }
//}
class SpeedBronze{

  final List<QuestionList> qList;


  SpeedBronze({this.qList});

  List<Widget> views = [];

  List<Widget> getViews(){
    for (QuestionList question in qList) {
          if (question.type == "B") {
            views.add(BronzeB(
              level: question.level.substring(0, 1),
              stage: 1,
              chapter: question.chapter,
              question_num: question.question_num,
              title: question.title,
            ));
          } else if (question.type == "C") {
            views.add(BronzeC(
              level: question.level.substring(0, 1),
              stage: 1,
              question: question.contents,
              chapter: question.chapter,
              question_num: question.question_num,
              title: question.title,
            ));
          }
        }
    return views;
  }
}
