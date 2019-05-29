import 'package:http/http.dart' as http;
import 'package:lms_flutter/provider/character_provider.dart';
import 'package:lms_flutter/provider/tbl_book_api.dart';
import '../provider/login_api.dart';
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
  final _speedProvider = SpeedProvider();
  final _quizProvider = QuizProvider();
  final _matchProvider = MatchProvider();
  final _characterProvider = CharacterProvider();

  Future<String> fetchUser(http.Client client, String id, String pass) =>
      _loginProvider.fetchUser(client, id, pass);

  Future<String> updateCharacter(String id, int type,int hair,int eye,int skin, int hat) =>
      _loginProvider.updateCharacter(id, type, hair, eye, skin, hat);

  Future<String> addCoin(String id, int coin) =>
      _loginProvider.addCoin(id, coin);

  Future<String> fetchDetailUser(http.Client client, String userNo) =>
      _loginProvider.fetchDetailUser(client, userNo);

  Future<String> fetchGetBookList(http.Client client, String class_str) =>
      _bookProvider.fetchGetBookList(client, class_str);

  Future<String> fetchGetUnitList(http.Client client, String book_key) =>
      _unitProvider.fetchGetUnitList(client, book_key);

  Future<String> fetchGetProblemUnit1List(http.Client client,
      String book_key) =>
      _problemunitProvider.fetchGetProblemUnit1List(client, book_key);

  Future<String> fetchGetQuestion1List(http.Client client, String book_key,
      String type_no, String type_name) =>
      _questionProvider.fetchGetQuestion1List(
          client, book_key, type_no, type_name);

  Future<String> fetchGetQuestionPublic1List(http.Client client,
      int public_no) =>
      _questionpublicProvider.fetchGetQuestionPublic1List(client, public_no);

  Future<String> fetchGetAnswerList(http.Client client, String book_key,
      String type_no, String type_name) =>
      _answerProvider.fetchGetAnswerList(client, book_key, type_no, type_name);

  Future<String> getSpeedStageList(String level, int chapter) =>
      _speedProvider.getStageList(level, chapter);

  Future<String> getQuizStageList(String level, int chapter) =>
      _quizProvider.getStageList(level, chapter);

  Future<String> getMatchStageList(String level, int chapter) =>
      _matchProvider.getStageList(level, chapter);

  Future<String> getMatchQuestList(String level, int chapter, int stage) =>
      _matchProvider.getQuestList(level, chapter, stage);

  Future<String> getMatchAnswerList(
          String level, int chapter, int stage, int question_num) =>
      _matchProvider.getAnswerList(level, chapter, stage, question_num);

  Future<String> getSpeedQuestList(String level, int chapter, int stage) =>
      _speedProvider.getQuestList(level, chapter, stage);

  Future<String> getSpeedAnswerList(String level, int chapter, int stage,
      int question_num) =>
      _speedProvider.getAnswerList(level, chapter, stage, question_num);

  Future<String> getSpeedAnswerO(String level, int chapter, int stage,
      int question_num, int answer) =>
      _speedProvider.getAnswerO(level, chapter, stage, question_num, answer);

  Future<String> getSpeedAnswerA(String level, int chapter, int stage,
      int question_num, String answer) =>
      _speedProvider.getAnswerA(level, chapter, stage, question_num, answer);

  Future<String> getQuizQuestList(String level, int chapter, int stage) =>
      _quizProvider.getQuestList(level, chapter, stage);

  Future<String> getQuizAnswerList(String level, int chapter, int stage,
      int question_num) =>
      _quizProvider.getAnswerList(level, chapter, stage, question_num);

  Future<String> getQuizAnwer(String level, int chapter, int stage,
      int question_num, int answer_num) =>
      _quizProvider.getCheckAnswer(level, chapter, stage, question_num, answer_num);

  Future<String> getCharacter() =>
      _characterProvider.getCharacterInfo();
}
