class Unit {
  final String book_key;
  final dynamic book_page;
  final String name;
  final int num;
  final int division_no;
  final String division_name;
  final String type_no;
  final String type_name;
  final String music;
  final int answer_check;

  Unit(
      this.book_key,
      this.book_page,
      this.name,
      this.num,
      this.division_no,
      this.division_name,
      this.type_no,
      this.type_name,
      this.music,
      this.answer_check
      );

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      json['book_key'],
      json['book_page'],
      json['name'],
      json['num'],
      json['division_no'],
      json['division_name'],
      json['type_no'],
      json['type_name'],
      json['music'],
      json['answer_check']
    );
  }

}

class ProblemUnit {
  final String book_key;
  final String division_name;
  final int division_no;
  final String type_name;
  final String type_no;
  final int question_no;
  final int public_no;

  ProblemUnit(
      this.book_key,
      this.division_name,
      this.division_no,
      this.type_name,
      this.type_no,
      this.question_no,
      this.public_no
      );

  factory ProblemUnit.fromJson(Map<String, dynamic> json) {
    return ProblemUnit(
      json['book_key'],
      json['division_name'],
      json['division_no'],
      json['type_name'],
      json['type_no'],
      json['question_no'],
      json['public_no']
    );
  }
}