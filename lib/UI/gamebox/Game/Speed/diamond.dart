import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

import 'Diamond/diamondC.dart';
import 'Diamond/diamondD1.dart';
import 'Diamond/diamondD2.dart';
import 'Diamond/diamondE.dart';


class SpeedDiamond extends StatefulWidget{

  String type = "E";

  @override
  Diamond createState() => Diamond();
}

class Diamond extends State<SpeedDiamond>{
  @override
  Widget build(BuildContext context) {
    if(widget.type == "D-1")
      return DiamondD1();
    else if(widget.type == "C")
      return DiamondC();
    else if(widget.type == "D-2")
      return DiamondD2();
    else
      return DiamondE();
  }
}