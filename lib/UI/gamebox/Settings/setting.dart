import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'character.dart';

class SettingsPage extends StatelessWidget {
  AudioPlayer audioPlayer;

  SettingsPage({Key key, this.audioPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
      child: mainColumn(context),
    );
  }

  Widget mainColumn(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          child: topItem(context),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: skyBlue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Setting",
                    textAlign: TextAlign.center,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              GestureDetector(
                child: boxContainer("캐릭터 커스텀 변경"),
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (context, _, __) => CharacterPage(),
                  ));
                },
              ),
              InkWell(
                onTap: () {
//                  Navigator.popUntil(context, ModalRoute.withName('/Login'));
                  audioPlayer.stop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: boxContainer("메인 선택화면으로 이동"),
              ),
              InkWell(
                onTap: () {
                  _launchURL();
                },
                child: boxContainer("GEC 홈페이지"),
              ),
              boxContainer("서비스 이용약관"),
              boxContainer("개인정보 취급 방침"),
              Padding(
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Ver. 1.0.1",
                    textAlign: TextAlign.right,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Image.asset(
              "assets/gamebox/img/gec.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget boxContainer(String msg) {
    return Container(
      decoration: dialogContainerDeco,
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Center(
        child: Text(
          msg,
          style: defaultTextStyle,
        ),
      ),
    );
  }

  Widget topItem(context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.center,
            child: Image.asset(
              "assets/gamebox/img/lobby_logo.png",
              width: 120,
            ),
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
                Navigator.of(context).pop("pop");
              },
            ),
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://www.isgec.or.kr/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
