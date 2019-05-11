import 'package:lms_flutter/provider/tbl_book_api.dart';
import '../provider/login_api.dart';
import '../provider/speed_provider.dart';
import '../provider/quiz_provider.dart';
import '../provider/match_provider.dart';

import 'package:http/http.dart' as http;

class Repository {
  final _loginProvider = LoginProvider();
  final _bookProvider = BookProvider();
  final _speedProvider = SpeedProvider();
  final _quizProvider = QuizProvider();
  final _matchProvider = MatchProvider();

  Future<String> fetchUser(http.Client client, String id, String pass) =>
      _loginProvider.fetchUser(client, id, pass);

  Future<String> fetchDetailUser(http.Client client, String userNo) =>
      _loginProvider.fetchDetailUser(client, userNo);

  Future<String> fetchGetBookList(http.Client client, String class_str) =>
      _bookProvider.fetchGetBookList(client, class_str);

  Future<String> getSpeedStageList(String level, int chapter) =>
      _speedProvider.getStageList(level, chapter);

  Future<String> getQuizStageList(String level, int chapter) =>
      _quizProvider.getStageList(level, chapter);

  Future<String> getMatchStageList(String level, int chapter) =>
      _matchProvider.getStageList(level, chapter);

}
