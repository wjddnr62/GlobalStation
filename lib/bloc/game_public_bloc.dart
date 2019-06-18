import 'package:rxdart/rxdart.dart';
import 'package:lms_flutter/repository/Repository.dart';
import '../model/stage.dart';
import 'dart:convert';

class GamePublicBloc {
  final _repository = Repository();

  final _level = BehaviorSubject<String>();
  final _chapter = BehaviorSubject<int>();
  final _getStage = BehaviorSubject<bool>();

  Observable<String> get level => _level.stream;

  Observable<int> get chapter => _chapter.stream;

  Observable<bool> get stage => _getStage.stream;

  Function(bool) get changeStage => _getStage.sink.add;

  Function(String) get changeLevel => _level.sink.add;

  Function(int) get changeChapter => _chapter.sink.add;

  String _response;
  int _idx;
  bool _singStatus;
  bool _Gameing = false;

  bool get Gameing => _Gameing;

  set Gameing(bool value) {
    _Gameing = value;
  }

  bool get singStatus => _singStatus;

  set singStatus(bool value) {
    _singStatus = value;
  }

  set response(String value) {
    _response = value;
  }

  String get response => _response;


  int get idx => _idx;

  set idx(int value) {
    _idx = value;
  }

  Future<String> getStageList(String gameType) {
    if(gameType == "S")
      return _repository.getSpeedStageList(_level.value, _chapter.value);
    if(gameType == "Q")
      return _repository.getQuizStageList(_level.value, _chapter.value);
    if(gameType == "M")
      return _repository.getMatchStageList(_level.value, _chapter.value);
  }

  List<Stage> jsonToList(String value) {
    List<Stage> stages = json
        .decode(value)['data']
        .map<Stage>((json) => Stage.fromJson(json))
        .toList();
    return stages;
  }

  void dispose() {
    _level.close();
    _chapter.close();
    _getStage.close();
  }
}

final gameBloc = GamePublicBloc();
