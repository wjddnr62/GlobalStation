import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class QuizDiamond extends StatefulWidget {
  @override
  Diamond createState() => Diamond();
}

class Diamond extends State<QuizDiamond> {
  @override
  Widget build(BuildContext context) {
    return body(MediaQuery.of(context).size);
  }

  Widget body(Size size) {
    print(size.width);
    print(size.width / 2);

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: size.width,
            height: size.height,
            child: Image.asset(
              "assets/gamebox/img/quiz/quiz_background.png",
              fit: BoxFit.cover,
              width: size.width,
              height: size.height,
            ),
          ),
          Positioned(
            bottom: 30,
            child: Container(
              width: size.width - 20,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Image.asset(
                      "assets/gamebox/img/quiz/quiz_purple.png",
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
                        SizedBox(height: 30,),
                        Container(
                          width: 200,
                          height: 100,
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Text("Johnson and his sister ___ tall and fat"),
                          ),

                        ),

                        Image.asset(
                          "assets/gamebox/img/quiz/quiz_info.png",
                          width: 130,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        answerRow("A", "C"),
                        SizedBox(
                          height: 10,
                        ),
                        answerRow("B", "D"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget answerRow(String ans1, String ans2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        answer(ans1),
        SizedBox(
          width: 20,
        ),
        answer(ans2),
      ],
    );
  }

  Widget answer(String answer) {
    return Container(
      width: 100,
      height: 40,
      decoration: quizDiamondBoxContainer,
      child: Center(
        child: Text(answer,style: TextStyle(color: white),),
      ),
    );
  }
}
