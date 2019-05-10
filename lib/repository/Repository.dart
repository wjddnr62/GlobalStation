import 'package:lms_flutter/provider/tbl_book_api.dart';

import '../provider/login_api.dart';
import 'package:http/http.dart' as http;

class Repository {
  final _loginProvider = LoginProvider();
  final _bookProvider = BookProvider();

  Future<String> fetchUser(http.Client client, String id, String pass) =>
      _loginProvider.fetchUser(client, id, pass);

  Future<String> fetchDetailUser(http.Client client, String userNo) =>
      _loginProvider.fetchDetailUser(client, userNo);

  Future<String> fetchGetBookList(http.Client client, String class_str) =>
      _bookProvider.fetchGetBookList(client, class_str);
}
