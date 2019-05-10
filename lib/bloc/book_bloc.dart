import 'package:rxdart/rxdart.dart';
import 'package:lms_flutter/repository/Repository.dart';
import 'package:http/http.dart' as http;

class BookBloc{
  final _repository = Repository();

  final _class_str = BehaviorSubject<String>();

  Observable<String> get class_str => _class_str.stream;

  Function(String) get changeclass_str => _class_str.sink.add;

  Future<String> getBookList(){
    return _repository.fetchGetBookList(http.Client(), _class_str.value);
  }

  void dispose(){
    _class_str.close();
  }
}

final bloc = BookBloc();