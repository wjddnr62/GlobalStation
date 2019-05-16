import 'package:lms_flutter/provider/tbl_book_api.dart';
import 'package:lms_flutter/provider/tbl_problem_answer_api.dart';
import 'package:lms_flutter/provider/tbl_problem_question_public_unit_api.dart';
import 'package:lms_flutter/provider/tbl_problem_question_unit_api.dart';
import 'package:lms_flutter/provider/tbl_problem_unit_api.dart';
import 'package:lms_flutter/provider/tbl_unit_api.dart';

import '../provider/login_api.dart';
import '../provider/speed_provider.dart';
import '../provider/quiz_provider.dart';
import '../provider/match_provider.dart';

import 'package:http/http.dart' as http;

class Repository {
  final _loginProvider = LoginProvider();
  final _bookProvider = BookProvider();
  final _unitProvider = UnitProvider();
  final _problemunitProvider = ProblemUnitProvider();
  final _questionProvider = QuestionProvider();
  final _questionpublicProvider = QuestionPublicProvider();
  final _answerProvider = AnswerProvider();

  Future<String> fetchUser(http.Client client, String id, String pass) =>
      _loginProvider.fetchUser(client, id, pass);

  Future<String> fetchDetailUser(http.Client client, String userNo) =>
      _loginProvider.fetchDetailUser(client, userNo);

  Future<String> fetchGetBookList(http.Client client, String class_str) =>
      _bookProvider.fetchGetBookList(client, class_str);

  Future<String> fetchGetUnitList(http.Client client, String book_key) =>
      _unitProvider.fetchGetUnitList(client, book_key);

  Future<String> fetchGetProblemUnit1List(http.Client client, String book_key) =>
      _problemunitProvider.fetchGetProblemUnit1List(client, book_key);

  Future<String> fetchGetQuestion1List(http.Client client, String book_key, String type_no, String type_name) =>
      _questionProvider.fetchGetQuestion1List(client, book_key, type_no, type_name);



  Future<String> fetchGetQuestionPublic1List(http.Client client, int public_no) =>
      _questionpublicProvider.fetchGetQuestionPublic1List(client, public_no);

  Future<String> fetchGetAnswerList(http.Client client, String book_key, String type_no, String type_name) =>
      _answerProvider.fetchGetAnswerList(client, book_key, type_no, type_name);
}
