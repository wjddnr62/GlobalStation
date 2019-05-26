import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/quiz_game_bloc.dart';
import 'package:lms_flutter/model/Quiz/answerList.dart';
import 'package:lms_flutter/theme.dart';

class QuizP extends StatefulWidget {

  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;

  QuizP({Key key, this.level, this.chapter, this.stage, this.question_num,this.title})
      : super(key: key);

  @override
  Phonics createState() => Phonics();
}

class Phonics extends State<QuizP> {

  @override
  Widget build(BuildContext context) {
    quizBloc.getLevel(widget.level);
    quizBloc.getChapter(widget.chapter);
    quizBloc.getStage(widget.stage);
    quizBloc.question_num = widget.question_num;
    return body(MediaQuery.of(context).size);
  }

  Widget body(Size size) {

    return Container(
      width: size.width,
      height: size.height - 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: StreamBuilder(
        stream: quizBloc.getAnswerList(widget.question_num),
        builder: (context, snapshot){
          if(snapshot.hasData){
            String jsonValue = snapshot.data;
            List<AnswerList> answerList = quizBloc.answerListToList(jsonValue);
            return Stack(
              children: <Widget>[
                Container(
                  width: size.width,
                  height: size.height,
                  child: Image.asset(
                    "assets/gamebox/img/quiz/quiz_background.png",
                    fit: BoxFit.fill,
                    width: size.width,
                    height: size.height,
                  ),
                ),
                Positioned(
                  bottom: 50,
                  child: Container(
                    width: size.width - 20,
                    child: Stack(
                      children: <Widget>[

                        Align(
                          alignment: AlignmentDirectional.center,
                          child:Image.asset(
                            "assets/gamebox/img/quiz/quiz_white_2.png",
                            fit: BoxFit.fill,
                            width: 300,
                            height: 280,
                          ),
                        ),

                        Align(
                          alignment: AlignmentDirectional.center,
                          child:  Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              getImage(""),
                              Text(widget.title,style: quizTitleTextStyle,),
                              SizedBox(height: 15,),
                              Image.asset("assets/gamebox/img/quiz/quiz_info.png",
                                width: 150,),
                              SizedBox(height: 15,),
                              answerRow(answerList[0].contents, answerList[1].contents,1),
                              SizedBox(height: 10,),
                              answerRow(answerList[2].contents, answerList[3].contents,2),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
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

  Widget answerRow(String ans1, String ans2,int type){
    int ans1Num = 0;
    int ans2Num = 0;
    if (type == 1){
      ans1Num = 1;
      ans2Num = 2;
    }else {
      ans1Num = 3;
      ans2Num = 4;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        answer(ans1,ans1Num),
        SizedBox(width: 20,),
        answer(ans2,ans2Num),
      ],
    );
  }

  Widget answer(String answer,int num) {
    return Container(
      width: 80,
      height: 50,
      decoration: (clickAnswer == num) ? quizPhonicsSelectBoxContainer : quizPhonicsBoxContainer,
      child: InkWell(
        onTap: (){
          setState(() {
            clickAnswer = num;
          });
          quizBloc.answer = num;
        },
        child: Center(
          child: Text(answer),
        ),
      ),
    );
  }

  Widget getImage(String img){
    return Container(
      width: 200,
      height: 80,
//      color: Colors.red,
    );
  }

}
