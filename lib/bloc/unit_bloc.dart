import 'package:rxdart/rxdart.dart';
import 'package:lms_flutter/repository/Repository.dart';
import 'package:http/http.dart' as http;

class UnitBloc{
  final _repository = Repository();

  final _book_key = BehaviorSubject<String>();

  Observable<String> get book_key => _book_key.stream;

  Function(String) get changebook_key => _book_key.sink.add;

  Future<String> getUnitList(){
    return _repository.fetchGetUnitList(http.Client(), _book_key.value);
  }

  Future<String> getProblemUnit1List(){
    return _repository.fetchGetProblemUnit1List(http.Client(), _book_key.value);
  }

  void dispose(){
    _book_key.close();
  }
}

final unit_bloc = UnitBloc();