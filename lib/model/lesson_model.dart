class Lesson {
  final String lesson_id;
  final String lessonName;

  Lesson(this.lesson_id, this.lessonName);

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
