import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

import 'Gold/goldC.dart';
import 'Gold/goldD1.dart';
import 'Gold/goldD2.dart';
import 'Gold/goldE.dart';


class SpeedGold extends StatefulWidget{

  String type = "C";

  @override
  Gold createState() => Gold();
}

class Gold extends State<SpeedGold>{
  @override
  Widget build(BuildContext context) {
    if(widget.type == "D-1")
      return GoldD1();
    else if(widget.type == "C")
      return GoldC();
    else if(widget.type == "D-2")
      return GoldD2();
    else
      return GoldE();
  }
}