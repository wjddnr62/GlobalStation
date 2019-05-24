import 'package:flutter/material.dart';

import '../../../theme.dart';

class Result extends StatefulWidget {
  String level;
  int chapter;
  int stage;
  int score;
  int scoreLength;
  double sizeWidth;
  Function resetGame;
  Function resultNextGame;

  Result(
      {Key key,
      this.level,
      this.chapter,
      this.stage,
      this.score,
      this.scoreLength,
      this.sizeWidth,
      this.resetGame,
      this.resultNextGame})
      : super(key: key);

  @override
  ResultView createState() => ResultView();
}

class ResultView extends State<Result> {
  String level_full;
  String resultImgUrl;
  Function nextGame;
  Function resetGame;

  level_set() {
    if (widget.level == "P") {
      level_full = "Phonics";
    } else if (widget.level == "B") {
      level_full = "Bronze";
    } else if (widget.level == "S") {
      level_full = "Silver";
    } else if (widget.level == "G") {
      level_full = "Gold";
    } else if (widget.level == "D") {
      level_full = "Diamond";
    }
    nextGame = widget.resultNextGame;
    resetGame = widget.resetGame;
  }

  resultImgSet() {
    double parent = widget.score / widget.scoreLength * 100;
    if (parent < 25) {
      resultImgUrl = "assets/gamebox/img/effect/1.png";
    } else if (parent > 25 && parent < 50) {
      resultImgUrl = "assets/gamebox/img/effect/2.png";
    } else if (parent > 50 && parent < 75) {
      resultImgUrl = "assets/gamebox/img/effect/3.png";
    } else if (parent > 75 && parent < 100) {
      resultImgUrl = "assets/gamebox/img/effect/4.png";
    } else if (parent >= 100) {
      resultImgUrl = "assets/gamebox/img/effect/5.png";
    }
  }

  Widget result() {
    level_set();
    resultImgSet();
    return Align(
      alignment: Alignment.topCenter,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                level_full + " ${widget.chapter}",
                style: resultTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Stage ",
                    style: TextStyle(
                        color: black,
                        fontSize: defaultFontSize + 8,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Jua"),
                    children: <TextSpan>[
                      TextSpan(
                        text: widget.stage.toString(),
                        style: TextStyle(
                            color: resultStageColor,
                            fontSize: defaultFontSize + 8,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Jua"),
                      )
                    ]),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                resultImgUrl,
                width: 300,
                height: 300,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: "${widget.score.toString()}",
                      style: TextStyle(
                          fontSize: defaultFontSize,
                          fontFamily: 'Jua',
                          fontWeight: FontWeight.bold,
                          color: resultStageColor),
                      children: <TextSpan>[
                        TextSpan(
                            text: " / ${widget.scoreLength.toString()}",
                            style: TextStyle(
                                fontSize: defaultFontSize,
                                fontFamily: 'Jua',
                                fontWeight: FontWeight.bold,
                                color: black))
                      ])),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => resetGame
                      ,
                      child: Image.asset(
                        "assets/gamebox/img/effect/back_btn.png",
                        width: 100,
                        height: 50,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => widget.resultNextGame,
                      child: Image.asset(
                        "assets/gamebox/img/effect/next_btn.png",
                        width: 100,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget body() {
    return Container(
      width: widget.sizeWidth,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.topCenter,
            child: Container(
              width: widget.sizeWidth,
              child: result(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return body();
  }
}
