class Stage {
  final String level;
  final int chapter;
  final int stage;

  Stage({this.level, this.chapter, this.stage});

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      level: json['level'] as String,
      chapter: json['chapter'] as int,
      stage: json['stage'] as int,
    );
  }
}
