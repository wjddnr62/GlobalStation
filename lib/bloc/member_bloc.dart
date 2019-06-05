import 'package:http/http.dart' as http;
import 'package:lms_flutter/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class MemberBloc {
  final _repository = Repository();

  final _userno = BehaviorSubject<String>();

  Observable<String> get userno => _userno.stream;

  Function(String) get changeuserno => _userno.sink.add;

  Future<String> getMember() {
    return _repository.fetchDetailUser(http.Client(), _userno.value);
  }

  Future<String> updateCharacter(
      String id, int type, int hair, int eye, int skin, int hat) {
    return _repository.updateCharacter(id, type, hair, eye, skin, hat);
  }

  Future<String> addCoin(String id, int coin, String type, int chapter, String level) => _repository.addCoin(id, coin, type, level, chapter);

  void dispose() {
    _userno.close();
  }
}

final mbloc = MemberBloc();
