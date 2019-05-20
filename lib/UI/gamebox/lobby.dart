import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lms_flutter/UI/gamebox/Settings/character.dart';
import 'package:lms_flutter/UI/gamebox/Settings/setting.dart';
import 'gameDialog.dart';
import 'package:lms_flutter/model/UserInfo.dart';
import 'package:audioplayers/audioplayers.dart';

class LobbyPage extends StatefulWidget {
  @override
  LobbyHomePage createState() => LobbyHomePage();
}

class LobbyHomePage extends State<LobbyPage> {
//  AudioPlayer audioPlayer = new AudioPlayer();
//
//  play() async {
//    int result = await audioPlayer.play("assets/gamebox/audio/backgroundmusic.mp3",isLocal: true);
//    if (result == 1){
//      print("suc");
//    }
//  }

  int level = UserInfo().member_level;

  List<String> lobbyImg = [
    "assets/gamebox/img/lobby/english_basic.png",
    "assets/gamebox/img/lobby/cambodia_lobby_basic.png",
    "assets/gamebox/img/lobby/indea_lobby_basic.png",
    "assets/gamebox/img/lobby/usa_lobby_basic.png",
    "assets/gamebox/img/lobby/brazil_lobby_basic.png",
    "assets/gamebox/img/lobby/egypt_lobby_basic.png",
    "assets/gamebox/img/lobby/noth_lobby_basic.png",
    "assets/gamebox/img/lobby/korea_lobby_basic.png",
    "assets/gamebox/img/lobby/paris_lobby_basic.png",
    "assets/gamebox/img/lobby/sydney_lobby_basic.png",
    "assets/gamebox/img/lobby/kenya_lobby_basic.png",
    "assets/gamebox/img/lobby/hawaii_lobby_basic.png",
    "assets/gamebox/img/lobby/greec_lobby_basic.png",
    "assets/gamebox/img/lobby/mexico_lobby_basic.png",
    "assets/gamebox/img/lobby/china_lobby_basic.png",
  ];

  Widget body(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      child: lobby(size),
    );
  }

  Widget lobby(Size size) {
    return Stack(
      children: <Widget>[
        swipe(size),
        Align(
          alignment: AlignmentDirectional.topCenter,
          child: Image.asset(
            "assets/gamebox/img/lobby_logo.png",
            fit: BoxFit.contain,
            width: 120,
            height: 100,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: InkWell(
                onTap: () {
                  setCharacter();
                },
                child: Image.asset(
                  "assets/gamebox/img/btn_myinfo.png",
                  fit: BoxFit.contain,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: InkWell(
                onTap: () {
                  settings();
                },
                child: Image.asset(
                  "assets/gamebox/img/btn_setting.png",
                  fit: BoxFit.contain,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Image.asset(
            "assets/gamebox/img/navi.png",
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  Widget swipe(Size size) {
    return Swiper(
      itemBuilder: (context, idx) {
        return InkWell(
          onTap: () {
            if (idx < level) {
              var lev = "";
              var cap = 0;
              if (idx <= 2) {
                lev = "P";
                cap = idx + 1;
              } else if (idx <= 5) {
                lev = "B";
                cap = idx - 2;
              } else if (idx <= 8) {
                lev = "S";
                cap = idx - 5;
              } else if (idx <= 11) {
                lev = "G";
                cap = idx - 8;
              } else if (idx <= 14) {
                lev = "D";
                cap = idx - 11;
              }

              gameStart(idx, lev, cap);
            }
          },
          child: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    lobbyImg[idx],
                    fit: BoxFit.cover,
                  ),
                ),
                (idx + 1 > level)
                    ? Positioned.fill(
                        child: Container(
                          color: Color.fromARGB(100, 0, 0, 0),
                        ),
                      )
                    : SizedBox(
                        width: 0,
                      ),
              ],
            ),
          ),
        );
      },
      itemCount: lobbyImg.length,
      pagination: SwiperPagination(),
      scrollDirection: Axis.horizontal,
      loop: false,
    );
  }

  void gameStart(int idx, String lev, int cap) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => GameDialog(
              idx: idx,
              lev: lev,
              cap: cap,
            )));
  }

  void settings() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __) => SettingsPage(),
    ));
  }

  void setCharacter() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __) => CharacterPage(),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("level = ${level}");
  }

  @override
  Widget build(BuildContext context) {
//    play();
    return Scaffold(
      body: body(MediaQuery.of(context).size),
    );
  }
}
