import 'package:rxdart/rxdart.dart';
import 'package:lms_flutter/repository/Repository.dart';
import 'package:http/http.dart' as http;

class QuestionBloc{
  final _repository = Repository();

  final _book_key = BehaviorSubject<String>();
  final _type_no = BehaviorSubject<String>();
  final _type_name = BehaviorSubject<String>();
  final _public_no = BehaviorSubject<int>();

  Observable<String> get book_key => _book_key.stream;
  Observable<String> get type_no => _type_no.stream;
  Observable<String> get type_name => _type_name.stream;
  Observable<int> get public_no => _public_no.stream;

  Function(String) get changebook_key => _book_key.sink.add;
  Function(String) get changetype_no => _type_no.sink.add;
  Function(String) get changetype_name => _type_name.sink.add;
  Function(int) get changepublic_no => _public_no.sink.add;

  Future<String> getQuestion1List(){
    return _repository.fetchGetQuestion1List(http.Client(), _book_key.value, _type_no.value, _type_name.value);
  }

  Future<String> getQuestionPublic1List(){
    return _repository.fetchGetQuestionPublic1List(http.Client(), _public_no.value);
  }

  void dispose(){
    _book_key.close();
    _type_name.close();
    _type_no.close();
    _public_no.close();
  }
}

final question_bloc = QuestionBloc();