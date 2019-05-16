import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lms_flutter/model/Speed/questionList.dart';

import 'phonics.dart';
import 'bronze.dart';
import 'silver.dart';
import 'gold.dart';
import 'diamond.dart';

import 'speed.dart';

import 'package:lms_flutter/bloc/speed_game_bloc.dart';

int viewidx;

class SpeedGameDialog extends StatefulWidget {
  String level;
  int chapter;
  int stage;

  SpeedGameDialog({Key key, this.level, this.chapter,this.stage}) : super(key: key);

  @override
  SpeedGameDialogState createState() => SpeedGameDialogState();
}

class SpeedGameDialogState extends State<SpeedGameDialog> {
  @override
  Widget build(BuildContext context) {
    print(widget.level);
    print(widget.chapter);
    print(widget.stage);
    speedBloc.getLevel(widget.level);
    speedBloc.getChapter(widget.chapter);
    speedBloc.getStage(widget.stage);
    return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: SafeArea(
          child: Padding(
            child: StreamBuilder(
              stream: speedBloc.getQuestionList(),
              builder: (context, snapshot) {
                print(snapshot.hasData);
                if (snapshot.hasData) {
                  String jsonValue = snapshot.data;
                  List<QuestionList> qList =
                  speedBloc.questListToList(jsonValue);
                  if (widget.level == "B")
                    return GameList(SpeedBronze(qList: qList).getViews(),MediaQuery.of(context).size);
                }
                return SizedBox(
                  width: 100.0,
                  height: 100.0,
                );
              },
            ),
            padding: const EdgeInsets.all(10),
          ),
        ));
  }
  Widget GameList(List<Widget> item,Size size) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, idx) {
        viewidx = idx;
//      return item[viewidx];
        return Stack(
          children: <Widget>[
            item[viewidx],
            Positioned(
              bottom: 50,
              child: nextBtn(size),
            ),
          ],
        );
      },
      itemCount: item.length,
    );
  }

  Widget nextBtn(Size size) {
    return InkWell(
      onTap: (){
        setState(() {
          viewidx++;
        });
      },
      child: Container(
        width: size.width - 20,
        height: 40,
        child: Center(
          child: Image.asset(
            "assets/gamebox/img/next_btn.png",
            width: 80,
            height: 40,
            fit: BoxFit.fill,
          ),
        ),

      ),
    );

  }

}


