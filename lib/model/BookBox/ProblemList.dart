import 'package:lms_flutter/model/BookBox/question.dart';

class ProblemList {
  static final ProblemList _problemList = new ProblemList._internal();

  factory ProblemList() {
    return _problemList;
  }

  ProblemList._internal();

  List<Question> _questionList;

  List<Question> get questionList => _questionList;

  set questionList(List<Question> value) {
    _questionList = value;
  }
}