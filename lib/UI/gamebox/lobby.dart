import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lms_flutter/UI/gamebox/Settings/character.dart';
import 'package:lms_flutter/UI/gamebox/Settings/setting.dart';
import 'package:lms_flutter/UI/gamebox/public/Tutorial.dart';
import 'package:lms_flutter/bloc/game_public_bloc.dart';
import 'package:lms_flutter/bloc/member_bloc.dart';
import 'package:lms_flutter/model/UserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Settings/mypage.dart';
import 'gameDialog.dart';

String hair = "#e04736";
String eye = "#334666";
String skin = "#d97e57";
int style = 1;

int hats = 0;
String hatUrl = "";

int hair_style = 1;
int hair_color = 1;
int eye_color = 1;
int skin_color = 1;
int hat_shape = 0;

var hairColors = [
  "#e04736",
  "#f24970",
  "#ffc247",
  "#d1d426",
  "#855729",
  "#332d2d",
  "#1c2957"
];
var eyeColors = ["#334666", "#5e4327", "#241e1e"];
var skinColors = ["#d97e57", "#ff8585", "#ffcba3"];
var hatUrls = [
  "assets/gamebox/img/charactor/hat/hat3.png",
  "assets/gamebox/img/charactor/hat/hat2.png",
  "assets/gamebox/img/charactor/hat/hat1.png"
];

class LobbyPage extends StatefulWidget {
  @override
  LobbyHomePage createState() => LobbyHomePage();
}

class LobbyHomePage extends State<LobbyPage> {
  GamePublicBloc gamePublicBloc = GamePublicBloc();

  AudioCache audioCache;
  AudioPlayer advancedPlayer = AudioPlayer();

  int level = UserInfo().member_level;

  SharedPreferences sharedPreferences;
  bool tutoCheck = false;

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
        SafeArea(
          child: Align(
            alignment: AlignmentDirectional.topCenter,
            child: Image.asset(
              "assets/gamebox/img/lobby_logo.png",
              fit: BoxFit.contain,
              width: 120,
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: InkWell(
                onTap: () {
                  myPage();
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
          child: Container(
            width: double.infinity,
            height: 85,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    "assets/gamebox/img/navi.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  left: 10,
                  child: Container(
                    width: 70,
                    height: 80,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          controller.previous();
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  child: Container(
                    width: 70,
                    height: 80,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          controller.next();
                        });
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Container(
                    width: 80,
                    height: 80,
                    child: InkWell(
                      onTap: () {
                        gameStart(viewIdx, viewlev, viewCap);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 90,
          left: 20,
          child: Container(
            width: 100,
            height: 100,
            child: Center(
              child: Character(),
            ),
          ),
        ),
      ],
    );
  }

  int viewIdx;
  int viewCap;
  String viewlev;
  int currentIdx = 0;
  SwiperController controller = new SwiperController();

  Widget swipe(Size size) {
    return Swiper(
      index: currentIdx,
      controller: controller,
      onIndexChanged: (index) {
        setState(() {
          currentIdx = index;
          print(currentIdx.toString());
        });
      },
      itemBuilder: (context, idx) {
        if (idx <= level) {
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
          viewIdx = idx;
          viewCap = cap;
          viewlev = lev;
        }

        return InkWell(
          onTap: () {
            print(idx.toString());
            if (idx <= level) {
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
              viewIdx = idx;
              viewCap = cap;
              viewlev = lev;

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
                (idx > level)
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
    print("gameStart idx : " + idx.toString());
    gamePublicBloc.idx = idx;
    print("gameBloc idx : " + gamePublicBloc.idx.toString());
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => GameDialog(
              idx: idx,
              lev: lev,
              cap: cap,
              audioPlayer: advancedPlayer,
            )));
  }

  void settings() {
    Navigator.of(context)
        .push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __) => SettingsPage(
            audioPlayer: advancedPlayer,
          ),
    ))
        .then((value) {
      print("settings bAck");
      mbloc.getMember().then((jsonValue) {
        print(jsonValue);
        setState(() {
          print("settings Set State");
          hair_style = json.decode(jsonValue)['data']['hair_type'];
          hair_color = json.decode(jsonValue)['data']['hair_color'];
          eye_color = json.decode(jsonValue)['data']['eye_color'];
          skin_color = json.decode(jsonValue)['data']['skin_color'];
          hat_shape = json.decode(jsonValue)['data']['hat'];
          style = hair_style;
          hats = hat_shape;
          if (hat_shape != 0) {
            hatUrl = hatUrls[hat_shape - 1];
          }
        });
      });
    });
  }

  void setCharacter() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __) => CharacterPage(),
    ));
  }

  void myPage() {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (conetxt, _, __) => MyPage(),
    ));
  }

  @override
  void dispose() {
    print("lobby dispose");
//    audioCache.clear('gamebox/audio/backgroundmusic.mp3');
    gamePublicBloc.singStatus = false;
    advancedPlayer.stop();
    super.dispose();
  }

  tutoUpdate() async {
    sharedPreferences = await SharedPreferences.getInstance();
    int tutoStatus = await sharedPreferences.getInt("tuto_status");
    if (tutoStatus == 1) {
      setState(() {
        tutoCheck = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    tutoUpdate();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
    print("level = ${level}, ${gamePublicBloc.singStatus}");
    if (gamePublicBloc.singStatus != true) {
      gamePublicBloc.singStatus = true;
      setState(() {
//        audioCache.loop('gamebox/audio/backgroundmusic.mp3');
        AudioPlayer.logEnabled = false;
      });
    }

//    play();
  }

  Widget tuTo() {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          body(MediaQuery.of(context).size),
          Tutorial(size: MediaQuery.of(context).size),
        ],
      ),
    );
  }

  Widget notTuTo() {
    return Scaffold(
      body: body(MediaQuery.of(context).size),
    );
  }

  @override
  Widget build(BuildContext context) {
//    play();
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        advancedPlayer.stop();
      },
      child: tutoCheck ? notTuTo() : tuTo(),
    );
  }
}

class Character extends StatefulWidget {
  @override
  CharacterState createState() => CharacterState();
}

class CharacterState extends State<Character> {
//  String hair = "#e04736";
//  String eye = "#334666";
//  String skin = "#d97e57";
//  int style = 1;
//
//  int hats = 0;
//  String hatUrl = "";
//
//  int hair_style = 1;
//  int hair_color = 1;
//  int eye_color = 1;
//  int skin_color = 1;
//  int hat_shape = 0;
//
//  var hairColors = [
//    "#e04736",
//    "#f24970",
//    "#ffc247",
//    "#d1d426",
//    "#855729",
//    "#332d2d",
//    "#1c2957"
//  ];
//  var eyeColors = ["#334666", "#5e4327", "#241e1e"];
//  var skinColors = ["#d97e57", "#ff8585", "#ffcba3"];
//  var hatUrls = [
//    "assets/gamebox/img/charactor/hat/hat3.png",
//    "assets/gamebox/img/charactor/hat/hat2.png",
//    "assets/gamebox/img/charactor/hat/hat1.png"
//  ];

  @override
  void initState() {
    super.initState();
    mbloc.getMember().then((value) {
      setState(() {
        hair_style = json.decode(value)['data']['hair_type'];
        hair_color = json.decode(value)['data']['hair_color'];
        eye_color = json.decode(value)['data']['eye_color'];
        skin_color = json.decode(value)['data']['skin_color'];
        hat_shape = json.decode(value)['data']['hat'];
        style = hair_style;
        hats = hat_shape;
        if (hat_shape != 0) {
          hatUrl = hatUrls[hat_shape - 1];
        }
      });
    });
  }

  Widget getCharacter() {
    hair = hairColors[hair_color - 1];
    eye = eyeColors[eye_color - 1];
    skin = skinColors[skin_color - 1];
    style = hair_style;

    return Container(
//      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: SvgPicture.string(
              makeCharacter(style, hair, eye, skin),
              fit: BoxFit.contain,
              width: 115,
            ),
          ),
          getHat(),
        ],
      ),
    );
  }

  Widget getHat() {
    double width;
    double height = 0;
    print(hats.toString());
    if (hats == 2) {
      width = 50;
    } else if (hats == 1) {
      width = 80;
    } else if (hats == 3) {
      width = 90;
    }
    if (hats == 0) {
      return SizedBox(width: 0, height: 0);
    } else
      return Align(
        alignment: AlignmentDirectional.topCenter,
        child: Image.asset(hatUrl, fit: BoxFit.contain, width: width),
      );
  }

  String makeCharacter(int style, String hair, String eye, String skin) {
    String svg1 =
        '''<svg version="1.1" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
	 x="0px" y="0px" width="500px" height="600px" viewBox="0 0 500 600" xml:space="preserve">
<g>
	<g>
		<g>
			<path fill="#D3BE8A" d="M336.088,413.727c0,26.697-21.643,48.34-48.34,48.34h-78.551c-26.699,0-48.341-21.643-48.341-48.34
				v-47.535c0-26.697,21.642-48.338,48.341-48.338h78.551c26.697,0,48.34,21.641,48.34,48.338V413.727z"/>
			<path fill="#B9A17A" d="M329.08,343.771c-33.938-6.268-35.881,32.539-35.992,36.75l-132.257,0.166v5.75l132.75-0.166v76
				l5.502-0.834l0.248-75.166h0.125v-5.75h-0.125v-0.25h-0.443c8.773-40.076,27.443-29.375,27.443-29.375l4.75,2.625l2.5-2.666
				L329.08,343.771z"/>
		</g>
		<g>
			<polygon fill="#FEFDED" points="363.34,137.038 371.361,88.474 379.385,39.91 417.432,71.14 455.479,102.37 409.408,119.704 			
				"/>
			<g>
				<path fill="#90D4D7" d="M422.248,93.688c0-0.265-0.027-0.523-0.039-0.786l-9.137-1.634l-1.16,6.495l9.281,1.66
					C421.863,97.636,422.248,95.708,422.248,93.688z"/>
				
					<rect x="402.748" y="90.086" transform="matrix(0.9844 0.1761 -0.1761 0.9844 22.7921 -70.0659)" fill="#90D4D7" width="6.843" height="6.598"/>
				<path fill="#90D4D7" d="M410.648,87.787l1.635-9.145c-1.957-0.829-4.109-1.288-6.367-1.288c-0.121,0-0.238,0.016-0.359,0.018
					l-1.646,9.21L410.648,87.787z"/>
				<path fill="#90D4D7" d="M400.43,89.007l-9.551-1.708c-0.834,1.962-1.297,4.121-1.297,6.388c0,0.028,0.004,0.055,0.004,0.083
					l9.682,1.731L400.43,89.007z"/>
				<path fill="#90D4D7" d="M411.383,100.716l-1.576,8.819c4.225-1.035,7.795-3.705,10.014-7.311L411.383,100.716z"/>
				<path fill="#90D4D7" d="M398.74,98.455l-8.844-1.581c0.879,4.436,3.557,8.215,7.236,10.57L398.74,98.455z"/>
				<path fill="#90D4D7" d="M408.43,100.188l-6.736-1.205l-1.768,9.889c1.855,0.733,3.873,1.149,5.99,1.149
					c0.258,0,0.508-0.027,0.764-0.039L408.43,100.188z"/>
				<path fill="#90D4D7" d="M413.602,88.315l8.154,1.458c-0.979-3.978-3.398-7.389-6.695-9.62L413.602,88.315z"/>
				<path fill="#90D4D7" d="M400.957,86.054l1.488-8.323c-4.162,0.901-7.734,3.382-10.051,6.792L400.957,86.054z"/>
			</g>
		</g>
		<path fill="#7E4344" d="M387.896,44.57c0.471-2.671-1.238-5.205-3.811-5.657c-2.576-0.453-5.045,1.347-5.514,4.019
			l-54.898,312.289l9.076,3.043L387.896,44.57z"/>
		<path fill="#7E4344" d="M310.131,432.254c-0.471,2.672,1.236,5.205,3.811,5.656c2.574,0.453,5.045-1.346,5.514-4.018l3.834-21.809
			h-9.611L310.131,432.254z"/>
		<polygon fill="#D3BE8A" points="318.879,388.188 305.811,382.895 305.811,412.084 314.678,412.084 324.289,412.084 
			340.561,412.084 340.561,396.969 327.85,391.822 		"/>
	</g>
	<g>
		<path fill="#FEFDED" d="M274.627,341.641c-2.191,0.299-5.277,0.615-9.592,0.875l-65.54,46.439l-3.477,17.65l26.407-0.141
			l58.219-41.25L274.627,341.641z"/>
		<g>
			<path fill="#EDDC9D" d="M265.035,342.516c-5.611,0.34-13.291,0.59-23.767,0.59c-33.25,0-34.75-3.5-34.75-3.5l-33.75,11.25
				l10.083,30.25l19.667-7.5l-3.023,15.35L265.035,342.516z"/>
			<path fill="#EDDC9D" d="M310.83,350.418l-29.811-9.381l-1.377-0.432c0,0-1.01,0.49-5.016,1.035l6.018,23.574l-58.219,41.25
				l68.342-0.359l-2.727-11.906l-4.773-20.844l16.75,7.5L310.83,350.418z"/>
		</g>
		<polygon fill="#D3BE8A" points="196.737,375.793 192.987,377.293 183.056,347.131 186.852,345.877 		"/>
		<polygon fill="#D3BE8A" points="290.611,376.668 286.967,375.045 296.174,345.824 299.893,346.98 		"/>
		<circle fill="#EF3E5B" cx="247.019" cy="361.23" r="8.125"/>
		<polygon fill="#FFC446" points="255.504,376.795 265.143,360.1 274.783,376.795 		"/>
		<circle fill="#23AE92" cx="244.019" cy="384.355" r="8.125"/>
	</g>
	<g>
		<polygon fill="#7E4344" points="210.935,406.688 207.269,441.855 280.602,441.855 278.102,406.188 		"/>
		<path fill="#693C3C" d="M210.935,412.063c-0.053,0.033-0.646,5.543-0.646,5.543s6.583-4.938,6.646-7.063l-2.854-2.271
			C214.081,408.271,212.644,411,210.935,412.063z"/>
		<path fill="#693C3C" d="M265.158,412.73l3.188-2.063c0,0,4.215,4.313,9.715,4.77l0.541,4.168
			C278.602,419.605,269.592,418.605,265.158,412.73z"/>
		<polygon fill="#693C3C" points="209.019,430.605 279.186,430.605 279.686,434.521 208.519,434.521 		"/>
	</g>
	<g>
		<polygon fill="#FEFDED" points="204.436,473.521 283.602,473.521 287.895,522.105 200.519,522.105 		"/>
		<polygon fill="#EDDC9D" points="200.019,522.73 287.895,522.605 288.895,533.48 199.435,533.521 		"/>
		<path fill="#EDDC9D" d="M211.581,473.043v7.188h0.044c0.203,0.998,1.085,1.75,2.144,1.75s1.94-0.752,2.144-1.75h0.044v-7.188
			H211.581z"/>
		<path fill="#EDDC9D" d="M220.956,473.021v7.188H221c0.203,0.998,1.085,1.75,2.144,1.75s1.94-0.752,2.144-1.75h0.044v-7.188
			H220.956z"/>
		<path fill="#EDDC9D" d="M230.998,473.043v7.188h0.044c0.203,0.998,1.085,1.75,2.144,1.75s1.94-0.752,2.144-1.75h0.044v-7.188
			H230.998z"/>
		<path fill="#EDDC9D" d="M253.373,473.043v7.188h0.043c0.203,0.998,1.086,1.75,2.145,1.75s1.939-0.752,2.143-1.75h0.045v-7.188
			H253.373z"/>
		<path fill="#EDDC9D" d="M262.748,473.043v7.188h0.043c0.203,0.998,1.086,1.75,2.145,1.75s1.939-0.752,2.143-1.75h0.045v-7.188
			H262.748z"/>
		<path fill="#EDDC9D" d="M272.811,473.084v7.188h0.043c0.203,0.998,1.086,1.75,2.145,1.75s1.939-0.752,2.143-1.75h0.045v-7.188
			H272.811z"/>
		<g>
			<path fill="#FEFDED" d="M209.768,533.605c0.825,0.32,1.175,1.404,0.782,2.418l0,0c-0.394,1.014-1.381,1.576-2.207,1.256
				l-8.829-3.424c-0.826-0.32-1.176-1.404-0.782-2.418l0,0c0.393-1.014,1.38-1.578,2.207-1.258L209.768,533.605z"/>
			<path fill="#FEFDED" d="M207.435,539.648c0.825,0.318,1.175,1.402,0.782,2.418l0,0c-0.394,1.012-1.381,1.576-2.207,1.254
				l-8.829-3.422c-0.826-0.32-1.176-1.406-0.782-2.42l0,0c0.393-1.014,1.38-1.576,2.207-1.256L207.435,539.648z"/>
			<g>
				<path fill="#7E4344" d="M241.06,544.355c1.652,0,3.235,0.283,4.718,0.785c-0.033-0.133-0.062-0.268-0.099-0.398l-0.536-11.012
					l-36.605-0.324c-1.66-0.799-3.513-1.26-5.478-1.26c-6.996,0-12.667,5.672-12.667,12.668v3.498c0,5.289,3.243,9.816,7.847,11.713
					c-0.021-0.182-0.055-0.359-0.055-0.545c0-2.623,2.126-4.75,4.75-4.75s4.75,2.127,4.75,4.75c0,0.344-0.041,0.676-0.11,1h4.095
					c-0.069-0.324-0.11-0.656-0.11-1c0-2.623,2.126-4.75,4.75-4.75s4.75,2.127,4.75,4.75c0,0.344-0.041,0.676-0.11,1h5.429
					c-0.042-0.453-0.069-0.912-0.069-1.375C226.31,550.959,232.914,544.355,241.06,544.355z"/>
				<path fill="#FEFDED" d="M209.643,533.605c0.825,0.32,1.175,1.404,0.782,2.418l0,0c-0.394,1.014-1.381,1.576-2.207,1.256
					l-8.829-3.424c-0.826-0.32-1.176-1.404-0.782-2.418l0,0c0.393-1.014,1.38-1.578,2.207-1.258L209.643,533.605z"/>
				<path fill="#FEFDED" d="M207.309,539.648c0.825,0.318,1.175,1.402,0.782,2.418l0,0c-0.394,1.012-1.381,1.576-2.207,1.254
					l-8.829-3.422c-0.826-0.32-1.176-1.406-0.782-2.42l0,0c0.393-1.014,1.38-1.576,2.207-1.256L207.309,539.648z"/>
				<path fill="#683C3C" d="M245.888,550.418h0.068l-0.016-0.324c0.124-0.688,0.203-1.391,0.203-2.113
					c0-0.98-0.136-1.928-0.365-2.84c-1.483-0.502-3.066-0.785-4.718-0.785c-8.146,0-14.75,6.604-14.75,14.75
					c0,0.463,0.027,0.922,0.069,1.375h6.548C239.344,560.48,244.688,556.154,245.888,550.418z"/>
				<path fill="#683C3C" d="M216.31,554.73c-2.624,0-4.75,2.127-4.75,4.75c0,0.344,0.041,0.676,0.11,1h9.28
					c0.069-0.324,0.11-0.656,0.11-1C221.06,556.857,218.934,554.73,216.31,554.73z"/>
				<path fill="#683C3C" d="M202.935,554.73c-2.624,0-4.75,2.127-4.75,4.75c0,0.186,0.034,0.363,0.055,0.545
					c1.487,0.611,3.113,0.955,4.82,0.955c1.241,0,2.437-0.188,3.57-0.52c0.132,0.004,0.262,0.02,0.395,0.02h0.55
					c0.069-0.324,0.11-0.656,0.11-1C207.685,556.857,205.559,554.73,202.935,554.73z"/>
			</g>
			<g>
				<path fill="#7E4344" d="M284.895,544.355c1.652,0,3.234,0.283,4.717,0.785c-0.031-0.133-0.061-0.268-0.098-0.398l-0.537-11.012
					l-36.605-0.324c-1.659-0.799-3.513-1.26-5.478-1.26c-6.996,0-12.667,5.672-12.667,12.668v3.498
					c0,5.289,3.243,9.816,7.847,11.713c-0.021-0.182-0.055-0.359-0.055-0.545c0-2.623,2.126-4.75,4.75-4.75s4.75,2.127,4.75,4.75
					c0,0.344-0.04,0.676-0.11,1h4.096c-0.07-0.324-0.109-0.656-0.109-1c0-2.623,2.125-4.75,4.75-4.75c2.623,0,4.75,2.127,4.75,4.75
					c0,0.344-0.041,0.676-0.111,1h5.43c-0.041-0.453-0.068-0.912-0.068-1.375C270.145,550.959,276.748,544.355,284.895,544.355z"/>
				<path fill="#FEFDED" d="M253.477,533.605c0.824,0.32,1.175,1.404,0.781,2.418l0,0c-0.393,1.014-1.381,1.576-2.207,1.256
					l-8.828-3.424c-0.826-0.32-1.176-1.404-0.782-2.418l0,0c0.393-1.014,1.38-1.578,2.207-1.258L253.477,533.605z"/>
				<path fill="#FEFDED" d="M251.143,539.648c0.825,0.318,1.176,1.402,0.782,2.418l0,0c-0.394,1.012-1.381,1.576-2.207,1.254
					l-8.829-3.422c-0.826-0.32-1.176-1.406-0.782-2.42l0,0c0.393-1.014,1.38-1.576,2.207-1.256L251.143,539.648z"/>
				<path fill="#683C3C" d="M289.721,550.418h0.068l-0.016-0.324c0.125-0.688,0.203-1.391,0.203-2.113
					c0-0.98-0.137-1.928-0.365-2.84c-1.482-0.502-3.064-0.785-4.717-0.785c-8.146,0-14.75,6.604-14.75,14.75
					c0,0.463,0.027,0.922,0.068,1.375h6.549C283.178,560.48,288.521,556.154,289.721,550.418z"/>
				<path fill="#683C3C" d="M260.145,554.73c-2.625,0-4.75,2.127-4.75,4.75c0,0.344,0.039,0.676,0.109,1h9.279
					c0.07-0.324,0.111-0.656,0.111-1C264.895,556.857,262.768,554.73,260.145,554.73z"/>
				<path fill="#683C3C" d="M246.769,554.73c-2.624,0-4.75,2.127-4.75,4.75c0,0.186,0.034,0.363,0.055,0.545
					c1.487,0.611,3.113,0.955,4.82,0.955c1.241,0,2.437-0.188,3.57-0.52c0.132,0.004,0.262,0.02,0.395,0.02h0.55
					c0.07-0.324,0.11-0.656,0.11-1C251.519,556.857,249.392,554.73,246.769,554.73z"/>
			</g>
		</g>
	</g>
</g>
<ellipse fill="${skin}" cx="243.13" cy="209.06" rx="146.5" ry="135.5"/>
<circle fill="#DE6D56" cx="168.313" cy="263.542" r="28.667"/>
<circle fill="#DE6D56" cx="300.313" cy="263.542" r="28.667"/>
<g>
	<path fill="${hair}" d="M106.98,161.895c0,0-29,60.249,14,122.749c0,0-55-19-75.5-45.25l64.167-93.833
		c0,0,32.667-65,106.333-75.667s129,19.666,163.334,80c34.332,60.334,55.332,95.334,55.332,95.334l-21.666,15.333l-8.666-9.334
		l1,13.667c0,0-28.334,13.999-37.668,16.333c0,0,34.084-53.583,13.334-111.333c0,0-28.75,7-53.5-17.25c0,0-24.5,53.75-82.5,50.5
		c-58-3.25-76.5-36.25-83.75-55C161.23,148.144,138.98,171.146,106.98,161.895z"/>
	<path fill="#C03634" d="M230.98,201.144l-7.583-67.459l6.5,1.125l7.375,67.334C237.271,202.144,232.146,201.894,230.98,201.144z"/>
	<polygon fill="#C03634" points="261.563,139.727 268.396,201.123 274.021,199.81 267.813,141.06 	"/>
	<polygon fill="#C03634" points="274.459,143.54 280.646,144.79 286.146,194.81 280.396,197.31 	"/>
	<path fill="#C03634" d="M385.271,234.685l12.75,33.625l-5.375,3l-10-26.125C382.646,245.185,384.521,240.06,385.271,234.685z"/>
	<path fill="#C03634" d="M97.313,206.227L69.271,259.81l5.375,3.375l23.167-43.958C97.813,219.227,97.438,209.227,97.313,206.227z"
		/>
	<path fill="#C03634" d="M99.48,234.393L81.896,267.56l5.625,3l14.292-27.667C101.813,242.893,99.48,236.518,99.48,234.393z"/>
</g>
<ellipse cx="267.896" cy="240.06" rx="12.75" ry="15" fill="${eye}"/>
<ellipse cx="184.896" cy="240.06" rx="12.75" ry="15" fill="${eye}"/>
<path fill="#CA5941" d="M207.981,259.865c-0.041,0-0.082,0-0.123-0.003c-1.372-0.067-2.433-1.218-2.376-2.589
	c0.006-0.146,0.805-14.564,18.665-14.564c17.786,0,18.983,13.681,18.994,13.818c0.1,1.377-0.936,2.574-2.313,2.675
	c-1.381,0.103-2.574-0.937-2.674-2.313c-0.084-0.92-1.205-9.18-14.006-9.18c-12.747,0-13.613,8.786-13.669,9.788
	C210.402,258.826,209.299,259.865,207.981,259.865z"/>
<path fill="#B13E3C" d="M212.15,281.057c5.512,11.91,17.364,20.152,31.101,20.152c18.355,0,33.349-14.709,34.341-33.233
	L212.15,281.057z"/>
<g>
	<path fill="${skin}" d="M95.746,416.311l86.918-35.205l-10.25-30.25l-69.561,23.311l-6.225-5.793
		c-1.139-1.387-2.865-2.27-4.798-2.27c-3.429,0-6.209,2.779-6.209,6.209c0,0.857,0.173,1.672,0.487,2.414l-0.111,0.086l0.345,0.398
		c0.439,0.832,1.064,1.547,1.816,2.1l1.269,1.467l-15.397,7.051c-2.593,0.66-4.512,3.004-4.512,5.803
		c0,3.311,2.684,5.994,5.995,5.994c1.314,0,2.526-0.428,3.514-1.145l3.856-1.646l0.05,0.725l-7.52,3.234l0.005,0.02
		c-2.087,0.914-3.546,2.994-3.546,5.418c0,3.268,2.649,5.916,5.917,5.916c1.367,0,2.622-0.467,3.624-1.246l5.938-2.357l0.031-0.291
		l1.032,0.541l-4.75,2.125l0,0c-2.261,0.838-3.875,3.01-3.875,5.563c0,3.279,2.658,5.938,5.938,5.938
		c0.978,0,1.898-0.242,2.711-0.66l7.289-3.34L95.746,416.311z"/>
	<polygon fill="${skin}" points="207.164,441.48 204.331,473.563 283.248,473.563 280.58,441.564 	"/>
	<path fill="${skin}" d="M404.029,396.48c0.988,0.717,2.199,1.145,3.514,1.145c3.313,0,5.996-2.684,5.996-5.994
		c0-2.799-1.92-5.143-4.514-5.803l-15.396-7.051l1.27-1.467c0.752-0.553,1.377-1.268,1.816-2.1l0.344-0.398l-0.111-0.086
		c0.314-0.742,0.486-1.557,0.486-2.414c0-3.43-2.779-6.209-6.209-6.209c-1.932,0-3.658,0.883-4.797,2.27l-6.225,5.793
		l-47.453-15.902l-9.076-3.043l-13.031-4.365l-10.25,30.25l4.418,1.789l13.068,5.293l8.971,3.635l12.711,5.146l47.75,19.342
		l0.02,0.107l7.289,3.34c0.813,0.418,1.732,0.66,2.711,0.66c3.279,0,5.938-2.658,5.938-5.938c0-2.553-1.615-4.725-3.875-5.563l0,0
		l-4.75-2.125l1.031-0.541l0.031,0.291l5.938,2.357c1.002,0.779,2.258,1.246,3.625,1.246c3.268,0,5.916-2.648,5.916-5.916
		c0-2.424-1.459-4.504-3.547-5.418l0.006-0.02l-7.52-3.234l0.049-0.725L404.029,396.48z"/>
</g>
</svg>
''';

    String svg2 =
        '''<svg version="1.1" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
	 x="0px" y="0px" width="500px" height="600px" viewBox="0 0 500 600" xml:space="preserve">
<g>
	<g>
		<g>
			<g>
				<path fill="#D3BE8A" d="M335.895,413.727c0,26.697-21.643,48.34-48.341,48.34h-78.551c-26.699,0-48.341-21.643-48.341-48.34
					v-47.535c0-26.697,21.642-48.338,48.341-48.338h78.551c26.698,0,48.341,21.641,48.341,48.338V413.727z"/>
				<path fill="#B9A17A" d="M328.887,343.771c-33.938-6.268-35.882,32.539-35.993,36.75l-132.257,0.166v5.75l132.75-0.166v76
					l5.501-0.834l0.249-75.166h0.125v-5.75h-0.125v-0.25h-0.443c8.773-40.076,27.443-29.375,27.443-29.375l4.75,2.625l2.5-2.666
					L328.887,343.771z"/>
			</g>
			<g>
				<polygon fill="#FEFDED" points="363.146,137.038 371.168,88.474 379.191,39.91 417.237,71.14 455.284,102.37 409.215,119.704 
									"/>
				<g>
					<path fill="#90D4D7" d="M422.055,93.688c0-0.265-0.027-0.523-0.04-0.786l-9.136-1.634l-1.161,6.495l9.281,1.66
						C421.67,97.636,422.055,95.708,422.055,93.688z"/>
					
						<rect x="402.554" y="90.086" transform="matrix(0.9844 0.1761 -0.1761 0.9844 22.785 -70.0222)" fill="#90D4D7" width="6.844" height="6.598"/>
					<path fill="#90D4D7" d="M410.454,87.787l1.635-9.145c-1.957-0.829-4.108-1.288-6.367-1.288c-0.121,0-0.238,0.016-0.358,0.018
						l-1.646,9.21L410.454,87.787z"/>
					<path fill="#90D4D7" d="M400.235,89.007l-9.55-1.708c-0.835,1.962-1.298,4.121-1.298,6.388c0,0.028,0.004,0.055,0.004,0.083
						l9.683,1.731L400.235,89.007z"/>
					<path fill="#90D4D7" d="M411.189,100.716l-1.577,8.819c4.225-1.035,7.796-3.705,10.015-7.311L411.189,100.716z"/>
					<path fill="#90D4D7" d="M398.546,98.455l-8.843-1.581c0.878,4.436,3.556,8.215,7.235,10.57L398.546,98.455z"/>
					<path fill="#90D4D7" d="M408.236,100.188l-6.737-1.205l-1.768,9.889c1.856,0.733,3.873,1.149,5.99,1.149
						c0.258,0,0.509-0.027,0.764-0.039L408.236,100.188z"/>
					<path fill="#90D4D7" d="M413.407,88.315l8.155,1.458c-0.979-3.978-3.399-7.389-6.696-9.62L413.407,88.315z"/>
					<path fill="#90D4D7" d="M400.764,86.054l1.488-8.323c-4.162,0.901-7.735,3.382-10.051,6.792L400.764,86.054z"/>
				</g>
			</g>
			<path fill="#7E4344" d="M387.702,44.57c0.471-2.671-1.237-5.205-3.811-5.657c-2.575-0.453-5.045,1.347-5.514,4.019
				l-54.898,312.289l9.077,3.043L387.702,44.57z"/>
			<path fill="#7E4344" d="M309.938,432.254c-0.472,2.672,1.235,5.205,3.81,5.656c2.575,0.453,5.045-1.346,5.514-4.018l3.834-21.809
				h-9.611L309.938,432.254z"/>
			<polygon fill="#D3BE8A" points="318.685,388.188 305.616,382.895 305.616,412.084 314.483,412.084 324.095,412.084 
				340.366,412.084 340.366,396.969 327.656,391.822 			"/>
		</g>
		<g>
			<path fill="#FEFDED" d="M274.434,341.641c-2.191,0.299-5.277,0.615-9.592,0.875l-65.541,46.439l-3.477,17.65l26.408-0.141
				l58.219-41.25L274.434,341.641z"/>
			<g>
				<path fill="#EDDC9D" d="M264.842,342.516c-5.611,0.34-13.291,0.59-23.768,0.59c-33.25,0-34.75-3.5-34.75-3.5l-33.75,11.25
					l10.084,30.25l19.666-7.5l-3.023,15.35L264.842,342.516z"/>
				<path fill="#EDDC9D" d="M310.637,350.418l-29.811-9.381l-1.377-0.432c0,0-1.01,0.49-5.016,1.035l6.018,23.574l-58.219,41.25
					l68.342-0.359l-2.727-11.906l-4.773-20.844l16.75,7.5L310.637,350.418z"/>
			</g>
			<polygon fill="#D3BE8A" points="196.543,375.793 192.793,377.293 182.861,347.131 186.658,345.877 			"/>
			<polygon fill="#D3BE8A" points="290.418,376.668 286.773,375.045 295.98,345.824 299.699,346.98 			"/>
			<circle fill="#EF3E5B" cx="246.824" cy="361.23" r="8.125"/>
			<polygon fill="#FFC446" points="255.311,376.795 264.949,360.1 274.59,376.795 			"/>
			<circle fill="#23AE92" cx="243.824" cy="384.355" r="8.125"/>
		</g>
		<g>
			<polygon fill="#7E4344" points="210.741,406.688 207.074,441.855 280.408,441.855 277.908,406.188 			"/>
			<path fill="#693C3C" d="M210.741,412.063c-0.054,0.033-0.646,5.543-0.646,5.543s6.583-4.938,6.646-7.063l-2.854-2.271
				C213.887,408.271,212.449,411,210.741,412.063z"/>
			<path fill="#693C3C" d="M264.965,412.73l3.188-2.063c0,0,4.215,4.313,9.715,4.77l0.541,4.168
				C278.408,419.605,269.398,418.605,264.965,412.73z"/>
			<polygon fill="#693C3C" points="208.824,430.605 278.992,430.605 279.492,434.521 208.324,434.521 			"/>
		</g>
		<g>
			<polygon fill="#FEFDED" points="204.242,473.521 283.408,473.521 287.701,522.105 200.324,522.105 			"/>
			<polygon fill="#EDDC9D" points="199.824,522.73 287.701,522.605 288.701,533.48 199.241,533.521 			"/>
			<path fill="#EDDC9D" d="M211.387,473.043v7.188h0.045c0.203,0.998,1.085,1.75,2.143,1.75c1.059,0,1.941-0.752,2.145-1.75h0.043
				v-7.188H211.387z"/>
			<path fill="#EDDC9D" d="M220.762,473.021v7.188h0.045c0.203,0.998,1.085,1.75,2.143,1.75c1.059,0,1.941-0.752,2.145-1.75h0.043
				v-7.188H220.762z"/>
			<path fill="#EDDC9D" d="M230.804,473.043v7.188h0.044c0.203,0.998,1.086,1.75,2.144,1.75s1.94-0.752,2.144-1.75h0.044v-7.188
				H230.804z"/>
			<path fill="#EDDC9D" d="M253.179,473.043v7.188h0.044c0.203,0.998,1.086,1.75,2.144,1.75c1.059,0,1.94-0.752,2.144-1.75h0.044
				v-7.188H253.179z"/>
			<path fill="#EDDC9D" d="M262.555,473.043v7.188h0.043c0.203,0.998,1.086,1.75,2.145,1.75s1.939-0.752,2.143-1.75h0.045v-7.188
				H262.555z"/>
			<path fill="#EDDC9D" d="M272.617,473.084v7.188h0.043c0.203,0.998,1.086,1.75,2.145,1.75s1.939-0.752,2.143-1.75h0.045v-7.188
				H272.617z"/>
			<g>
				<path fill="#FEFDED" d="M209.574,533.605c0.825,0.32,1.176,1.404,0.782,2.418l0,0c-0.394,1.014-1.382,1.576-2.207,1.256
					l-8.829-3.424c-0.825-0.32-1.176-1.404-0.781-2.418l0,0c0.393-1.014,1.38-1.578,2.207-1.258L209.574,533.605z"/>
				<path fill="#FEFDED" d="M207.24,539.648c0.826,0.318,1.176,1.402,0.783,2.418l0,0c-0.395,1.012-1.382,1.576-2.207,1.254
					l-8.829-3.422c-0.825-0.32-1.176-1.406-0.782-2.42l0,0c0.393-1.014,1.381-1.576,2.207-1.256L207.24,539.648z"/>
				<g>
					<path fill="#7E4344" d="M240.866,544.355c1.652,0,3.235,0.283,4.718,0.785c-0.032-0.133-0.062-0.268-0.099-0.398l-0.536-11.012
						l-36.605-0.324c-1.659-0.799-3.513-1.26-5.478-1.26c-6.996,0-12.667,5.672-12.667,12.668v3.498
						c0,5.289,3.243,9.816,7.847,11.713c-0.021-0.182-0.055-0.359-0.055-0.545c0-2.623,2.126-4.75,4.75-4.75s4.75,2.127,4.75,4.75
						c0,0.344-0.04,0.676-0.11,1h4.096c-0.07-0.324-0.11-0.656-0.11-1c0-2.623,2.126-4.75,4.75-4.75s4.75,2.127,4.75,4.75
						c0,0.344-0.04,0.676-0.11,1h5.43c-0.042-0.453-0.069-0.912-0.069-1.375C226.116,550.959,232.721,544.355,240.866,544.355z"/>
					<path fill="#FEFDED" d="M209.449,533.605c0.824,0.32,1.175,1.404,0.781,2.418l0,0c-0.393,1.014-1.381,1.576-2.207,1.256
						l-8.828-3.424c-0.826-0.32-1.176-1.404-0.782-2.418l0,0c0.394-1.014,1.38-1.578,2.207-1.258L209.449,533.605z"/>
					<path fill="#FEFDED" d="M207.115,539.648c0.825,0.318,1.176,1.402,0.782,2.418l0,0c-0.394,1.012-1.382,1.576-2.207,1.254
						l-8.829-3.422c-0.825-0.32-1.176-1.406-0.781-2.42l0,0c0.393-1.014,1.38-1.576,2.207-1.256L207.115,539.648z"/>
					<path fill="#683C3C" d="M245.693,550.418h0.068l-0.016-0.324c0.124-0.688,0.203-1.391,0.203-2.113
						c0-0.98-0.137-1.928-0.365-2.84c-1.482-0.502-3.065-0.785-4.718-0.785c-8.146,0-14.75,6.604-14.75,14.75
						c0,0.463,0.027,0.922,0.069,1.375h6.549C239.15,560.48,244.494,556.154,245.693,550.418z"/>
					<path fill="#683C3C" d="M216.116,554.73c-2.624,0-4.75,2.127-4.75,4.75c0,0.344,0.04,0.676,0.11,1h9.279
						c0.07-0.324,0.11-0.656,0.11-1C220.866,556.857,218.74,554.73,216.116,554.73z"/>
					<path fill="#683C3C" d="M202.741,554.73c-2.624,0-4.75,2.127-4.75,4.75c0,0.186,0.034,0.363,0.055,0.545
						c1.487,0.611,3.112,0.955,4.82,0.955c1.241,0,2.437-0.188,3.569-0.52c0.133,0.004,0.262,0.02,0.396,0.02h0.55
						c0.07-0.324,0.11-0.656,0.11-1C207.491,556.857,205.365,554.73,202.741,554.73z"/>
				</g>
				<g>
					<path fill="#7E4344" d="M284.701,544.355c1.652,0,3.234,0.283,4.717,0.785c-0.031-0.133-0.061-0.268-0.098-0.398l-0.537-11.012
						l-36.605-0.324c-1.66-0.799-3.514-1.26-5.479-1.26c-6.996,0-12.666,5.672-12.666,12.668v3.498
						c0,5.289,3.242,9.816,7.846,11.713c-0.02-0.182-0.055-0.359-0.055-0.545c0-2.623,2.127-4.75,4.75-4.75
						c2.624,0,4.75,2.127,4.75,4.75c0,0.344-0.04,0.676-0.109,1h4.095c-0.069-0.324-0.109-0.656-0.109-1
						c0-2.623,2.126-4.75,4.751-4.75c2.623,0,4.75,2.127,4.75,4.75c0,0.344-0.041,0.676-0.111,1h5.43
						c-0.041-0.453-0.068-0.912-0.068-1.375C269.951,550.959,276.555,544.355,284.701,544.355z"/>
					<path fill="#FEFDED" d="M253.282,533.605c0.825,0.32,1.175,1.404,0.782,2.418l0,0c-0.394,1.014-1.381,1.576-2.207,1.256
						l-8.828-3.424c-0.826-0.32-1.176-1.404-0.783-2.418l0,0c0.394-1.014,1.381-1.578,2.207-1.258L253.282,533.605z"/>
					<path fill="#FEFDED" d="M250.949,539.648c0.824,0.318,1.175,1.402,0.781,2.418l0,0c-0.393,1.012-1.381,1.576-2.207,1.254
						l-8.828-3.422c-0.826-0.32-1.176-1.406-0.782-2.42l0,0c0.394-1.014,1.38-1.576,2.207-1.256L250.949,539.648z"/>
					<path fill="#683C3C" d="M289.527,550.418h0.068l-0.016-0.324c0.125-0.688,0.203-1.391,0.203-2.113
						c0-0.98-0.137-1.928-0.365-2.84c-1.482-0.502-3.064-0.785-4.717-0.785c-8.146,0-14.75,6.604-14.75,14.75
						c0,0.463,0.027,0.922,0.068,1.375h6.549C282.984,560.48,288.328,556.154,289.527,550.418z"/>
					<path fill="#683C3C" d="M259.951,554.73c-2.625,0-4.751,2.127-4.751,4.75c0,0.344,0.04,0.676,0.109,1h9.28
						c0.07-0.324,0.111-0.656,0.111-1C264.701,556.857,262.574,554.73,259.951,554.73z"/>
					<path fill="#683C3C" d="M246.574,554.73c-2.623,0-4.75,2.127-4.75,4.75c0,0.186,0.035,0.363,0.055,0.545
						c1.487,0.611,3.113,0.955,4.82,0.955c1.241,0,2.438-0.188,3.57-0.52c0.133,0.004,0.262,0.02,0.395,0.02h0.551
						c0.069-0.324,0.109-0.656,0.109-1C251.324,556.857,249.198,554.73,246.574,554.73z"/>
				</g>
			</g>
		</g>
	</g>
	<path fill="${skin}" d="M388.889,197.38c-6.404-69.365-69.299-123.82-145.953-123.82c-76.417,0-139.158,54.121-145.891,123.18
		c-0.396,4.059-0.609,8.166-0.609,12.32c0,29.625,10.287,57.025,27.729,79.325c26.613,34.029,69.894,56.176,118.771,56.176
		c49.811,0,93.808-22.998,120.277-58.135c16.525-21.938,26.224-48.602,26.224-77.365
		C389.437,205.125,389.244,201.231,388.889,197.38z"/>
	<circle fill="#DE6D56" cx="168.12" cy="263.542" r="28.667"/>
	<circle fill="#DE6D56" cx="300.12" cy="263.542" r="28.667"/>
	<ellipse cx="267.702" cy="240.06" rx="12.75" ry="15" fill="${eye}"/>
	<ellipse cx="184.703" cy="240.06" rx="12.75" ry="15" fill="${eye}"/>
	<path fill="#CA5941" d="M207.787,259.865c-0.041,0-0.081,0-0.123-0.003c-1.371-0.067-2.432-1.218-2.376-2.589
		c0.007-0.146,0.806-14.564,18.665-14.564c17.785,0,18.982,13.681,18.993,13.818c0.1,1.377-0.937,2.574-2.313,2.675
		c-1.381,0.103-2.574-0.937-2.674-2.313c-0.084-0.92-1.205-9.18-14.006-9.18c-12.748,0-13.613,8.786-13.67,9.788
		C210.208,258.826,209.105,259.865,207.787,259.865z"/>
	<path fill="#B13E3C" d="M211.956,281.057c5.512,11.91,17.364,20.152,31.101,20.152c18.354,0,33.349-14.709,34.341-33.233
		L211.956,281.057z"/>
	<g>
		<path fill="${skin}" d="M95.552,416.311l86.919-35.205l-10.25-30.25l-69.561,23.311l-6.225-5.793
			c-1.139-1.387-2.865-2.27-4.799-2.27c-3.429,0-6.209,2.779-6.209,6.209c0,0.857,0.174,1.672,0.487,2.414l-0.111,0.086l0.345,0.398
			c0.439,0.832,1.064,1.547,1.816,2.1l1.27,1.467l-15.398,7.051c-2.592,0.66-4.512,3.004-4.512,5.803
			c0,3.311,2.684,5.994,5.995,5.994c1.314,0,2.526-0.428,3.515-1.145l3.855-1.646l0.051,0.725l-7.52,3.234l0.005,0.02
			c-2.087,0.914-3.546,2.994-3.546,5.418c0,3.268,2.648,5.916,5.916,5.916c1.367,0,2.621-0.467,3.623-1.246l5.939-2.357l0.03-0.291
			l1.032,0.541l-4.75,2.125l0,0c-2.262,0.838-3.875,3.01-3.875,5.563c0,3.279,2.658,5.938,5.938,5.938
			c0.978,0,1.898-0.242,2.711-0.66l7.289-3.34L95.552,416.311z"/>
		<polygon fill="${skin}" points="206.971,441.48 204.137,473.563 283.055,473.563 280.387,441.564 		"/>
		<path fill="${skin}" d="M403.836,396.48c0.988,0.717,2.199,1.145,3.514,1.145c3.313,0,5.996-2.684,5.996-5.994
			c0-2.799-1.92-5.143-4.514-5.803l-15.396-7.051l1.27-1.467c0.752-0.553,1.377-1.268,1.816-2.1l0.344-0.398l-0.111-0.086
			c0.314-0.742,0.486-1.557,0.486-2.414c0-3.43-2.779-6.209-6.209-6.209c-1.932,0-3.658,0.883-4.797,2.27l-6.225,5.793
			l-47.453-15.902l-9.077-3.043l-13.03-4.365l-10.25,30.25l4.417,1.789l13.068,5.293l8.972,3.635l12.71,5.146l47.751,19.342
			l0.02,0.107l7.289,3.34c0.813,0.418,1.732,0.66,2.711,0.66c3.279,0,5.938-2.658,5.938-5.938c0-2.553-1.615-4.725-3.875-5.563l0,0
			l-4.75-2.125l1.031-0.541l0.031,0.291l5.938,2.357c1.002,0.779,2.258,1.246,3.625,1.246c3.268,0,5.916-2.648,5.916-5.916
			c0-2.424-1.459-4.504-3.547-5.418l0.006-0.02l-7.52-3.234l0.049-0.725L403.836,396.48z"/>
	</g>
	<g>
		<g>
			<path fill="${hair}" d="M319.553,83.688c-72-48-156.25,0.542-156.25,0.542c-7.125,1.375-21.625-5.25-23.625-6.875
				c-1.323-1.075-5.102-2.912-7.512-4.035c-8.549-5.361-18.657-8.465-29.494-8.465c-25.158,0-46.404,16.707-53.274,39.629
				c-2.411,6.908-3.762,14.551-3.762,22.6c0,6.25,0.82,12.253,2.31,17.861c1.334,7.366,4.117,14.226,8.043,20.279
				c6.866,12.981,18.712,22.917,33,27.259c1.753,0.645,3.552,1.192,5.383,1.66c5.563,1.911,10.683,3.045,10.683,3.045
				c41.001,12,64.333-29.833,64.333-29.833l20-3.5c11.5,14,31,19.333,53.5,20.333s37.666-13.958,37.666-13.958s7,9.25,27.625,10
				s30.375-11.375,30.375-11.375c13.875,27.625,49.5,32.667,49.5,32.667S391.553,131.688,319.553,83.688z"/>
			<path fill="${hair}" d="M97.045,196.74l-0.325,0.614l-0.334,6.667c0,0-22.166,30.166-16.083,50.333
				c9.242,30.642,35.447,33.818,43.861,34.031c-17.441-22.299-27.729-49.7-27.729-79.325
				C96.436,204.906,96.649,200.798,97.045,196.74z"/>
			<path fill="${hair}" d="M405.719,226.854l-16.83-29.474c0.355,3.851,0.548,7.744,0.548,11.68
				c0,28.764-9.698,55.428-26.224,77.365l7.456-0.268c21.442-2.031,38.218-20.08,38.218-42.054
				C408.887,238.15,405.719,226.854,405.719,226.854z"/>
		</g>
		<path fill="#FFDC63" d="M112.031,197.699c-1.984,0-3.15-0.1-3.218-0.106c-1.374-0.132-2.382-1.353-2.249-2.728
			c0.132-1.373,1.35-2.383,2.725-2.25l0,0c1.524,0.141,37.546,3.127,54.287-29.648c0.348-0.68,0.682-1.344,1.004-1.995
			c-3.629-4.413-6.082-10.545-6.521-16.689c-0.818-11.452,4.227-18.416,9.39-19.153c2.509-0.359,5.97,0.366,8.187,3.47
			c3.874,5.423,2.177,15.974-5.037,31.398c0.107,0.09,0.217,0.179,0.326,0.266c2.939,2.33,6.298,3.215,9.983,2.622
			c3.071-0.491,5.653-1.229,7.772-2.088c-1.217-1.815-1.923-3.63-2.111-5.435c-0.272-2.602,0.567-5.148,2.365-7.17
			c1.355-1.525,3.36-2.174,5.497-1.774c2.841,0.528,5.316,2.754,6.462,5.808c0.686,1.828,0.425,3.93-0.732,5.922
			c-0.815,1.402-2.016,2.711-3.537,3.895c0.505,0.42,1.058,0.854,1.663,1.301c9.151,6.754,26.185,19.328,63.76,11.563
			c1.35-0.277,2.674,0.59,2.954,1.942c0.279,1.353-0.59,2.675-1.942,2.954c-39.756,8.216-57.961-5.219-67.74-12.438
			c-1.181-0.871-2.243-1.744-3.188-2.621c-2.962,1.391-6.505,2.451-10.433,3.079c-4.829,0.774-9.429-0.343-13.339-3.229
			c-0.109,0.215-0.219,0.431-0.329,0.647C152.751,195.152,122.026,197.699,112.031,197.699z M193.218,151.304
			c-0.359,0-0.495,0.153-0.547,0.211c-0.603,0.678-1.288,1.806-1.129,3.328c0.094,0.896,0.488,2.096,1.564,3.576
			c1.33-0.957,2.232-1.926,2.732-2.786c0.225-0.388,0.573-1.118,0.373-1.652c-0.598-1.594-1.784-2.479-2.695-2.648
			C193.403,151.313,193.304,151.304,193.218,151.304z M168.607,130.051c-0.233,0-0.396,0.02-0.451,0.028
			c-2.105,0.3-5.766,4.671-5.11,13.847c0.307,4.291,1.76,8.545,3.956,11.927c7.575-16.872,5.819-22.591,4.565-24.347
			C170.66,130.236,169.313,130.051,168.607,130.051z"/>
	</g>
</g>
</svg>
''';

    String svg3 =
        '''<svg version="1.1" baseProfile="tiny" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
	 x="0px" y="0px" width="500px" height="600px" viewBox="0 0 500 600" xml:space="preserve">
<g>
	<g>
		<g>
			<path fill="#D3BE8A" d="M336.088,413.727c0,26.697-21.643,48.34-48.34,48.34h-78.551c-26.699,0-48.341-21.643-48.341-48.34
				v-47.535c0-26.697,21.642-48.338,48.341-48.338h78.551c26.697,0,48.34,21.641,48.34,48.338V413.727z"/>
			<path fill="#B9A17A" d="M329.08,343.771c-33.938-6.268-35.881,32.539-35.992,36.75l-132.257,0.166v5.75l132.75-0.166v76
				l5.502-0.834l0.248-75.166h0.125v-5.75h-0.125v-0.25h-0.443c8.773-40.076,27.443-29.375,27.443-29.375l4.75,2.625l2.5-2.666
				L329.08,343.771z"/>
		</g>
		<g>
			<polygon fill="#FEFDED" points="363.34,137.038 371.361,88.474 379.385,39.91 417.432,71.14 455.479,102.37 409.408,119.704 			
				"/>
			<g>
				<path fill="#90D4D7" d="M422.248,93.688c0-0.265-0.027-0.523-0.039-0.786l-9.137-1.634l-1.16,6.495l9.281,1.66
					C421.863,97.636,422.248,95.708,422.248,93.688z"/>
				
					<rect x="402.748" y="90.086" transform="matrix(0.9844 0.1761 -0.1761 0.9844 22.7921 -70.0659)" fill="#90D4D7" width="6.843" height="6.598"/>
				<path fill="#90D4D7" d="M410.648,87.787l1.635-9.145c-1.957-0.829-4.109-1.288-6.367-1.288c-0.121,0-0.238,0.016-0.359,0.018
					l-1.646,9.21L410.648,87.787z"/>
				<path fill="#90D4D7" d="M400.43,89.007l-9.551-1.708c-0.834,1.962-1.297,4.121-1.297,6.388c0,0.028,0.004,0.055,0.004,0.083
					l9.682,1.731L400.43,89.007z"/>
				<path fill="#90D4D7" d="M411.383,100.716l-1.576,8.819c4.225-1.035,7.795-3.705,10.014-7.311L411.383,100.716z"/>
				<path fill="#90D4D7" d="M398.74,98.455l-8.844-1.581c0.879,4.436,3.557,8.215,7.236,10.57L398.74,98.455z"/>
				<path fill="#90D4D7" d="M408.43,100.188l-6.736-1.205l-1.768,9.889c1.855,0.733,3.873,1.149,5.99,1.149
					c0.258,0,0.508-0.027,0.764-0.039L408.43,100.188z"/>
				<path fill="#90D4D7" d="M413.602,88.315l8.154,1.458c-0.979-3.978-3.398-7.389-6.695-9.62L413.602,88.315z"/>
				<path fill="#90D4D7" d="M400.957,86.054l1.488-8.323c-4.162,0.901-7.734,3.382-10.051,6.792L400.957,86.054z"/>
			</g>
		</g>
		<path fill="#7E4344" d="M387.896,44.57c0.471-2.671-1.238-5.205-3.811-5.657c-2.576-0.453-5.045,1.347-5.514,4.019
			l-54.898,312.289l9.076,3.043L387.896,44.57z"/>
		<path fill="#7E4344" d="M310.131,432.254c-0.471,2.672,1.236,5.205,3.811,5.656c2.574,0.453,5.045-1.346,5.514-4.018l3.834-21.809
			h-9.611L310.131,432.254z"/>
		<polygon fill="#D3BE8A" points="318.879,388.188 305.811,382.895 305.811,412.084 314.678,412.084 324.289,412.084 
			340.561,412.084 340.561,396.969 327.85,391.822 		"/>
	</g>
	<g>
		<path fill="#FEFDED" d="M274.627,341.641c-2.191,0.299-5.277,0.615-9.592,0.875l-65.54,46.439l-3.477,17.65l26.407-0.141
			l58.219-41.25L274.627,341.641z"/>
		<g>
			<path fill="#EDDC9D" d="M265.035,342.516c-5.611,0.34-13.291,0.59-23.767,0.59c-33.25,0-34.75-3.5-34.75-3.5l-33.75,11.25
				l10.083,30.25l19.667-7.5l-3.023,15.35L265.035,342.516z"/>
			<path fill="#EDDC9D" d="M310.83,350.418l-29.811-9.381l-1.377-0.432c0,0-1.01,0.49-5.016,1.035l6.018,23.574l-58.219,41.25
				l68.342-0.359l-2.727-11.906l-4.773-20.844l16.75,7.5L310.83,350.418z"/>
		</g>
		<polygon fill="#D3BE8A" points="196.737,375.793 192.987,377.293 183.056,347.131 186.852,345.877 		"/>
		<polygon fill="#D3BE8A" points="290.611,376.668 286.967,375.045 296.174,345.824 299.893,346.98 		"/>
		<circle fill="#EF3E5B" cx="247.019" cy="361.23" r="8.125"/>
		<polygon fill="#FFC446" points="255.504,376.795 265.143,360.1 274.783,376.795 		"/>
		<circle fill="#23AE92" cx="244.019" cy="384.355" r="8.125"/>
	</g>
	<g>
		<polygon fill="#7E4344" points="210.935,406.688 207.269,441.855 280.602,441.855 278.102,406.188 		"/>
		<path fill="#693C3C" d="M210.935,412.063c-0.053,0.033-0.646,5.543-0.646,5.543s6.583-4.938,6.646-7.063l-2.854-2.271
			C214.081,408.271,212.644,411,210.935,412.063z"/>
		<path fill="#693C3C" d="M265.158,412.73l3.188-2.063c0,0,4.215,4.313,9.715,4.77l0.541,4.168
			C278.602,419.605,269.592,418.605,265.158,412.73z"/>
		<polygon fill="#693C3C" points="209.019,430.605 279.186,430.605 279.686,434.521 208.519,434.521 		"/>
	</g>
	<g>
		<polygon fill="#FEFDED" points="204.436,473.521 283.602,473.521 287.895,522.105 200.519,522.105 		"/>
		<polygon fill="#EDDC9D" points="200.019,522.73 287.895,522.605 288.895,533.48 199.435,533.521 		"/>
		<path fill="#EDDC9D" d="M211.581,473.043v7.188h0.044c0.203,0.998,1.085,1.75,2.144,1.75s1.94-0.752,2.144-1.75h0.044v-7.188
			H211.581z"/>
		<path fill="#EDDC9D" d="M220.956,473.021v7.188H221c0.203,0.998,1.085,1.75,2.144,1.75s1.94-0.752,2.144-1.75h0.044v-7.188
			H220.956z"/>
		<path fill="#EDDC9D" d="M230.998,473.043v7.188h0.044c0.203,0.998,1.085,1.75,2.144,1.75s1.94-0.752,2.144-1.75h0.044v-7.188
			H230.998z"/>
		<path fill="#EDDC9D" d="M253.373,473.043v7.188h0.043c0.203,0.998,1.086,1.75,2.145,1.75s1.939-0.752,2.143-1.75h0.045v-7.188
			H253.373z"/>
		<path fill="#EDDC9D" d="M262.748,473.043v7.188h0.043c0.203,0.998,1.086,1.75,2.145,1.75s1.939-0.752,2.143-1.75h0.045v-7.188
			H262.748z"/>
		<path fill="#EDDC9D" d="M272.811,473.084v7.188h0.043c0.203,0.998,1.086,1.75,2.145,1.75s1.939-0.752,2.143-1.75h0.045v-7.188
			H272.811z"/>
		<g>
			<path fill="#FEFDED" d="M209.768,533.605c0.825,0.32,1.175,1.404,0.782,2.418l0,0c-0.394,1.014-1.381,1.576-2.207,1.256
				l-8.829-3.424c-0.826-0.32-1.176-1.404-0.782-2.418l0,0c0.393-1.014,1.38-1.578,2.207-1.258L209.768,533.605z"/>
			<path fill="#FEFDED" d="M207.435,539.648c0.825,0.318,1.175,1.402,0.782,2.418l0,0c-0.394,1.012-1.381,1.576-2.207,1.254
				l-8.829-3.422c-0.826-0.32-1.176-1.406-0.782-2.42l0,0c0.393-1.014,1.38-1.576,2.207-1.256L207.435,539.648z"/>
			<g>
				<path fill="#7E4344" d="M241.06,544.355c1.652,0,3.235,0.283,4.718,0.785c-0.033-0.133-0.062-0.268-0.099-0.398l-0.536-11.012
					l-36.605-0.324c-1.66-0.799-3.513-1.26-5.478-1.26c-6.996,0-12.667,5.672-12.667,12.668v3.498c0,5.289,3.243,9.816,7.847,11.713
					c-0.021-0.182-0.055-0.359-0.055-0.545c0-2.623,2.126-4.75,4.75-4.75s4.75,2.127,4.75,4.75c0,0.344-0.041,0.676-0.11,1h4.095
					c-0.069-0.324-0.11-0.656-0.11-1c0-2.623,2.126-4.75,4.75-4.75s4.75,2.127,4.75,4.75c0,0.344-0.041,0.676-0.11,1h5.429
					c-0.042-0.453-0.069-0.912-0.069-1.375C226.31,550.959,232.914,544.355,241.06,544.355z"/>
				<path fill="#FEFDED" d="M209.643,533.605c0.825,0.32,1.175,1.404,0.782,2.418l0,0c-0.394,1.014-1.381,1.576-2.207,1.256
					l-8.829-3.424c-0.826-0.32-1.176-1.404-0.782-2.418l0,0c0.393-1.014,1.38-1.578,2.207-1.258L209.643,533.605z"/>
				<path fill="#FEFDED" d="M207.309,539.648c0.825,0.318,1.175,1.402,0.782,2.418l0,0c-0.394,1.012-1.381,1.576-2.207,1.254
					l-8.829-3.422c-0.826-0.32-1.176-1.406-0.782-2.42l0,0c0.393-1.014,1.38-1.576,2.207-1.256L207.309,539.648z"/>
				<path fill="#683C3C" d="M245.888,550.418h0.068l-0.016-0.324c0.124-0.688,0.203-1.391,0.203-2.113
					c0-0.98-0.136-1.928-0.365-2.84c-1.483-0.502-3.066-0.785-4.718-0.785c-8.146,0-14.75,6.604-14.75,14.75
					c0,0.463,0.027,0.922,0.069,1.375h6.548C239.344,560.48,244.688,556.154,245.888,550.418z"/>
				<path fill="#683C3C" d="M216.31,554.73c-2.624,0-4.75,2.127-4.75,4.75c0,0.344,0.041,0.676,0.11,1h9.28
					c0.069-0.324,0.11-0.656,0.11-1C221.06,556.857,218.934,554.73,216.31,554.73z"/>
				<path fill="#683C3C" d="M202.935,554.73c-2.624,0-4.75,2.127-4.75,4.75c0,0.186,0.034,0.363,0.055,0.545
					c1.487,0.611,3.113,0.955,4.82,0.955c1.241,0,2.437-0.188,3.57-0.52c0.132,0.004,0.262,0.02,0.395,0.02h0.55
					c0.069-0.324,0.11-0.656,0.11-1C207.685,556.857,205.559,554.73,202.935,554.73z"/>
			</g>
			<g>
				<path fill="#7E4344" d="M284.895,544.355c1.652,0,3.234,0.283,4.717,0.785c-0.031-0.133-0.061-0.268-0.098-0.398l-0.537-11.012
					l-36.605-0.324c-1.659-0.799-3.513-1.26-5.478-1.26c-6.996,0-12.667,5.672-12.667,12.668v3.498
					c0,5.289,3.243,9.816,7.847,11.713c-0.021-0.182-0.055-0.359-0.055-0.545c0-2.623,2.126-4.75,4.75-4.75s4.75,2.127,4.75,4.75
					c0,0.344-0.04,0.676-0.11,1h4.096c-0.07-0.324-0.109-0.656-0.109-1c0-2.623,2.125-4.75,4.75-4.75c2.623,0,4.75,2.127,4.75,4.75
					c0,0.344-0.041,0.676-0.111,1h5.43c-0.041-0.453-0.068-0.912-0.068-1.375C270.145,550.959,276.748,544.355,284.895,544.355z"/>
				<path fill="#FEFDED" d="M253.477,533.605c0.824,0.32,1.175,1.404,0.781,2.418l0,0c-0.393,1.014-1.381,1.576-2.207,1.256
					l-8.828-3.424c-0.826-0.32-1.176-1.404-0.782-2.418l0,0c0.393-1.014,1.38-1.578,2.207-1.258L253.477,533.605z"/>
				<path fill="#FEFDED" d="M251.143,539.648c0.825,0.318,1.176,1.402,0.782,2.418l0,0c-0.394,1.012-1.381,1.576-2.207,1.254
					l-8.829-3.422c-0.826-0.32-1.176-1.406-0.782-2.42l0,0c0.393-1.014,1.38-1.576,2.207-1.256L251.143,539.648z"/>
				<path fill="#683C3C" d="M289.721,550.418h0.068l-0.016-0.324c0.125-0.688,0.203-1.391,0.203-2.113
					c0-0.98-0.137-1.928-0.365-2.84c-1.482-0.502-3.064-0.785-4.717-0.785c-8.146,0-14.75,6.604-14.75,14.75
					c0,0.463,0.027,0.922,0.068,1.375h6.549C283.178,560.48,288.521,556.154,289.721,550.418z"/>
				<path fill="#683C3C" d="M260.145,554.73c-2.625,0-4.75,2.127-4.75,4.75c0,0.344,0.039,0.676,0.109,1h9.279
					c0.07-0.324,0.111-0.656,0.111-1C264.895,556.857,262.768,554.73,260.145,554.73z"/>
				<path fill="#683C3C" d="M246.769,554.73c-2.624,0-4.75,2.127-4.75,4.75c0,0.186,0.034,0.363,0.055,0.545
					c1.487,0.611,3.113,0.955,4.82,0.955c1.241,0,2.437-0.188,3.57-0.52c0.132,0.004,0.262,0.02,0.395,0.02h0.55
					c0.07-0.324,0.11-0.656,0.11-1C251.519,556.857,249.392,554.73,246.769,554.73z"/>
			</g>
		</g>
	</g>
</g>
<ellipse fill="#DA7F56" cx="243.13" cy="209.06" rx="146.5" ry="135.5"/>
<circle fill="#DE6D56" cx="168.313" cy="263.542" r="28.667"/>
<circle fill="#DE6D56" cx="300.313" cy="263.542" r="28.667"/>
<ellipse cx="267.896" cy="240.06" rx="12.75" ry="15"/>
<ellipse cx="184.896" cy="240.06" rx="12.75" ry="15"/>
<path fill="#CA5941" d="M207.981,259.865c-0.041,0-0.082,0-0.123-0.003c-1.372-0.067-2.433-1.218-2.376-2.589
	c0.006-0.146,0.805-14.564,18.665-14.564c17.786,0,18.983,13.681,18.994,13.818c0.1,1.377-0.936,2.574-2.313,2.675
	c-1.381,0.103-2.574-0.937-2.674-2.313c-0.084-0.92-1.205-9.18-14.006-9.18c-12.747,0-13.613,8.786-13.669,9.788
	C210.402,258.826,209.299,259.865,207.981,259.865z"/>
<path fill="#B13E3C" d="M212.15,281.057c5.512,11.91,17.364,20.152,31.101,20.152c18.355,0,33.349-14.709,34.341-33.233
	L212.15,281.057z"/>
<g>
	<path fill="#DA7F56" d="M95.746,416.311l86.918-35.205l-10.25-30.25l-69.561,23.311l-6.225-5.793
		c-1.139-1.387-2.865-2.27-4.798-2.27c-3.429,0-6.209,2.779-6.209,6.209c0,0.857,0.173,1.672,0.487,2.414l-0.111,0.086l0.345,0.398
		c0.439,0.832,1.064,1.547,1.816,2.1l1.269,1.467l-15.397,7.051c-2.593,0.66-4.512,3.004-4.512,5.803
		c0,3.311,2.684,5.994,5.995,5.994c1.314,0,2.526-0.428,3.514-1.145l3.856-1.646l0.05,0.725l-7.52,3.234l0.005,0.02
		c-2.087,0.914-3.546,2.994-3.546,5.418c0,3.268,2.649,5.916,5.917,5.916c1.367,0,2.622-0.467,3.624-1.246l5.938-2.357l0.031-0.291
		l1.032,0.541l-4.75,2.125l0,0c-2.261,0.838-3.875,3.01-3.875,5.563c0,3.279,2.658,5.938,5.938,5.938
		c0.978,0,1.898-0.242,2.711-0.66l7.289-3.34L95.746,416.311z"/>
	<polygon fill="#DA7F56" points="207.164,441.48 204.331,473.563 283.248,473.563 280.58,441.564 	"/>
	<path fill="#DA7F56" d="M404.029,396.48c0.988,0.717,2.199,1.145,3.514,1.145c3.313,0,5.996-2.684,5.996-5.994
		c0-2.799-1.92-5.143-4.514-5.803l-15.396-7.051l1.27-1.467c0.752-0.553,1.377-1.268,1.816-2.1l0.344-0.398l-0.111-0.086
		c0.314-0.742,0.486-1.557,0.486-2.414c0-3.43-2.779-6.209-6.209-6.209c-1.932,0-3.658,0.883-4.797,2.27l-6.225,5.793
		l-47.453-15.902l-9.076-3.043l-13.031-4.365l-10.25,30.25l4.418,1.789l13.068,5.293l8.971,3.635l12.711,5.146l47.75,19.342
		l0.02,0.107l7.289,3.34c0.813,0.418,1.732,0.66,2.711,0.66c3.279,0,5.938-2.658,5.938-5.938c0-2.553-1.615-4.725-3.875-5.563l0,0
		l-4.75-2.125l1.031-0.541l0.031,0.291l5.938,2.357c1.002,0.779,2.258,1.246,3.625,1.246c3.268,0,5.916-2.648,5.916-5.916
		c0-2.424-1.459-4.504-3.547-5.418l0.006-0.02l-7.52-3.234l0.049-0.725L404.029,396.48z"/>
</g>
<g>
	<g>
		<g>
			<g>
				<path fill="#D3BE8A" d="M336.086,413.725c0,26.697-21.643,48.34-48.34,48.34h-78.551c-26.699,0-48.341-21.643-48.341-48.34
					v-47.535c0-26.697,21.642-48.338,48.341-48.338h78.551c26.697,0,48.34,21.641,48.34,48.338V413.725z"/>
				<path fill="#B9A17A" d="M329.078,343.77c-33.938-6.268-35.881,32.539-35.992,36.75l-132.257,0.166v5.75l132.75-0.166v76
					l5.502-0.834l0.248-75.166h0.125v-5.75h-0.125v-0.25h-0.443c8.773-40.076,27.443-29.375,27.443-29.375l4.75,2.625l2.5-2.666
					L329.078,343.77z"/>
			</g>
			<g>
				<polygon fill="#FEFDED" points="363.338,137.036 371.359,88.472 379.383,39.908 417.43,71.138 455.477,102.368 409.406,119.702 
									"/>
				<g>
					<path fill="#90D4D7" d="M422.246,93.686c0-0.265-0.027-0.523-0.039-0.786l-9.137-1.634l-1.16,6.495l9.281,1.66
						C421.861,97.634,422.246,95.707,422.246,93.686z"/>
					
						<rect x="402.746" y="90.084" transform="matrix(0.9844 0.1761 -0.1761 0.9844 22.7918 -70.0656)" fill="#90D4D7" width="6.843" height="6.598"/>
					<path fill="#90D4D7" d="M410.646,87.785l1.635-9.145c-1.957-0.829-4.109-1.288-6.367-1.288c-0.121,0-0.238,0.016-0.359,0.018
						l-1.646,9.21L410.646,87.785z"/>
					<path fill="#90D4D7" d="M400.428,89.005l-9.551-1.708c-0.834,1.962-1.297,4.121-1.297,6.388c0,0.028,0.004,0.055,0.004,0.083
						l9.682,1.731L400.428,89.005z"/>
					<path fill="#90D4D7" d="M411.381,100.714l-1.576,8.819c4.225-1.035,7.795-3.705,10.014-7.311L411.381,100.714z"/>
					<path fill="#90D4D7" d="M398.738,98.453l-8.844-1.581c0.879,4.436,3.557,8.215,7.236,10.57L398.738,98.453z"/>
					<path fill="#90D4D7" d="M408.428,100.186l-6.736-1.205l-1.768,9.889c1.855,0.733,3.873,1.149,5.99,1.149
						c0.258,0,0.508-0.027,0.764-0.039L408.428,100.186z"/>
					<path fill="#90D4D7" d="M413.6,88.313l8.154,1.458c-0.979-3.978-3.398-7.389-6.695-9.62L413.6,88.313z"/>
					<path fill="#90D4D7" d="M400.955,86.052l1.488-8.323c-4.162,0.901-7.734,3.382-10.051,6.792L400.955,86.052z"/>
				</g>
			</g>
			<path fill="#7E4344" d="M387.895,44.568c0.471-2.671-1.238-5.205-3.811-5.657c-2.576-0.453-5.045,1.347-5.514,4.019
				l-54.898,312.289l9.076,3.043L387.895,44.568z"/>
			<path fill="#7E4344" d="M310.129,432.252c-0.471,2.672,1.236,5.205,3.811,5.656c2.574,0.453,5.045-1.346,5.514-4.018
				l3.834-21.809h-9.611L310.129,432.252z"/>
			<polygon fill="#D3BE8A" points="318.877,388.186 305.809,382.893 305.809,412.082 314.676,412.082 324.287,412.082 
				340.559,412.082 340.559,396.967 327.848,391.82 			"/>
		</g>
		<g>
			<path fill="#FEFDED" d="M274.626,341.639c-2.191,0.299-5.277,0.615-9.592,0.875l-65.541,46.439l-3.477,17.65l26.407-0.141
				l58.22-41.25L274.626,341.639z"/>
			<g>
				<path fill="#EDDC9D" d="M265.034,342.514c-5.611,0.34-13.292,0.59-23.768,0.59c-33.25,0-34.75-3.5-34.75-3.5l-33.75,11.25
					l10.083,30.25l19.667-7.5l-3.023,15.35L265.034,342.514z"/>
				<path fill="#EDDC9D" d="M310.828,350.416l-29.81-9.381l-1.377-0.432c0,0-1.01,0.49-5.016,1.035l6.018,23.574l-58.22,41.25
					l68.342-0.359l-2.727-11.906l-4.773-20.844l16.75,7.5L310.828,350.416z"/>
			</g>
			<polygon fill="#D3BE8A" points="196.735,375.791 192.985,377.291 183.054,347.129 186.85,345.875 			"/>
			<polygon fill="#D3BE8A" points="290.609,376.666 286.965,375.043 296.172,345.822 299.891,346.979 			"/>
			<circle fill="#EF3E5B" cx="247.017" cy="361.229" r="8.125"/>
			<polygon fill="#FFC446" points="255.502,376.793 265.142,360.098 274.782,376.793 			"/>
			<circle fill="#23AE92" cx="244.017" cy="384.354" r="8.125"/>
		</g>
		<g>
			<polygon fill="#7E4344" points="210.933,406.686 207.267,441.854 280.601,441.854 278.101,406.186 			"/>
			<path fill="#693C3C" d="M210.933,412.061c-0.053,0.033-0.646,5.543-0.646,5.543s6.583-4.938,6.646-7.063l-2.854-2.271
				C214.079,408.27,212.642,410.998,210.933,412.061z"/>
			<path fill="#693C3C" d="M265.157,412.729l3.188-2.063c0,0,4.215,4.313,9.715,4.77l0.541,4.168
				C278.601,419.604,269.591,418.604,265.157,412.729z"/>
			<polygon fill="#693C3C" points="209.017,430.604 279.185,430.604 279.685,434.52 208.517,434.52 			"/>
		</g>
		<g>
			<polygon fill="#FEFDED" points="204.434,473.52 283.6,473.52 287.893,522.104 200.517,522.104 			"/>
			<polygon fill="#EDDC9D" points="200.017,522.729 287.893,522.604 288.893,533.479 199.433,533.52 			"/>
			<path fill="#EDDC9D" d="M211.579,473.041v7.188h0.044c0.203,0.998,1.085,1.75,2.144,1.75s1.94-0.752,2.144-1.75h0.044v-7.188
				H211.579z"/>
			<path fill="#EDDC9D" d="M220.954,473.02v7.188h0.044c0.203,0.998,1.085,1.75,2.144,1.75s1.94-0.752,2.144-1.75h0.044v-7.188
				H220.954z"/>
			<path fill="#EDDC9D" d="M230.996,473.041v7.188h0.044c0.203,0.998,1.085,1.75,2.144,1.75s1.94-0.752,2.144-1.75h0.044v-7.188
				H230.996z"/>
			<path fill="#EDDC9D" d="M253.37,473.041v7.188h0.045c0.203,0.998,1.085,1.75,2.143,1.75c1.059,0,1.941-0.752,2.145-1.75h0.043
				v-7.188H253.37z"/>
			<path fill="#EDDC9D" d="M262.747,473.041v7.188h0.043c0.203,0.998,1.086,1.75,2.145,1.75s1.939-0.752,2.143-1.75h0.045v-7.188
				H262.747z"/>
			<path fill="#EDDC9D" d="M272.81,473.082v7.188h0.043c0.203,0.998,1.086,1.75,2.145,1.75s1.939-0.752,2.143-1.75h0.045v-7.188
				H272.81z"/>
			<g>
				<path fill="#FEFDED" d="M209.766,533.604c0.825,0.32,1.175,1.404,0.782,2.418l0,0c-0.394,1.014-1.381,1.576-2.207,1.256
					l-8.829-3.424c-0.826-0.32-1.176-1.404-0.782-2.418l0,0c0.393-1.014,1.38-1.578,2.207-1.258L209.766,533.604z"/>
				<path fill="#FEFDED" d="M207.433,539.646c0.825,0.318,1.175,1.402,0.782,2.418l0,0c-0.394,1.012-1.381,1.576-2.207,1.254
					l-8.829-3.422c-0.826-0.32-1.176-1.406-0.782-2.42l0,0c0.393-1.014,1.38-1.576,2.207-1.256L207.433,539.646z"/>
				<g>
					<path fill="#7E4344" d="M241.058,544.354c1.652,0,3.235,0.283,4.718,0.785c-0.033-0.133-0.062-0.268-0.099-0.398l-0.536-11.012
						l-36.605-0.324c-1.66-0.799-3.513-1.26-5.478-1.26c-6.996,0-12.667,5.672-12.667,12.668v3.498
						c0,5.289,3.243,9.816,7.847,11.713c-0.021-0.182-0.055-0.359-0.055-0.545c0-2.623,2.126-4.75,4.75-4.75s4.75,2.127,4.75,4.75
						c0,0.344-0.041,0.676-0.11,1h4.095c-0.069-0.324-0.11-0.656-0.11-1c0-2.623,2.126-4.75,4.75-4.75s4.75,2.127,4.75,4.75
						c0,0.344-0.041,0.676-0.11,1h5.429c-0.042-0.453-0.069-0.912-0.069-1.375C226.308,550.957,232.912,544.354,241.058,544.354z"/>
					<path fill="#FEFDED" d="M209.641,533.604c0.825,0.32,1.175,1.404,0.782,2.418l0,0c-0.394,1.014-1.381,1.576-2.207,1.256
						l-8.829-3.424c-0.826-0.32-1.176-1.404-0.782-2.418l0,0c0.393-1.014,1.38-1.578,2.207-1.258L209.641,533.604z"/>
					<path fill="#FEFDED" d="M207.307,539.646c0.825,0.318,1.175,1.402,0.782,2.418l0,0c-0.394,1.012-1.381,1.576-2.207,1.254
						l-8.829-3.422c-0.826-0.32-1.176-1.406-0.782-2.42l0,0c0.393-1.014,1.38-1.576,2.207-1.256L207.307,539.646z"/>
					<path fill="#683C3C" d="M245.886,550.416h0.068l-0.016-0.324c0.124-0.688,0.203-1.391,0.203-2.113
						c0-0.98-0.136-1.928-0.365-2.84c-1.483-0.502-3.066-0.785-4.718-0.785c-8.146,0-14.75,6.604-14.75,14.75
						c0,0.463,0.027,0.922,0.069,1.375h6.548C239.342,560.479,244.686,556.152,245.886,550.416z"/>
					<path fill="#683C3C" d="M216.308,554.729c-2.624,0-4.75,2.127-4.75,4.75c0,0.344,0.041,0.676,0.11,1h9.28
						c0.069-0.324,0.11-0.656,0.11-1C221.058,556.855,218.932,554.729,216.308,554.729z"/>
					<path fill="#683C3C" d="M202.933,554.729c-2.624,0-4.75,2.127-4.75,4.75c0,0.186,0.034,0.363,0.055,0.545
						c1.487,0.611,3.113,0.955,4.82,0.955c1.241,0,2.437-0.188,3.57-0.52c0.132,0.004,0.262,0.02,0.395,0.02h0.55
						c0.069-0.324,0.11-0.656,0.11-1C207.683,556.855,205.557,554.729,202.933,554.729z"/>
				</g>
				<g>
					<path fill="#7E4344" d="M284.893,544.354c1.652,0,3.234,0.283,4.717,0.785c-0.031-0.133-0.061-0.268-0.098-0.398l-0.537-11.012
						l-36.604-0.324c-1.66-0.799-3.514-1.26-5.479-1.26c-6.996,0-12.667,5.672-12.667,12.668v3.498
						c0,5.289,3.243,9.816,7.847,11.713c-0.021-0.182-0.055-0.359-0.055-0.545c0-2.623,2.126-4.75,4.75-4.75
						c2.623,0,4.75,2.127,4.75,4.75c0,0.344-0.041,0.676-0.109,1h4.094c-0.068-0.324-0.109-0.656-0.109-1
						c0-2.623,2.127-4.75,4.752-4.75c2.623,0,4.75,2.127,4.75,4.75c0,0.344-0.041,0.676-0.111,1h5.43
						c-0.041-0.453-0.068-0.912-0.068-1.375C270.144,550.957,276.747,544.354,284.893,544.354z"/>
					<path fill="#FEFDED" d="M253.474,533.604c0.826,0.32,1.176,1.404,0.783,2.418l0,0c-0.395,1.014-1.382,1.576-2.207,1.256
						l-8.829-3.424c-0.826-0.32-1.176-1.404-0.782-2.418l0,0c0.393-1.014,1.38-1.578,2.207-1.258L253.474,533.604z"/>
					<path fill="#FEFDED" d="M251.141,539.646c0.825,0.318,1.175,1.402,0.782,2.418l0,0c-0.394,1.012-1.381,1.576-2.207,1.254
						l-8.829-3.422c-0.826-0.32-1.176-1.406-0.782-2.42l0,0c0.393-1.014,1.38-1.576,2.207-1.256L251.141,539.646z"/>
					<path fill="#683C3C" d="M289.719,550.416h0.068l-0.016-0.324c0.125-0.688,0.203-1.391,0.203-2.113
						c0-0.98-0.137-1.928-0.365-2.84c-1.482-0.502-3.064-0.785-4.717-0.785c-8.146,0-14.749,6.604-14.749,14.75
						c0,0.463,0.027,0.922,0.068,1.375h6.549C283.176,560.479,288.52,556.152,289.719,550.416z"/>
					<path fill="#683C3C" d="M260.144,554.729c-2.625,0-4.752,2.127-4.752,4.75c0,0.344,0.041,0.676,0.109,1h9.281
						c0.07-0.324,0.111-0.656,0.111-1C264.894,556.855,262.767,554.729,260.144,554.729z"/>
					<path fill="#683C3C" d="M246.767,554.729c-2.624,0-4.75,2.127-4.75,4.75c0,0.186,0.034,0.363,0.055,0.545
						c1.487,0.611,3.113,0.955,4.82,0.955c1.24,0,2.437-0.188,3.57-0.52c0.132,0.004,0.262,0.02,0.395,0.02h0.551
						c0.068-0.324,0.109-0.656,0.109-1C251.517,556.855,249.39,554.729,246.767,554.729z"/>
				</g>
			</g>
		</g>
	</g>
	<ellipse fill="${skin}" cx="243.128" cy="209.058" rx="146.5" ry="135.5"/>
	<circle fill="#DE6D56" cx="168.312" cy="263.54" r="28.667"/>
	<circle fill="#DE6D56" cx="300.312" cy="263.54" r="28.667"/>
	<ellipse cx="267.894" cy="240.058" rx="12.75" ry="15" fill="${eye}"/>
	<ellipse cx="184.895" cy="240.058" rx="12.75" ry="15" fill="${eye}"/>
	<path fill="#CA5941" d="M207.979,259.863c-0.041,0-0.082,0-0.123-0.003c-1.372-0.067-2.433-1.218-2.376-2.589
		c0.006-0.146,0.805-14.564,18.665-14.564c17.786,0,18.983,13.681,18.994,13.818c0.1,1.377-0.936,2.574-2.313,2.675
		c-1.381,0.103-2.574-0.937-2.674-2.313c-0.084-0.92-1.205-9.18-14.006-9.18c-12.747,0-13.613,8.786-13.669,9.788
		C210.4,258.824,209.297,259.863,207.979,259.863z"/>
	<path fill="#B13E3C" d="M212.148,281.055c5.512,11.91,17.364,20.152,31.101,20.152c18.354,0,33.348-14.709,34.34-33.233
		L212.148,281.055z"/>
	<g>
		<path fill="${skin}" d="M95.744,416.309l86.918-35.205l-10.25-30.25l-69.561,23.311l-6.225-5.793
			c-1.139-1.387-2.865-2.27-4.798-2.27c-3.429,0-6.209,2.779-6.209,6.209c0,0.857,0.173,1.672,0.487,2.414l-0.111,0.086l0.345,0.398
			c0.439,0.832,1.064,1.547,1.816,2.1l1.269,1.467l-15.397,7.051c-2.593,0.66-4.512,3.004-4.512,5.803
			c0,3.311,2.684,5.994,5.995,5.994c1.314,0,2.526-0.428,3.514-1.145l3.856-1.646l0.05,0.725l-7.52,3.234l0.005,0.02
			c-2.087,0.914-3.546,2.994-3.546,5.418c0,3.268,2.649,5.916,5.917,5.916c1.367,0,2.622-0.467,3.624-1.246l5.938-2.357l0.031-0.291
			l1.032,0.541l-4.75,2.125l0,0c-2.261,0.838-3.875,3.01-3.875,5.563c0,3.279,2.658,5.938,5.938,5.938
			c0.978,0,1.898-0.242,2.711-0.66l7.289-3.34L95.744,416.309z"/>
		<polygon fill="${skin}" points="207.162,441.479 204.329,473.561 283.246,473.561 280.579,441.563 		"/>
		<path fill="${skin}" d="M404.027,396.479c0.988,0.717,2.199,1.145,3.514,1.145c3.313,0,5.996-2.684,5.996-5.994
			c0-2.799-1.92-5.143-4.514-5.803l-15.396-7.051l1.27-1.467c0.752-0.553,1.377-1.268,1.816-2.1l0.344-0.398l-0.111-0.086
			c0.314-0.742,0.486-1.557,0.486-2.414c0-3.43-2.779-6.209-6.209-6.209c-1.932,0-3.658,0.883-4.797,2.27l-6.225,5.793
			l-47.453-15.902l-9.076-3.043l-13.031-4.365l-10.25,30.25l4.418,1.789l13.068,5.293l8.971,3.635l12.711,5.146l47.75,19.342
			l0.02,0.107l7.289,3.34c0.813,0.418,1.732,0.66,2.711,0.66c3.279,0,5.938-2.658,5.938-5.938c0-2.553-1.615-4.725-3.875-5.563l0,0
			l-4.75-2.125l1.031-0.541l0.031,0.291l5.938,2.357c1.002,0.779,2.258,1.246,3.625,1.246c3.268,0,5.916-2.648,5.916-5.916
			c0-2.424-1.459-4.504-3.547-5.418l0.006-0.02l-7.52-3.234l0.049-0.725L404.027,396.479z"/>
	</g>
	<path  fill="${hair}" d="M411.358,189.162c6.078-2.59,10.341-8.618,10.341-15.643c0-9.389-7.611-17-17-17
		c-0.469,0-0.93,0.032-1.39,0.07c1.663-2.627,2.64-5.732,2.64-9.071c0-9.389-7.611-17-17-17c-2.803,0-5.439,0.69-7.771,1.892
		l-8.085,2.127c-39.316-70.913-132.728-68.186-132.728-68.186c-62.167,2.167-106.021,36.401-124.417,68.292
		c-2.006-0.984-3.875-1-3.875-1l-1.875-0.625c-4.25-1.25-6.126-1.75-10.125-1.75c-9.112,0-15.875,8.137-15.875,17.25
		c0,3.648,1.198,7.008,3.203,9.741c-0.882-0.146-1.78-0.24-2.703-0.24c-9.112,0-16.5,7.387-16.5,16.5
		c0,7.994,5.686,14.656,13.233,16.174c-8.037,1.107-14.233,7.984-14.233,16.326c0,6.549,3.826,12.191,9.357,14.855l-0.023,0.145
		c0,0,8.897,5.6,22.433,8.633c0.043,0.238,0.068,0.365,0.068,0.365c1.353,0.171,2.687,0.31,4.015,0.438
		c7.547,1.287,16.254,1.646,25.511-0.092c77.382-8.572,102.475-92.345,102.475-92.345c48.002,130.666,157.998,92.667,157.998,92.667
		s14.141-4.594,23.929-10.942c3.043-1.382,5.601-3.63,7.367-6.435c0.756-1.041,1.289-2.101,1.559-3.17
		c0.676-1.832,1.063-3.803,1.063-5.869C422.949,197.773,418.092,191.423,411.358,189.162z"/>
</g>
</svg>

''';
    if (style == 1)
      return svg1;
    else if (style == 2)
      return svg2;
    else if (style == 3) return svg3;
  }

  @override
  Widget build(BuildContext context) {
    return getCharacter();
  }
}
