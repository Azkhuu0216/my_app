// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:my_app/answer.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/question.dart';
import 'package:postgres/postgres.dart';

class User {
  // ignore: non_constant_identifier_names
  String? user_id;
  String? lastname;
  String? firstname;

  User(this.user_id, this.lastname, this.firstname);
}

var questions = [
  {
    "questionText": "How are you",
    'answer': ["1", "2", "3", "4", "5"],
  },
  {
    "questionText": "What is your name?",
    'answer': ["Azaa", "Bold", "Bat", "Dorj", "Tsetseg"],
  },
  {
    "questionText": "What is your favorite animal?",
    'answer': ["horse", "sheep", "camel", "goat", "yak"],
  },
];

class Quiz extends StatefulWidget {
  @override
  State<Quiz> createState() => _QuizState();

  // ignore: non_constant_identifier_names
}

class _QuizState extends State<Quiz> {
  var _questionIndex = 0;
  void questionAnswer() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
  }

  void initState() {
    Postgre();
    super.initState();
  }

  // List<User> Data = [];
  Future<void> Postgre() async {
    var connection = PostgreSQLConnection("192.168.43.235", 5433, "Chemistry",
        // ignore: non_constant_identifier_names
        username: "postgres",
        password: "azaa");
    try {
      await connection.open();
      print("connect");
    } catch (e) {
      print('error....');
      print(e.toString());
    }
    List<Map<String, Map<String, dynamic>>> results =
        await connection.mappedResultsQuery("SELECT  * FROM Question ");
    print(results);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: Text("Асуулт")),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Question(
              questions[_questionIndex]["questionText"].toString(),
            ),
            ...(questions[_questionIndex]["answer"] as List<String>)
                .map((answer) {
              return Answer(questionAnswer, answer);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
