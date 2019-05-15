import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class QuizBronze extends StatefulWidget {
  @override
  Bronze createState() => Bronze();
}

class Bronze extends State<QuizBronze> {

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
            bottom: 55,
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
                        Text("_nt",style: quizTitleTextStyle,),
                        SizedBox(height: 15,),
                        Image.asset("assets/gamebox/img/quiz/quiz_info.png",
                          width: 150,),
                        SizedBox(height: 15,),
                        answerRow("A", "C"),
                        SizedBox(height: 10,),
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

  Widget answerRow(String ans1, String ans2){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        answer(ans1),
        SizedBox(width: 20,),
        answer(ans2),
      ],
    );
  }

  Widget answer(String answer) {
    return Container(
      width: 80,
      height: 50,
      decoration: quizBronzeBoxContainer,
      child: Center(
        child: Text(answer),
      ),
    );
  }

  Widget getImage(String img){
    return Container(
      width: 200,
      height: 80,
      color: Colors.red,
    );
  }

}
