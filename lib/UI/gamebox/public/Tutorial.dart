import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tutorial extends StatefulWidget {
  Size size;

  Tutorial({Key key, this.size}) : super(key: key);

  @override
  TutorialView createState() => TutorialView();
}

class TutorialView extends State<Tutorial> {
  bool tutoCheck = false;
  SharedPreferences sharedPreferences;


  @override
  void initState() {
    super.initState();
  }

  tutoUpdate() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt("tuto_status", 1);
  }

  Widget tutorial(Size size) {
    return tutoCheck ? Text("") :Container(
      width: MediaQuery.of(context).size.width,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
              child: Image.asset(
            "assets/gamebox/img/tutorial.png",
            height: size.height,
            fit: BoxFit.fill,
          )),
          Positioned(
            bottom: 10,
            right: 10,
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    tutoCheck = true;
                    tutoUpdate();
                  });
                },
                child: Image.asset(
                  "assets/gamebox/img/tutorial_close.png",
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return tutorial(widget.size);
  }
}
