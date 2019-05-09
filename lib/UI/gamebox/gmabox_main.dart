import 'package:flutter/material.dart';

class GameBox extends StatelessWidget {


  Widget body(size) {
    return Container(
      width: size.width,
      height: size.height,
      child: Image.asset(
        "assets/gamebox/img/main/main_start.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget btn(size) {
    return Container(
      width: size.width,
      child: Center(
        child: Image.asset(
          "assets/gamebox/img/main/main_button.png",
          width: 100,
          height: 100,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Stack(
        children: <Widget>[
          body(size),
          Positioned(
            bottom: 20,
            child: btn(size),
          ),
        ],
      ),
    );
  }
}
