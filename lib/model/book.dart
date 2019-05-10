class Book {
  final String book_key;
  final String class_str;
  final String unit_name;
  final String sub_name;
  final String unit_order;
  final int amount;

  Book(
      this.book_key,
      this.class_str,
      this.unit_name,
      this.sub_name,
      this.unit_order,
      this.amount);

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      json['book_key'],
      json['class_str'],
      json['unit_name'],
      json['sub_name'],
      json['unit_order'],
      json['amount']);
  }
}