import 'package:flutter/material.dart';
import 'package:lms_flutter/model/UserInfo.dart';
import 'package:lms_flutter/theme.dart';

class MyPage extends StatelessWidget {
  final String defaultUrl = "assets/gamebox/img/mypage/";
  UserInfo userInfo = UserInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: body(context),
        ),
      ),
    );
  }

  Widget body(context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: beige,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: mainView(context),
    );
  }

  Widget mainView(context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/gamebox/img/mypage/background.png",
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Container(
          width: double.infinity,
          height: 60,
          child: topItem(context),
        ),
        Positioned(
          left: 30,
          top: 130,
          child: Container(
            child: nowLearning(context),
          ),
        ),
        Positioned(
          right: 60,
          top: 80,
          child: Container(
            child: myInfo(context),
          ),
        ),
        stageList(context),
      ],
    );
  }

  Widget nowLearning(context) {
    List level = userInfo.levelList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("현재 학습"),
        Text(level[userInfo.member_level]),
      ],
    );
  }

  Widget myInfo(context) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
        SizedBox(
          width: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text("코인"),
            Text(userInfo.member_coin.toString()),
          ],
        ),
      ],
    );
  }

  Widget stageList(context) {
    return Stack(
      children: <Widget>[
        stageImg(top: 270, left: 30, width: 80, height: 80, img: "1_stage.png",type: 2,idx: 1),
        stageImg(
            top: 260, left: 100, width: 80, height: 80, img: "2_stage.png",type: 1,idx: 2),
        stageImg(
            top: 250, left: 180, width: 90, height: 90, img: "3_stage.png",type: 2,idx: 3),
        stageImg(
            top: 300, left: 260, width: 80, height: 80, img: "4_stage.png",type: 1,idx: 4),
        stageImg(
            top: 350, left: 40, width: 140, height: 80, img: "5_stage.png",type: 2,idx: 5),
        stageImg(
            top: 330, left: 165, width: 80, height: 100, img: "6_stage.png",type: 1,idx: 6),
        stageImg(
            top: 330, left: 210, width: 80, height: 100, img: "7_stage.png",type: 2,idx: 7),
        stageImg(
            top: 380, left: 280, width: 50, height: 50, img: "8_stage.png",type: 1
            ,idx: 8),
        stageImg(top: 430, left: 40, width: 60, height: 60, img: "9_stage.png",type: 2,idx: 9),
        stageImg(
            top: 430, left: 110, width: 60, height: 60, img: "10_stage.png",type: 1,idx: 10),
        stageImg(
            top: 430, left: 180, width: 60, height: 60, img: "11_stage.png",type: 2,idx: 11),
        stageImg(
            top: 430, left: 250, width: 100, height: 60, img: "12_stage.png",type: 1,idx: 12),
        stageImg(
            top: 490, left: 40, width: 130, height: 60, img: "13_stage.png",type: 2,idx: 13),
        stageImg(
            top: 490, left: 190, width: 60, height: 60, img: "14_stage.png",type: 1,idx: 14),
        stageImg(
            top: 490, left: 270, width: 60, height: 60, img: "15_stage.png",type: 2,idx: 15),
      ],
    );
  }

  Widget stageImg(
      {double top,
      double bottom,
      double right,
      double left,
      double width,
      double height,
      String img,
        int idx,
      int type}) {
    return Positioned(
      top: top,
      bottom: bottom,
      right: right,
      left: left,
      child: Container(
          width: width,
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Image.asset(
                  defaultUrl + img,
                  fit: BoxFit.contain,
                ),
              ),

      (idx <= userInfo.member_level) ? Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  width: width / 2.5,
                  child: Image.asset(
                    defaultUrl + "complete${type}.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ) : SizedBox(width: 0,height: 0,),
            ],
          )),
    );
  }

  Widget topItem(context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.center,
            child: Text("MY PAGE"),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              child: Image.asset(
                "assets/gamebox/img/close_button.png",
                fit: BoxFit.contain,
                width: 30,
                height: 30,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
