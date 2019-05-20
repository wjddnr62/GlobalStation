class QuestionList {
  final int quiz_pk;
  final String title;
  final String type;
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final int coin;
  final String img;

  QuestionList(
      {this.quiz_pk,
      this.title,
      this.type,
      this.level,
      this.chapter,
      this.stage,
      this.question_num,
      this.coin,
      this.img});

  factory QuestionList.fromJson(Map<String, dynamic> json){
    return QuestionList(
      quiz_pk: json['quiz_pk'],
      title: json['title'],
      type: json['type'],
      level: json['level'],
      chapter: json['chapter'],
      stage: json['stage'],
      question_num: json['question_num'],
      coin: json['coin'],
      img: json['img'],
    );
  }
}
