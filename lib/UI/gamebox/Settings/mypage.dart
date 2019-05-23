import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

class myPage extends StatelessWidget{


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

  Widget body(context){
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

  Widget mainColumn(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 100,
          child: topItem(context),
        ),

      ],
    );
  }

  Widget topItem(context){
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
              child: Image.asset("assets/gamebox/img/close_button.png",
                fit: BoxFit.contain,
                width: 30,
                height: 30,),
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