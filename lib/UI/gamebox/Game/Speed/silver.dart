import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

import 'Silver/silverC.dart';
import 'Silver/silverD1.dart';
import 'Silver/silverD2.dart';
import 'Silver/silverE.dart';


class SpeedSilver extends StatefulWidget{

  String type = "E";

  @override
  Silver createState() => Silver();
}

class Silver extends State<SpeedSilver>{
  @override
  Widget build(BuildContext context) {
   if(widget.type == "D-1")
     return SilverD1();
   else if(widget.type == "C")
     return SilverC();
   else if(widget.type == "D-2")
     return SilverD2();
   else
     return SilverE();
  }
}