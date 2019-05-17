class Answer {
  final String book_key;
  final String division_name;
  final int division_no;
  final String type_name;
  final String type_no;
  final int questino_no;
  final int detail_no;
  final String answer;
  final String sub_answer;

  Answer(
      this.book_key,
      this.division_name,
      this.division_no,
      this.type_name,
      this.type_no,
      this.questino_no,
      this.detail_no,
      this.answer,
      this.sub_answer
      );

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      json['book_key'],
      json['division_name'],
      json['division_no'],
      json['type_name'],
      json['type_no'],
      json['question_no'],
      json['detail_no'],
      json['answer'],
      json['sub_answer']
    );
  }
}