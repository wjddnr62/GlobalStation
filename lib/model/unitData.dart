import 'package:lms_flutter/model/unit.dart';

class unitData{
  static final unitData _unitData = new unitData._internal();

  factory unitData() {
    return _unitData;
  }

  unitData._internal();

  String _unit_level;
  String _unit_name;
  String _unit_sub_name;
  String _book_key;
  int _amount;
  List<Unit> _unitList;
  List<ProblemUnit> _problemunitList;

  List<ProblemUnit> get problemunitList => _problemunitList;

  set problemunitList(List<ProblemUnit> value) {
    _problemunitList = value;
  }

  List<Unit> get unitList => _unitList;

  set unitList(List<Unit> value) {
    _unitList = value;
  }

  String get unit_level => _unit_level;

  set unit_level(String value) {
    _unit_level = value;
  }

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
  }

  String get unit_name => _unit_name;

  set unit_name(String value) {
    _unit_name = value;
  }

  String get unit_sub_name => _unit_sub_name;

  String get book_key => _book_key;

  set book_key(String value) {
    _book_key = value;
  }

  set unit_sub_name(String value) {
    _unit_sub_name = value;
  }


}