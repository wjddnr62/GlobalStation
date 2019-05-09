import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'gameDialog.dart';

class LobbyPage extends StatefulWidget {
  @override
  LobbyHomePage createState() => LobbyHomePage();
}

class LobbyHomePage extends State<LobbyPage> {
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
            gameStart(idx);
          },
          child: Container(
            width: size.width,
            height: size.height,
            child: Image.asset(
              lobbyImg[idx],
              fit: BoxFit.cover,
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

  void gameStart(int idx) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => GameDialog()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(MediaQuery.of(context).size),
    );
  }
}
