

class QuestionList {
  final int speed_pk;
  final String title;
  final String contents;
  final String type;
  final String level;
  final int chapter;
  final int stage;
  final int question_num;
  final int coin;
  final String img;

  QuestionList(
      {this.speed_pk,
      this.title,
      this.contents,
      this.type,
      this.level,
      this.chapter,
      this.stage,
      this.question_num,
      this.coin,
      this.img});

  factory QuestionList.fromJson(Map<String, dynamic> json){
    return QuestionList(
      speed_pk: json['speed_pk'],
      title: json['title'],
      contents: json['contents'],
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
