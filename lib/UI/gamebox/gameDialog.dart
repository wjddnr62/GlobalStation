import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/theme.dart';

import 'Game/Speed/phonics.dart';
import 'Game/Speed/bronze.dart';
import 'Game/Speed/silver.dart';
import 'Game/Speed/gold.dart';
import 'Game/Speed/diamond.dart';

import 'Game/Quiz/Phonics/phonics.dart';
import 'Game/Quiz/Bronze//bronze.dart';
import 'Game/Quiz/Silver/silver.dart';
import 'Game/Quiz/Gold/gold.dart';
import 'Game/Quiz/Diamond/diamond.dart';

import 'Game/Matching/Phonics/phonics.dart';

class GameDialog extends StatefulWidget {
  @override
  GameDialogState createState() => GameDialogState();
}

class GameDialogState extends State<GameDialog> {
  String dialogType = "";
  String selectGame = "";

  bool startGame = false;

  @override
  void initState() {
    super.initState();
    dialogType = "K"; // K == GameKind | S == GameState
  }

  int idx;

  @override
  Widget build(BuildContext context) {
    if (startGame) {
      if (selectGame == "S") {
        return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: SafeArea(
              child: Padding(
                child: SpeedDiamond(),
                padding: const EdgeInsets.all(10),
              ),
            ));
      } else if (selectGame == "Q") {
        return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: SafeArea(
              child: Padding(
                child: QuizDiamond(),
                padding: const EdgeInsets.all(10),
              ),
            ));
      } else if (selectGame == "M") {
        return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.5),
            body: SafeArea(
              child: Padding(
                child: MatchPhonics(),
                padding: const EdgeInsets.all(10),
              ),
            ));
      }
    }
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: dialogType == "K"
            ? SafeArea(
                child: Padding(
                  child: selectGameKind(),
                  padding: const EdgeInsets.all(10),
                ),
              )
            : SafeArea(
                child: Padding(
                  child: selectGameStage(),
                  padding: const EdgeInsets.all(10),
                ),
              ));
  }

  Widget selectGameKind() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: dialogBackground),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/gamebox/img/lobby_logo.png",
            width: 120,
          ),
          Text(
            "Phonics 1",
            style: defaultTextStyle,
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          dialogType = "S";
                          selectGame = "S";
                        });
                      },
                      child: dialogView("SPEED GAME"),
                    ),
                  ),
                  defaultSpace(),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          dialogType = "S";
                          selectGame = "M";
                        });
                      },
                      child: dialogView("MATCHING GAME"),
                    ),
                  ),
                  defaultSpace(),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          dialogType = "S";
                          selectGame = "Q";
                        });
                      },
                      child: dialogView("QUIZ GAME"),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectGameStage() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: dialogBackground),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/gamebox/img/lobby_logo.png",
            width: 120,
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: ListView.builder(
                itemBuilder: (context, idx) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            startGame = true;
                          });
                        },
                        child: dialogView("STAGE " + (idx + 1).toString()),
                      ),
                    ),
                  );
                },
                itemCount: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget dialogView(String text) {
  return Container(
    width: double.infinity,
    decoration: dialogContainerDeco,
    child: Center(
      child: Text(
        text,
        style: dialogTextStyle,
      ),
    ),
  );
}

Widget defaultSpace() {
  return SizedBox(
    height: 30.0,
  );
}
