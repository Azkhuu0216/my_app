import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import 'answer_model.dart';

class Question {
  final int question_id;
  final String question;
  final List question_image;
  final String qyear;
  final String qlevel;
  final String score;
  final int answer_type;
  final int cat_id;
  final int exam_id;
  final String user_id;
  final List<AnswerModel> answers;
  Question(
      this.question_id,
      this.question,
      this.question_image,
      this.qyear,
      this.qlevel,
      this.score,
      this.answer_type,
      this.cat_id,
      this.exam_id,
      this.user_id,
      this.answers);
}
