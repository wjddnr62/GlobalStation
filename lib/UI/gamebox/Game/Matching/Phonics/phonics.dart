import 'package:flutter/material.dart';
import 'package:lms_flutter/bloc/match_game_bloc.dart';
import 'package:lms_flutter/model/Match/answerList.dart';

int answer = 0;

class Phonics extends StatefulWidget {
  final String level;
  final int chapter;
  final int stage;
  final int question_num;

  Phonics({Key key, this.level, this.chapter, this.stage, this.question_num})
      : super(key: key);

  @override
  PhonicsM createState() => PhonicsM();
}

class PhonicsM extends State<Phonics> {
  String shell1Close = "assets/gamebox/img/match/shell_close.png";
  String shell1Open = "assets/gamebox/img/match/shell.png";

  String shell2Close = "assets/gamebox/img/match/shell2_close.png";
  String shell2Open = "assets/gamebox/img/match/shell2.png";

  String default_pic = "http://ga.oig.kr/laon_api/api/asset/";

  List<AnswerList> answerList = new List();

  List<shellData> firstShell = new List();
  List<shellData> secondShell = new List();

  List<shellParam> shell_param = new List();

//  Map<int, String> enDatas = {9: "book", 13: "cloud", 14: "cow"};
//
//  Map<int, String> picDatas = {
//    9: "/image/P/1/S1/book",
//    13: "/image/P/1/S1/cloud",
//    14: "/image/P/1/S1/book"
//  };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    matchBloc.getLevel(widget.level);
    matchBloc.getChapter(widget.chapter);
    matchBloc.getStage(widget.stage);
    matchBloc.question_num = widget.question_num;
    return body(MediaQuery.of(context).size);
  }

  Widget body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: StreamBuilder(
        stream: matchBloc.getAnswerList(widget.question_num),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String jsonValue = snapshot.data;
            answerList = matchBloc.answerListToList(jsonValue);
            for (int i = 0; i < 3; i++) {
              if (answerList[i].en == null || answerList[i].en == "") {
                firstShell.add(shellData(1, true, answerList[i].img));
              } else {
                firstShell.add(shellData(2, true, answerList[i].en));
              }
            }
            for (int i = 3; i < 6; i++) {
              if (answerList[i].en == null || answerList[i].en == "") {
                secondShell.add(shellData(1, true, answerList[i].img));
              } else {
                secondShell.add(shellData(2, true, answerList[i].en));
              }
            }
//            print("match_list_length : " + firstShell.length.toString() + ", " + secondShell.length.toString());
            return Stack(
              children: <Widget>[
                Container(
                  width: size.width,
                  height: size.height,
                  child: Image.asset(
                    "assets/gamebox/img/match/18.png",
                    fit: BoxFit.fill,
                    width: size.width,
                    height: size.height,
                  ),
                ),
                Positioned(
                  top: size.width / 3.5,
                  child: Container(
                    width: size.width - 20,
                    height: 360,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          "assets/gamebox/img/match/17.png",
                          width: size.width - 20,
                          height: 360,
                          fit: BoxFit.fill,
                        ),
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              rowData(1),
                              rowData(2),
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

  Widget rowData(int upDown) {
    return (upDown == 1)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              shell(firstShell[0].type, firstShell[0].isOpen,
                  firstShell[0].param),
              shell(firstShell[1].type, firstShell[1].isOpen,
                  firstShell[1].param),
              shell(firstShell[2].type, firstShell[2].isOpen,
                  firstShell[2].param),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              shell(secondShell[0].type, secondShell[0].isOpen,
                  secondShell[0].param),
              shell(secondShell[1].type, secondShell[1].isOpen,
                  secondShell[1].param),
              shell(secondShell[2].type, secondShell[2].isOpen,
                  secondShell[2].param),
            ],
          );
  }

  Widget shell(int type, bool isOpen, String param) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (type == 1) {

          } else if (type == 2) {
            secondShell.remove(2);
            secondShell.insert(2, shellData(2, false, answerList[4].en));
            rowData(1);
            rowData(2);
          }
//          isOpen = false;
          print(isOpen.toString());
          print("shell click : " + type.toString());

          print(isOpen.toString());
        });
      },
      child: Container(
        width: 100,
        height: 100,
        child: Center(
          child: (type == 1)
              ? Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Image.network(
                    default_pic + param,
                    width: 50,
                    height: 50,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    param,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Jua',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage((type == 1)
                  ? isOpen ? shell1Open : shell1Close
                  : isOpen ? shell2Open : shell2Close)),
        ),
      ),
    );
  }
}

class shellData {
  final int type;
  final bool isOpen;
  final String param;

  shellData(this.type, this.isOpen, this.param);
}

class shellParam {
  final BoxDecoration boxDecoration;
  final String param;

  shellParam(this.boxDecoration, this.param);
}
