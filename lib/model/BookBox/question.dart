class Question {
  final String book_key;
  final String division_name;
  final int division_no;
  final String type_name;
  final String type_no;
  final int question_no;
  final String question_sub;
  final int detail_no;
  final String question;
  final String img;
  final String ani_img;
  final int quiz_status;

  Question(
      this.book_key,
      this.division_name,
      this.division_no,
      this.type_name,
      this.type_no,
      this.question_no,
      this.question_sub,
      this.detail_no,
      this.question,
      this.img,
      this.ani_img,
      this.quiz_status
      );

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      json['book_key'],
      json['division_name'],
      json['division_no'],
      json['type_name'],
      json['type_no'],
      json['question_no'],
      json['question_sub'],
      json['detail_no'],
      json['question'],
      json['img'],
      json['ani_img'],
      json['quiz_status']
    );
  }
}

class QuestionPublic {
  final int public_no;
  final int detail_no;
  final String question;
  final String question_img;
  final String question_sub;

  QuestionPublic(
      this.public_no,
      this.detail_no,
      this.question,
      this.question_img,
      this.question_sub
      );

  factory QuestionPublic.fromJson(Map<String, dynamic> json) {
    return QuestionPublic(
      json['public_no'],
      json['detail_no'],
      json['question'],
      json['question_img'],
      json['question_sub']
    );
  }
}