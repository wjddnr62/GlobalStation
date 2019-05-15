import 'package:flutter/material.dart';
import 'package:lms_flutter/theme.dart';

import 'Bronze/bronzeB.dart';
import 'Bronze/bronzeC.dart';


class SpeedBronze extends StatefulWidget{

  String type = "C";

  @override
  Bronze createState() => Bronze();
}

class Bronze extends State<SpeedBronze>{
  @override
  Widget build(BuildContext context) {
    if(widget.type == "B"){
      return BronzeB();
    }else
      return BronzeC();
  }
}