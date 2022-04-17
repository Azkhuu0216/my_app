import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

import 'answer_model.dart';

class Question {
  final String question_id;
  final String question;
  final List question_image;
  final String qyear;
  final String qlevel;
  final String score;
  final int answer_type;
  final String exam_id;
  final List<AnswerModel> answers;
  Question(this.question_id, this.question, this.question_image, this.qyear,
      this.qlevel, this.score, this.answer_type, this.exam_id, this.answers);
}

// List<Question> _listQuestion = [];
// void initState() {
//   Postgre();
// }

// Future<void> Postgre() async {
//   var connection = PostgreSQLConnection("10.10.201.6", 5433, "Chemistry",
//       // ignore: non_constant_identifier_names
//       username: "postgres",
//       password: "azaa");
//   try {
//     await connection.open();
//     print("connect");
//   } catch (e) {
//     print('error....');
//     print(e.toString());
//   }

//   List<Map<String, Map<String, dynamic>>> results =
//       await connection.mappedResultsQuery("SELECT  * FROM Question ");

//   // _listQuestion = results.forEach((element) => {element.values.first});
//   print(results);
//   results.forEach((element) {
//     _listQuestion.add(Question(
//         element.values.first.entries.first.value,
//         element.values.first.entries.elementAt(1).value,
//         element.values.first.entries.elementAt(2).value,
//         element.values.first.entries.elementAt(3).value,
//         element.values.first.entries.elementAt(4).value,
//         element.values.first.entries.elementAt(5).value,
//         element.values.first.entries.elementAt(6).value,
//         element.values.first.entries.elementAt(7).value));
//     // print(element.values.first.entries.elementAt(1).value);x
//     // print(element.values.first.entries.first.value);
//     // print(element.values.first);
//   });
// }
