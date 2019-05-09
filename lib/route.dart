import 'package:flutter/material.dart';

import 'UI/login.dart';
import 'UI/gamebox/gmabox_main.dart';
import 'UI/bookbox/bookbox_main.dart';

final routes = {
  '/Login': (BuildContext context) => Login(),


  //-------------GameBox----------------
  '/GameBox' : (BuildContext context) => GameBox(),


  //-------------BookBox----------------
  '/BookBox' : (BuildContext context) => BookBox(),

};