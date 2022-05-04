import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import 'answer_model.dart';

class Question {
  final String question_id;
  final String question;
  final String qyear;
  final String qlevel;
  final String score;
  final String answer_type;
  final String correct_answer;
  final String isApproved;
  final String lesson_id;
  final String test_id;
  final String user_id;
  final List<AnswerModel> answers;
  Question(
      this.question_id,
      this.question,
      this.qyear,
      this.qlevel,
      this.score,
      this.answer_type,
      this.correct_answer,
      this.isApproved,
      this.lesson_id,
      this.test_id,
      this.user_id,
      this.answers);
}
