class AnswerList {
  final int answer_pk;
  final String ko;
  final String en;
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final String img;

  AnswerList(
      {this.answer_pk,
      this.ko,
      this.en,
      this.level,
      this.chapter,
      this.stage,
      this.question_num,
      this.img});

  factory AnswerList.fromJson(Map<String, dynamic> json) {
    return AnswerList(
      answer_pk: json['answer_pk'],
      ko: json['ko'],
      en: json['en'],
      level: json['level'],
      chapter: json['chapter'],
      stage: json['stage'],
      question_num: json['question_num'],
      img: json['img'],
    );
  }
}
