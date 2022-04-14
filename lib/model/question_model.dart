import 'package:flutter/material.dart';

class Question {
  String? question_id;
  String? question;
  String? question_image;
  String? qyear;
  String? qlevel;
  String? score;
  int? answer_type;
  String? exam_id;
  Question(this.question_id, this.answer_type, this.exam_id, this.qlevel,
      this.question, this.question_image, this.qyear, this.score);
}
