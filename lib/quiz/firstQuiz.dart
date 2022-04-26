// ignore_for_file: file_names, prefer_final_fields, duplicate_ignore, avoid_print
import 'package:flutter/material.dart';
import 'package:my_app/common/answer.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/answer_model.dart';
import 'package:my_app/model/question_model.dart';
import 'package:my_app/provider/mainProvider.dart';
import 'package:my_app/common/question.dart';
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
  final String examId;

  @override
  State<Quiz> createState() => _QuizState();
  Quiz(this.examId);
  // ignore: non_constant_identifier_names
}

// ignore: duplicate_ignore
class _QuizState extends State<Quiz> {
  var _questionIndex = 0;
  // ignore: prefer_final_fields
  List<Question> _questionListResult = [];
  List<Question> _questionList = [];
  List<AnswerModel> _anwerListResult = [];
  List<AnswerModel> answers = [];

  var _point = 0;
  var check = 0;
  var AllPoint = 0;

  void questionAnswer() {
    setState(() {
      _questionIndex = _questionIndex + 1;
      AllPoint = _questionIndex + _questionIndex;
    });
  }

  @override
  void initState() {
    Postgre();
    super.initState();
  }

  // List<Question> _listQuestion = [];
  // ignore: non_constant_identifier_names
  Future<void> Postgre() async {
    var connection = PostgreSQLConnection("192.168.43.235", 5433, "Chemistry",
        // ignore: non_constant_identifier_names
        username: "postgres",
        password: "azaa");
    try {
      await connection.open();
      // ignore: avoid_print
      // print("connect");
    } catch (e) {
      // ignore: avoid_print
      print('error....');
      print(e.toString());
    }
    String qIdList = "(";
    int index = 1;

    String query =
        "SELECT  * FROM Questions where exam_id = '" + widget.examId + "'";
    List<Map<String, Map<String, dynamic>>> results =
        await connection.mappedResultsQuery(query);

    // ignore: avoid_function_literals_in_foreach_calls
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
          // print(qIdList),
          index++,
          e.values.first.entries.elementAt(3).value == "intermediate" &&
                  e.values.first.entries.elementAt(2).value != "1000"
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
    // print("results" + results.toString());

    String queryAnswer =
        "SELECT  * FROM Answers where question_id in " + qIdList;
    List<Map<String, Map<String, dynamic>>> resultsAnswer =
        await connection.mappedResultsQuery(queryAnswer);
    // print("resultAnswer===" + resultsAnswer.toString());

    resultsAnswer.forEach((e) {
      // print('qID--' + e.values.first.entries.elementAt(2).value.toString());
      _anwerListResult.add(
        AnswerModel(
            e.values.first.entries.first.value.toString(),
            e.values.first.entries.elementAt(1).value,
            e.values.first.entries.elementAt(2).value.toString(),
            e.values.first.entries.elementAt(3).value),
      );
    });
    // ignore: avoid_function_literals_in_foreach_calls
    _questionListResult.forEach((item) => {
          // print('Item----' + item.question_id.toString()),
          answers = [],
          _anwerListResult.forEach((subItem) => {
                // print('subItem----' + subItem.question_id.toString()),
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
    // print('questionLength============' + _questionList.length.toString());
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Text("Асуулт"),
          backgroundColor: Colors.teal,
        ),
        body: _questionIndex < _questionList.length
            ? CustomScrollView(slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      index = 0;
                      return (Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          QuestionScreen(_questionList[_questionIndex]
                              .question
                              .toString()),
                          ...(_questionList[_questionIndex].answers
                                  as List<AnswerModel>)
                              .map((answer) {
                            return Answer(
                                answer.answer,
                                answer.answer_id,
                                answer.isCorrect,
                                answer.isCorrect == '1' &&
                                        _mainProvider.getIsClick()
                                    ? Colors.green
                                    : _mainProvider.getIsClick() &&
                                            answer.isCorrect == '0' &&
                                            _mainProvider.getSelectAnswerId() ==
                                                answer.answer_id
                                        ? Colors.red
                                        : Colors.blue.shade50);
                          }).toList(),
                          if (_mainProvider.getIsClick())
                            _mainProvider.getCheck() == 1
                                ? Column(
                                    children: [
                                      SizedBox(height: 40),
                                      Container(
                                        color: Colors.yellow.shade50,
                                        height: 80,
                                        width: 350,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20),
                                            Text(_questionList[_questionIndex]
                                                .correct_answers
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      SizedBox(height: 40),
                                      Container(
                                        color: Colors.yellow.shade50,
                                        height: 80,
                                        width: 350,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20),
                                            Text(_questionList[_questionIndex]
                                                .correct_answers
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                        ],
                      ));
                    },
                    childCount: 1,
                  ),
                ),
              ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 0,
                          child: Text(
                            "Баяр хүргэе!",
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 40,
                              fontFamily: "TimesNewRoman",
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Text(
                            "Таны авсан оноо",
                            style: TextStyle(
                              color: Colors.teal,
                              fontSize: 40,
                              fontFamily: "TimesNewRoman",
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _mainProvider.getPoint().toString(),
                                  style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 40,
                                    fontFamily: "TimesNewRoman",
                                  ),
                                ),
                                Text(
                                  '/',
                                  style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 40,
                                    fontFamily: "TimesNewRoman",
                                  ),
                                ),
                                Text(
                                  AllPoint.toString(),
                                  style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 40,
                                    fontFamily: "TimesNewRoman",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
        floatingActionButton: _questionIndex < _questionList.length
            ? AddButton(context, Icons.navigate_next, questionAnswer)
            : null,
      ),
    );
  }
}
