import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lms_flutter/main.dart';

//String id, String pass
class Api_Call {
//PostData() {
//    FutureBuilder<List<User>>(
//      future: fetchUser(http.Client()),
//      builder: (context, snapshot) {
//        if (snapshot.hasData) {
//          print("hasData");
//          for (int i = 0; i < snapshot.data.length; i++) {
//            print(snapshot.data[i].child_name);
//          }
//        } else if (snapshot.hasError) {
//          print("${snapshot.error}");
//        } else {
//          print("???");
//        }
//      },
//    );
//  }


  Future<String> fetchUser(
      http.Client client, String id, String pass) async {
    final response = await client.post(
        'http://ga.oig.kr/laon_api_v2/api/auth/login',
        body: {"id": id, "pass": pass});

    print(response.body);

      return userList(response.body);

  }

  String userList(String responseBody) {
    //여따가 contains
    print(3131232132131);
    print(json.decode(responseBody)['result']);
//    if (responseBody.toString().contains("resultCode")) {
//      print(5151151);
//      final parsed = json.decode(responseBody)['resultCode'].toString();
////      final parsed = json.decode(responseBody)['resultCode'];
//      print(101010);
//      return parsed.map<User>((json) => Error.fromJson(parsed);
//    } else

    return responseBody;

     if (json.decode(responseBody)['result'] == 0) {
       print(212112231123);
       final parsed = json.decode(responseBody)['resultCode'];
       return Error.fromJson(parsed).toString();
     } else if (json.decode(responseBody)['result'] == 1) {
         print(62626262);
         final parsed = json.decode(responseBody)['data'].cast<Map<dynamic, dynamic>>();
          print(88888);
         return parsed.map<User>((json) => User.fromJson(json)).toList();

     }


  }
//
//  List<Error> errorList(dynamic responseBody) {
//    final parsed =
//        json.decode(responseBody)['resultCode'].cast<Map<String, dynamic>>();
//    return parsed.map<User>((json) => Error.fromJson(json)).toList();
//  }
}

class Error {
  final String errorCode;

  var errCode = {
  "api.error.invalid_property":"INVALID_PROPERTY",
  "api.error.user_not_found":"USER_NOT_FOUND",
  "api.error.password_invalid":"PASSWORD_INVALID",
  "api.error.unknown":"UNKNOWN",
  "api.error.method_not_allowed":"METHOD_NOT_ALLOWED",
  "api.error.client_abort":"CLIENT_ABORT",
  "api.error.already_exists_id":"ALREADY_EXISTS_ID",
  "api.error.referer_does_not_match":"REFERER_DOES_NOT_MATCH",
  "api.error.image_not_found":"IMAGE_NOT_FOUND",
  "api.error.stage_not_exists":"STAGE_NOT_EXISTS",
};

  Error({this.errorCode});

  factory Error.fromJson(String json) {
    print(131313);
    print(json);
    return Error(
      errorCode: json
    );
  }
}

class User {
  final String child_key;
  final String child_user_id;
  final String user_id; // 부모 아이디
  final String child_name; // 학생 이름

  User({this.child_key, this.child_user_id, this.user_id, this.child_name});

  factory User.fromJson(Map<String, dynamic> json) {
    print(7181818);
    return User(
      child_key: json['child_key'] as String,
      child_user_id: json['child_user_id'] as String,
      user_id: json['user_id'] as String,
      child_name: json['child_name'] as String,
    );
  }
}

class Data {
  final int result;
  final String data;

  Data({this.result, this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      result: json['result'] as int,
      data: json['data'] as String,
    );
  }
}

