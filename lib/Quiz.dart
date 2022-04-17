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

class Quiz extends StatefulWidget {
  final String _examId;

  @override
  State<Quiz> createState() => _QuizState();
  Quiz(this._examId);
  // ignore: non_constant_identifier_names
}

class _QuizState extends State<Quiz> {
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
    String qIdList = "(";
    int index = 1;
    String query =
        "SELECT  * FROM Question where exam_id = '" + widget._examId + "'";
    List<Map<String, Map<String, dynamic>>> results =
        await connection.mappedResultsQuery(query);

    results.forEach((e) => {
          if (index == results.length)
            {
              qIdList += "'" + e.values.first.entries.first.value + "')",
            }
          else
            {
              qIdList += "'" + e.values.first.entries.first.value + "',",
            },
          index++,
          _questionListResult.add(
            (Question(
                e.values.first.entries.first.value,
                e.values.first.entries.elementAt(1).value,
                e.values.first.entries.elementAt(2).value,
                e.values.first.entries.elementAt(3).value,
                e.values.first.entries.elementAt(4).value,
                e.values.first.entries.elementAt(5).value,
                e.values.first.entries.elementAt(6).value,
                e.values.first.entries.elementAt(7).value, [])),
          ),
        });

    String queryAnswer =
        "SELECT  * FROM Answer where question_id in " + qIdList;
    List<Map<String, Map<String, dynamic>>> resultsAnswer =
        await connection.mappedResultsQuery(queryAnswer);

    resultsAnswer.forEach((e) {
      _anwerListResult.add(AnswerModel(
          e.values.first.entries.first.value,
          e.values.first.entries.elementAt(1).value,
          e.values.first.entries.elementAt(2).value,
          e.values.first.entries.elementAt(3).value));
    });

    _questionListResult.forEach((item) => {
          answers = [],
          _anwerListResult.forEach((subItem) => {
                if (item.question_id == subItem.question_id)
                  {answers.add(subItem)}
              }),
          item.answers.addAll(answers),
        });
    setState(() {
      _questionList = _questionListResult;
    });
    print("results");
    print(_questionListResult);
  }

  @override
  Widget build(BuildContext context) {
    MainProvider _mainProvider = Provider.of<MainProvider>(context);
    print("exam id === ");
    print(widget._examId);

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
