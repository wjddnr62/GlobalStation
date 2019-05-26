import 'package:flutter/material.dart';

import '../../../theme.dart';

class QuestionStatus extends StatefulWidget {
  int question_all_length;
  int question_count;
  double width;

  QuestionStatus(
      {Key key, this.question_all_length, this.question_count, this.width})
      : super(key: key);

  @override
  Status createState() => Status();
}

class Status extends State<QuestionStatus> {
  int question_all_length;
  int question_count;

  countSet() {
    question_all_length = widget.question_all_length;
    question_count = widget.question_count;
  }

  Widget StatusBar() {
//    print("Status test");
//    countSet();
    return Container(
      width: widget.width - 20,
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: ClipOval(
                  child: Container(
                    width: 20,
                    height: 20,
                    color: StatusBarLeftColor,
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: LinearProgressIndicator(
                  backgroundColor: StatusBarRightColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    StatusBarLeftColor,
                  ),
                  value: widget.question_count / widget.question_all_length,
                ),
              ),
              Flexible(
                child: ClipOval(
                  child: Container(
                    width: 20,
                    height: 20,
                    color: StatusBarRightColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    question_all_length = widget.question_all_length;
//    question_count = widget.question_count;
    return StatusBar();
  }
}
