import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class CharacterPage extends StatefulWidget {
  @override
  Character createState() => Character();
}

class Character extends State<CharacterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: body(),
        ),
      ),
    );
  }

  Widget body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: beige,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          topItem(context),
          character(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: dialogBoxColor,
                  width: 4,
                )),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: dialogBoxColor,
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: dialogBoxColor,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: dialogBoxColor,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: dialogBoxColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      child: eyeColor(),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    Padding(
                      child: skinColor(),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    Padding(
                      child: hairColor(),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),

                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: dialogBoxColor,
                  width: 4,
                )),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: dialogBoxColor,
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: dialogBoxColor,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: dialogBoxColor,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 5,
                  child: CircleAvatar(
                    radius: 5,
                    backgroundColor: dialogBoxColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: <Widget>[
                          Text("헤어스타일"),
                          SizedBox(height: 10,),
                          hairStyle(),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: <Widget>[
                          Text("모자"),
                          SizedBox(height: 10,),
                          hat(),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Image.asset("assets/gamebox/img/next_btn.png",
              fit: BoxFit.contain,
              width: 80,),
            ),
          )
        ],
      ),
    );
  }

  Widget character() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: skyBlue,
      ),
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Image.asset(
        "assets/gamebox/img/main_character.png",
        fit: BoxFit.contain,
        width: 120,
      ),
    );
  }

  Widget eyeColor() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text(
              "눈색",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/gamebox/img/charactor/eye/eye1.png",
                  fit: BoxFit.contain,
                  width: 20,
                ),
                defaultSizedBox(),
                Image.asset(
                  "assets/gamebox/img/charactor/eye/eye2.png",
                  fit: BoxFit.contain,
                  width: 20,
                ),
                defaultSizedBox(),
                Image.asset(
                  "assets/gamebox/img/charactor/eye/eye3.png",
                  fit: BoxFit.contain,
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget skinColor() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text(
              "피부색",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Row(
              children: <Widget>[
                Image.asset(
                  "assets/gamebox/img/charactor/skin/skin1.png",
                  fit: BoxFit.contain,
                  width: 20,
                ),
                defaultSizedBox(),
                Image.asset(
                  "assets/gamebox/img/charactor/skin/skin2.png",
                  fit: BoxFit.contain,
                  width: 20,
                ),
                defaultSizedBox(),
                Image.asset(
                  "assets/gamebox/img/charactor/skin/skin3.png",
                  fit: BoxFit.contain,
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget hairColor() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text(
              "머리색",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/gamebox/img/charactor/hair/hair1.png",
                      fit: BoxFit.contain,
                      width: 20,
                    ),
                    defaultSizedBox(),
                    Image.asset(
                      "assets/gamebox/img/charactor/hair/hair2.png",
                      fit: BoxFit.contain,
                      width: 20,
                    ),
                    defaultSizedBox(),
                    Image.asset(
                      "assets/gamebox/img/charactor/hair/hair3.png",
                      fit: BoxFit.contain,
                      width: 20,
                    ),
                    defaultSizedBox(),
                    Image.asset(
                      "assets/gamebox/img/charactor/hair/hair4.png",
                      fit: BoxFit.contain,
                      width: 20,
                    ),
                    defaultSizedBox(),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Image.asset(
                      "assets/gamebox/img/charactor/hair/hair5.png",
                      fit: BoxFit.contain,
                      width: 20,
                    ),
                    defaultSizedBox(),
                    Image.asset(
                      "assets/gamebox/img/charactor/hair/hair6.png",
                      fit: BoxFit.contain,
                      width: 20,
                    ),
                    defaultSizedBox(),
                    Image.asset(
                      "assets/gamebox/img/charactor/hair/hair7.png",
                      fit: BoxFit.contain,
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget hairStyle() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20,),
        Expanded(
          child: Image.asset(
            "assets/gamebox/img/charactor/hairStyle/hair_style3.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Image.asset(
            "assets/gamebox/img/charactor/hairStyle/hair_style2.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Image.asset(
            "assets/gamebox/img/charactor/hairStyle/hair_style1.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }

  Widget hat() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20,),
        Expanded(
          child: Image.asset(
            "assets/gamebox/img/charactor/hat/hat3.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Image.asset(
            "assets/gamebox/img/charactor/hat/hat2.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Image.asset(
            "assets/gamebox/img/charactor/hat/hat1.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 20,),
      ],
    );
  }

  Widget topItem(context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.center,
            child: Text("Make Your Character!"),
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

  Widget defaultSizedBox(){
    return SizedBox(width: 5,);
  }
  Widget default2xSizedBox(){
    return SizedBox(width: 10,);
  }
}
