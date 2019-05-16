import 'package:rxdart/rxdart.dart';
import 'package:lms_flutter/repository/Repository.dart';
import 'package:http/http.dart' as http;

class AnswerBloc{
  final _repository = Repository();

  final _book_key = BehaviorSubject<String>();
  final _type_no = BehaviorSubject<String>();
  final _type_name = BehaviorSubject<String>();

  Observable<String> get book_key => _book_key.stream;
  Observable<String> get type_no => _type_no.stream;
  Observable<String> get type_name => _type_name.stream;

  Function(String) get changebook_key => _book_key.sink.add;
  Function(String) get changetype_no => _type_no.sink.add;
  Function(String) get changetype_name => _type_name.sink.add;

  Future<String> getAnswerList(){
    return _repository.fetchGetAnswerList(http.Client(), _book_key.value, _type_no.value, _type_name.value);
  }

  void dispose(){
    _book_key.close();
    _type_no.close();
    _type_name.close();
  }
}

final answer_bloc = AnswerBloc();