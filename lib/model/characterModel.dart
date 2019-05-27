class CharacterModel{
  final int hairType;
  final int hairColor;
  final int eyeColor;
  final int skinColor;
  final int hat;

  CharacterModel({this.hairType, this.hairColor, this.skinColor,this.eyeColor,this.hat});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      hairType: json['haitType'] as int,
      hairColor: json['hairColor'] as int,
      eyeColor: json['eyeColor'] as int,
      skinColor: json['skinColor'] as int,
      hat: json['hat'] as int,
    );
  }

}