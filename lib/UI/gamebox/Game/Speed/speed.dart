import 'package:flutter/material.dart';
import 'package:lms_flutter/provider/speed_provider.dart';
import 'package:lms_flutter/bloc/speed_game_bloc.dart';
import 'phonics.dart';
import 'bronze.dart';
import 'silver.dart';
import 'gold.dart';
import 'diamond.dart';

//List<Widget> views;

//class SpeedGame extends StatefulWidget {
//  String level;
//  int chapter;
//
//  SpeedGame({Key key, this.level, this.chapter}) : super(key: key);
//
//  @override
//  Game createState() => Game();
//}
//
//class Game extends State<SpeedGame> {
//  @override
//  Widget build(BuildContext context) {
//    if (widget.level.substring(0,1) == "P")
//      return SpeedPhonics();
//    else if (widget.level.substring(0,1) == "B")
//      return SpeedBronze(level: widget.level,chapter: widget.chapter,);
//    else if (widget.level.substring(0,1) == "S")
//      return SpeedSilver();
//    else if (widget.level.substring(0,1) == "G")
//      return SpeedGold();
//    else if (widget.level.substring(0,1) == "D") return SpeedDiamond();
//  }
//}
//
//List<Widget> getViews(){
//  return views;
//}
//
//
//class SpeedGame {
//  String level;
//  int chapter;
//
//  SpeedGame({this.level, this.chapter});
//
//  List<Widget> getViews(){
//    SpeedBronze(level: level,chapter: chapter).getViews();
////    if (level.substring(0,1) == "B")
////      return SpeedBronze(level: level,chapter: chapter).getViews();
//  }
//}
