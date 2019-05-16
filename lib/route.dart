import 'package:flutter/material.dart';
//import 'package:lms_flutter/UI/bookbox/phonics/phonics_1_SB_1.dart';

import 'UI/login.dart';


import 'UI/gamebox/gamebox_main.dart';
import 'UI/gamebox/lobby.dart';
import 'UI/gamebox/gamebox_main.dart';
import 'UI/bookbox/bookbox_main.dart';

final routes = {
  '/Login': (BuildContext context) => Login(),


  //-------------GameBox----------------
  '/GameBox' : (BuildContext context) => GameBox(),
  '/Lobby' : (BuildContext context) => LobbyPage(),


  //-------------BookBox----------------
  '/BookBox' : (BuildContext context) => BookBox(),

  //------------Phonics-----------------
//  '/phonics_1_SB_1' : (BuildContext context) => phonics_1_SB_1(),

};