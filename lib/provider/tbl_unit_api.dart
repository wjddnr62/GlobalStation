import 'dart:async';

import 'package:http/http.dart' as http;

class UnitProvider {
  final String url = "http://isgec.oig.kr:8080/api/unit/getUnitlist";

  Future<String> fetchGetUnitList(http.Client client, String book_key) async {
    final response = await client.get(url + "?book_key=" + book_key);

    return response.body;
  }
}