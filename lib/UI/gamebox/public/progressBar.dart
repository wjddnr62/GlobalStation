import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:lms_flutter/theme.dart';

class ProgressBar extends StatefulWidget {
  int maxTime;
  double sizeWidth;
  String time;
  double valueTime;

  ProgressBar({Key key, this.maxTime, this.sizeWidth}) : super(key: key);

  @override
  Progress createState() => Progress();
}

class Progress extends State<ProgressBar> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.time = widget.maxTime.toString();
    widget.valueTime = 1.0;
    setTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }

  int setTime() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.time == "0") {
          print("끝");
        } else {
          widget.time = (--widget.maxTime).toString();
          widget.valueTime = widget.valueTime - 0.02;
        }
      });
    });
  }

  Widget body() {
    return Container(
      width: widget.sizeWidth,
      height: 50,
      padding: const EdgeInsets.only(left: 10.0),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              width: widget.sizeWidth,
              height: 30,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 216, 81),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: progressMain(),
              ),
            ), //맨위에 바
          ),

          Positioned(
            left: 0,
            child: Container(
              width: widget.sizeWidth - 225,
              height: 50,
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 255, 216, 81),
              ),
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 41, 167, 135),
                child: Center(
                  child: Text(widget.time),
                ),
              ),
            ),
          ), //앞에 숫자
        ],
      ),
    );
  }

  Widget progressMain() {
    return Row(
      children: <Widget>[
        SizedBox(
          height: 10,
          child: LinearProgressIndicator(
            value: widget.valueTime ,
            backgroundColor: Colors.transparent,
            valueColor:
                AlwaysStoppedAnimation(Color.fromARGB(255, 251, 105, 105)),
          ),
        ),
      ],
    );
  }
}
