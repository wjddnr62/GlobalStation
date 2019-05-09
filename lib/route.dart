import 'package:flutter/material.dart';

import 'UI/login.dart';


import 'UI/gamebox/gamebox_main.dart';
import 'UI/gamebox/lobby.dart';

final routes = {
  '/Login': (BuildContext context) => Login(),


  //-------------GameBox----------------
  '/GameBox' : (BuildContext context) => GameBox(),
  '/Lobby' : (BuildContext context) => LobbyPage(),
};