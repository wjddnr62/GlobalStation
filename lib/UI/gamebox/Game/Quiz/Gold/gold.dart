import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/quiz_game_bloc.dart';
import 'package:lms_flutter/model/Quiz/answerList.dart';
import 'package:lms_flutter/theme.dart';

class QuizG extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String title;

  QuizG(
      {Key key,
      this.level,
      this.chapter,
      this.stage,
      this.question_num,
      this.title})
      : super(key: key);

  @override
  Gold createState() => Gold();
}

class Gold extends State<QuizG> {
  @override
  Widget build(BuildContext context) {
    quizBloc.getLevel(widget.level);
    quizBloc.getChapter(widget.chapter);
    quizBloc.getStage(widget.stage);
    quizBloc.question_num = widget.question_num;
    clickAnswer = quizBloc.answer;
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
        stream: quizBloc.getAnswerList(widget.question_num),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                  bottom: 35,
                  child: Container(
                    width: size.width - 20,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Image.asset(
                            "assets/gamebox/img/quiz/quiz_blue.png",
                            fit: BoxFit.fill,
                            width: 300,
                            height: 310,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: 200,
                                height: 100,
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    widget.title,
                                    style: TextStyle(
                                      fontSize: defaultFontSize,
                                      color: black,
                                      fontFamily: 'Jua',
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset(
                                "assets/gamebox/img/quiz/quiz_info.png",
                                width: 130,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              answerRow(answerList[0].contents,
                                  answerList[1].contents, 1),
                              SizedBox(
                                height: 10,
                              ),
                              answerRow(answerList[2].contents,
                                  answerList[3].contents, 2),
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

  Widget answerRow(String ans1, String ans2, int type) {
    int ans1Num = 0;
    int ans2Num = 0;
    if (type == 1) {
      ans1Num = 1;
      ans2Num = 2;
    } else {
      ans1Num = 3;
      ans2Num = 4;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        answer(ans1, ans1Num),
        SizedBox(
          width: 20,
        ),
        answer(ans2, ans2Num),
      ],
    );
  }

  Widget answer(String answer, int num) {
    return Container(
      width: 100,
      height: 40,
      decoration: (clickAnswer == num)
          ? quizGoldSelectBoxContainer
          : quizGoldBoxContainer,
      child: InkWell(
        onTap: () {
          setState(() {
            clickAnswer = num;
          });
          quizBloc.answer = num;
        },
        child: Center(
          child: Text(
            answer,
            style: TextStyle(color: white),
          ),
        ),
      ),
    );
  }
}
