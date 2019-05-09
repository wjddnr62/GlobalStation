import 'package:rxdart/rxdart.dart';
import 'package:lms_flutter/repository/Repository.dart';
import 'package:http/http.dart' as http;

class LoginBloc{
  final _repository = Repository();
  final bloc = LoginBloc();

  final _id = BehaviorSubject<String>();
  final _pw = BehaviorSubject<String>();

  Observable<String> get id => _id.stream;

  Function(String) get changeId => _id.sink.add;

  Function(String) get changePw => _pw.sink.add;

  Future<String> submit(){
    return _repository.fetchUser(http.Client(), _id.value, _pw.value);
  }


}


