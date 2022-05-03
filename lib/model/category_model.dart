class Category {
  final String category_id;
  final String category_name;
  final String description;

  Category(this.category_id, this.category_name, this.description);

  // Category.fromJson(Map<String, dynamic> json)
  //     : category_id = json['category_id'],
  //       category_name = json['category_name'],
  //       lesson_id = json['lesson_id'];
  // Map<String, dynamic> toJson() => {
  //       'category_id': category_id,
  //       'category_name': category_name,
  //       'lesson_id': lesson_id,
  //     };
}
