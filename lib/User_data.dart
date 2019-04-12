import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class User_data {
  static final User_data _user_data = new User_data._internal();

  factory User_data() {
    return _user_data;
  }

  User_data._internal();
}