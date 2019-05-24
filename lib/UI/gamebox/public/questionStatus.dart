import 'package:flutter/material.dart';

import '../../../theme.dart';

class questionStatus extends StatefulWidget {
  int question_all_length;
  int question_count;
  double width;

  questionStatus(
      {Key key, this.question_all_length, this.question_count, this.width})
      : super(key: key);

  @override
  Status createState() => Status();
}

class Status extends State<questionStatus> {
  int question_all_length;
  int question_count;

  countSet() {
    question_all_length = widget.question_all_length;
    question_count = widget.question_count;
  }

  Widget StatusBar() {
    countSet();
    return Container(
      width: widget.width - 20,
      height: 100,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: StatusBarLeftColor,
              ),
            ),
            LinearProgressIndicator(
              backgroundColor: StatusBarRightColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                StatusBarLeftColor,
              ),
              value: question_count / question_all_length,
            ),
            ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: StatusBarRightColor,
              ),
            ),
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    question_all_length = widget.question_all_length;
    question_count = widget.question_count;
    return StatusBar();
  }
}
