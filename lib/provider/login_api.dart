import 'package:http/http.dart' as http;
import 'dart:async';

class LoginProvider {
  final String url = "http://ga.oig.kr/laon_api_v2/api";

  Future<String> fetchUser(http.Client client, String id, String pass) async {
    final response =
    await client.post(url + '/auth/login', body: {"id": id, "pass": pass});

    return userList(response.body);
  }

  String userList(String responseBody) {
    return responseBody;
  }


  Future<String> fetchDetailUser(http.Client client, String userNo) async {
    final response =
    await client.get(url + '/auth/userData?user_no=' + userNo);

    return DetailUser(response.body);
  }

  String DetailUser(String responseBody) {
    return responseBody;
  }
}
