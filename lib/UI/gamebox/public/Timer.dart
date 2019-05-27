import 'dart:async';

import 'package:flutter/material.dart';

import '../../../theme.dart';

class TimerBar extends StatefulWidget {
  double width;
  VoidCallback finishTimer;

  TimerBar({Key key, this.width, this.finishTimer}) : super(key: key);

  @override
  TimerSet createState() => TimerSet();
}

class TimerSet extends State<TimerBar> {
  Timer _timer;
  int _defaultSet = 30;
  int timerSet = 30;

  setTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timer.isActive) {
        setState(() {
          if (_defaultSet == 1) {
            _timer.cancel();
            print("timered2 : " + _timer.isActive.toString());
            if (!_timer.isActive) {
              widget.finishTimer();
              _defaultSet = 30;
              timerSet = 30;
            }
            _defaultSet = 30;
            print("타이머완료");
//            if(!_timer.isActive) {
//              setTimer();
//            }
          } else {
            _defaultSet -= 1;
          }
        });
      }
    });
  }


  @override
  void didUpdateWidget(TimerBar oldWidget) {
    print("oldTimer");
  }

  @override
  void initState() {
    super.initState();
    if (_timer != null) {
      _timer.cancel();
    }

    setTimer();
  }

  @override
  void dispose() {
    print("timerdispose");
    _timer.cancel();
    print("timered : " + _timer.isActive.toString());
    super.dispose();
  }

  Widget timerBar() {
    return Container(
      width: widget.width - 20,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: ClipOval(
                  child: Container(
                    width: 40,
                    height: 40,
                    color: BackTimerColor,
                    child: Center(
                      child: ClipOval(
                        child: Container(
                          width: 30,
                          height: 30,
                          color: CircleTimerColor,
                          child: Center(
                              child: Text(
                            _defaultSet.toString(),
                            style: TextStyle(
                                color: white, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Container(
                    width: widget.width - 20,
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: BackTimerColor,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                        ),
                        child: Container(
                          height: 15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.transparent)),
                          child: PhysicalModel(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                            clipBehavior: Clip.antiAlias,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.transparent,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                animationTimerColor,
                              ),
                              value: _defaultSet / timerSet,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return timerBar();
  }
}

//class ProgressAnimation extends StatefulWidget {
//
//  @override
//  _ProgressAnimation createState() => _ProgressAnimation();
//}
//
//class _ProgressAnimation extends State<ProgressAnimation> with SingleTickerProviderStateMixin {
//
//  AnimationController controller;
//  Animation<double> animation;
//  double timerSet = 30.0;
//
//  @override
//  void initState() {
//    super.initState();
//    controller = AnimationController(
//      duration: const Duration(seconds: 30,), vsync: this);
//    animation = Tween(begin: 0.0, end: 30.0).animate(controller)..addListener(() {
//      setState(() {
////        defaultSet--;
////        print("ani");
//      });
//    });
//    controller.reverse();
//  }
//
//
//  @override
//  void dispose() {
//    controller.stop();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return LinearProgressIndicator(value: animation.value,);
//  }
//
//}
