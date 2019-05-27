import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class CharacterProvider{
  final String defaultUrl = "http://ga.oig.kr/laon_api/api/";

  http.Client client = http.Client();

  Future<String> getCharacterInfo() async {
    final response = await client.get(defaultUrl);
    return response.body;
  }
}