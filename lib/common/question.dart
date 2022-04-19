import 'package:flutter/material.dart';
import 'package:my_app/model/question_model.dart';

class QuestionScreen extends StatelessWidget {
  final String questionText;

  QuestionScreen(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: Text(questionText,
          style: TextStyle(fontSize: 28), textAlign: TextAlign.center),
    );
  }
}
