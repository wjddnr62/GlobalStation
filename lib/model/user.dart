class User {
  final String child_key;
  final String child_user_id;
  final String user_id; // 부모 아이디
  final String child_name; // 학생 이름

  User({this.child_key, this.child_user_id, this.user_id, this.child_name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      child_key: json['child_key'] as String,
      child_user_id: json['child_user_id'] as String,
      user_id: json['user_id'] as String,
      child_name: json['child_name'] as String,
    );
  }
}

class DetailUser {
  final String user_id;
  final String child_key;
  final String child_name;
  final int level;
  final int coin;
  final dynamic created_at;
  final dynamic updated_at;

  DetailUser(
      this.user_id,
      this.child_key,
      this.child_name,
      this.level,
      this.coin,
      this.created_at,
      this.updated_at);

  factory DetailUser.fromJson(Map<String, dynamic> json) {
    return DetailUser(
        json['user_id'],
        json['child_key'],
        json['child_name'],
        json['level'],
        json['coin'],
        json['created_at'],
        json['updated_at']);
  }
}
