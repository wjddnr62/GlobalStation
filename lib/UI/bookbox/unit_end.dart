import 'package:flutter/material.dart';

import '../../theme.dart';

Widget unitEnd(String unit_level, String unit_name, double appbar_size,
    BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height -
        appbar_size -
        MediaQuery.of(context).padding.top,
    color: unitColor,
    child: Stack(
      children: <Widget>[
        Center(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo/icon_logo.png',
                  width: 300,
                  height: 100,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Container(
                    width: 80,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: yellowColor),
                    child: Center(
                      child: Text(
                        unit_level.substring(0, 1).toUpperCase() +
                            unit_level.substring(1),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    unit_name,
                    style: TextStyle(
                        fontSize: unitFontSize + 4,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
