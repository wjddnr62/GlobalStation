import 'package:http/http.dart' as http;
import 'dart:async';

class LoginProvider {
  final String url = "http://ga.oig.kr/laon_api_v2/api";
  http.Client client = http.Client();

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
    await client.get(url + '/auth/userData?user_no=' + userNo).catchError((error){
      return false;
    });

    return DetailUser(response.body);
  }

  String DetailUser(String responseBody) {
    return responseBody;
  }

  Future<String> updateCharacter(String id, int type,int hair,int eye,int skin, int hat) async {
    final response = await client.put(url + "/auth/character?" +
        "child_key=" + id +
        "&hair_type="+ type.toString() +
        "&hair_color="+ hair.toString() +
        "&eye_color="+ eye.toString() +
        "&skin_color="+ skin.toString()+
        "&hat="+ hat.toString()
    );

    return response.body;
  }
  
  Future<String> addCoin(String id, int coin) async {
    final response = await client.put(url + "/auth/addCoin?"+
    "child_key="+id +
    "&coin="+coin.toString());

    return response.body;
  }
}
