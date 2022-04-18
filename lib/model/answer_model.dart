import 'package:flutter/material.dart';

class AnswerModel {
  final int answer_id;
  final String answer;
  final int question_id;
  final String isCorrect;
  AnswerModel(this.answer_id, this.answer, this.question_id, this.isCorrect);
}
