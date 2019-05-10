import 'package:rxdart/rxdart.dart';
import 'package:lms_flutter/repository/Repository.dart';
import 'package:http/http.dart' as http;

class MemberBloc{
  final _repository = Repository();

  final _userno = BehaviorSubject<String>();

  Observable<String> get userno => _userno.stream;

  Function(String) get changeuserno => _userno.sink.add;

  Future<String> getMember(){
    return _repository.fetchDetailUser(http.Client(), _userno.value);
  }

  void dispose(){
    _userno.close();
  }
}

final bloc = MemberBloc();