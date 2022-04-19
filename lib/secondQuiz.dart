// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:my_app/answer.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/answer_model.dart';
import 'package:my_app/model/exam_model.dart';
import 'package:my_app/model/question_model.dart';
import 'package:my_app/provider/mainProvider.dart';
import 'package:my_app/question.dart';
import 'package:postgres/postgres.dart';
import 'package:provider/provider.dart';

// class User {
//   // ignore: non_constant_identifier_names
//   String? user_id;
//   String? lastname;
//   String? firstname;

//   User(this.user_id, this.lastname, this.firstname);
// }

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

class SecondQuiz extends StatefulWidget {
  final String categoryId;

  @override
  State<SecondQuiz> createState() => _SecondQuizState();
  SecondQuiz(this.categoryId);
  // ignore: non_constant_identifier_names
}

class _SecondQuizState extends State<SecondQuiz> {
  var _questionIndex = 0;
  List<Question> _questionListResult = [];
  List<Question> _questionList = [];
  List<AnswerModel> _anwerListResult = [];
  List<AnswerModel> answers = [];
  var _point = 0;
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

  // List<Question> _listQuestion = [];
  Future<void> Postgre() async {
    var connection = PostgreSQLConnection("10.2.203.219", 5433, "Chemistry",
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
    String qIdList = "(";
    int index = 1;

    String query =
        "SELECT  * FROM Questions where cat_id = '" + widget.categoryId + "'";
    List<Map<String, Map<String, dynamic>>> results =
        await connection.mappedResultsQuery(query);

    results.forEach((e) => {
          if (index == results.length)
            {
              qIdList +=
                  "'" + e.values.first.entries.first.value.toString() + "')",
            }
          else
            {
              qIdList +=
                  "'" + e.values.first.entries.first.value.toString() + "',",
            },
          index++,
          e.values.first.entries.elementAt(4).value == "intermediate"
              ? _questionListResult.add(
                  (Question(
                      e.values.first.entries.first.value.toString(),
                      e.values.first.entries.elementAt(1).value,
                      e.values.first.entries.elementAt(2).value,
                      e.values.first.entries.elementAt(3).value,
                      e.values.first.entries.elementAt(4).value,
                      e.values.first.entries.elementAt(5).value,
                      e.values.first.entries.elementAt(6).value,
                      e.values.first.entries.elementAt(7).value.toString(),
                      e.values.first.entries.elementAt(8).value.toString(),
                      e.values.first.entries.elementAt(9).value.toString(),
                      [])),
                )
              : null,
        });
    print(results);

    String queryAnswer =
        "SELECT  * FROM Answers where question_id in " + qIdList;
    List<Map<String, Map<String, dynamic>>> resultsAnswer =
        await connection.mappedResultsQuery(queryAnswer);

    resultsAnswer.forEach((e) {
      _anwerListResult.add(AnswerModel(
          e.values.first.entries.first.value.toString(),
          e.values.first.entries.elementAt(1).value,
          e.values.first.entries.elementAt(2).value.toString(),
          e.values.first.entries.elementAt(3).value));
    });

    _questionListResult.forEach((item) => {
          answers = [],
          _anwerListResult.forEach((subItem) => {
                if (item.question_id == subItem.question_id)
                  {answers.add(subItem)},
              }),
          item.answers.addAll(answers),
        });
    setState(() {
      _questionList = _questionListResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    MainProvider _mainProvider = Provider.of<MainProvider>(context);
    print("exam id === ");
    print(widget.categoryId);

    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(title: Text("Асуулт")),
          body: _questionIndex < _questionList.length
              ? (Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    QuestionScreen(
                        _questionList[_questionIndex].question.toString()),
                    ...(_questionList[_questionIndex].answers
                            as List<AnswerModel>)
                        .map((answer) {
                      return Answer(
                          questionAnswer,
                          answer.answer,
                          answer.answer_id,
                          answer.isCorrect,
                          answer.isCorrect == '1' && _mainProvider.getIsClick()
                              ? Colors.green
                              : _mainProvider.getIsClick() &&
                                      answer.isCorrect == '0' &&
                                      _mainProvider.getSelectAnswerId() ==
                                          answer.answer_id
                                  ? Colors.red
                                  : Colors.blue.shade50);
                    }).toList(),
                  ],
                ))
              : Center(
                  child: Text('Asuult duussan'),
                )),
    );
  }
}
