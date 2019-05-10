import 'package:rxdart/rxdart.dart';
import 'package:lms_flutter/repository/Repository.dart';
import 'package:http/http.dart' as http;

class LoginBloc{
  final _repository = Repository();

  final _id = BehaviorSubject<String>();
  final _pw = BehaviorSubject<String>();

  Observable<String> get id => _id.stream;
  Observable<String> get pw => _pw.stream;

  Function(String) get changeId => _id.sink.add;

  Function(String) get changePw => _pw.sink.add;

  Future<String> submit(){
    return _repository.fetchUser(http.Client(), _id.value, _pw.value);
  }

  void dispose(){
    _id.close();
    _pw.close();
  }
}

final bloc = LoginBloc();


