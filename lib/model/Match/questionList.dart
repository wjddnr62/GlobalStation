class QuestionList {
  final int match_pk;
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final int coin;
  final String img;

  QuestionList(
  {this.match_pk,
  this.level,
  this.chapter,
  this.stage,
  this.question_num,
  this.coin,
  this.img}
      );

  factory QuestionList.fromJson(Map<String, dynamic> json){
    return QuestionList(
      match_pk: json['match_pk'],
      level: json['level'],
      chapter: json['chapter'],
      stage: json['stage'],
      question_num: json['question_num'],
      coin: json['coin'],
      img: json['img'],
    );
  }

}