// ignore_for_file: file_names, prefer_final_fields, duplicate_ignore, avoid_print, prefer_const_constructors, unnecessary_cast, unused_import, unused_field, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, unused_local_variable, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/common/answer.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/answer_model.dart';
import 'package:my_app/model/question_model.dart';
import 'package:my_app/provider/mainProvider.dart';
import 'package:my_app/common/question.dart';
import 'package:postgres/postgres.dart';
import 'package:provider/provider.dart';

class Quiz extends StatefulWidget {
  final String testId;

  @override
  State<Quiz> createState() => _QuizState();
  Quiz(this.testId);
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
    getData();
    super.initState();
  }

  CollectionReference _answers =
      FirebaseFirestore.instance.collection('answers');

  Future<void> getData() async {
    FirebaseFirestore.instance.collection("questions").get().then(
      (value) {
        value.docs.forEach((element) {
          element.get('test_id') == widget.testId &&
                  element.get('isApproved') == 'true' &&
                  element.get('qyear') != '1000'
              ? _questionListResult.add(
                  Question(
                    element.id,
                    element.get('question'),
                    element.get('qyear'),
                    element.get('qlevel'),
                    element.get('score'),
                    element.get('answer_type'),
                    element.get('correct_answer'),
                    element.get('isApproved'),
                    element.get('lesson_id'),
                    element.get('test_id'),
                    element.get('user_id'),
                    [],
                  ),
                )
              : null;
        });

        FirebaseFirestore.instance.collection("answers").get().then(
              (value) => {
                // print("Answer------" + value.docs.length.toString()),
                value.docs.forEach(
                  (element) {
                    // element.get("question_id") == cities;s
                    _anwerListResult.add(
                      AnswerModel(element.id, element.get('answer'),
                          element.get('question_id'), element.get('isCorrect')),
                    );
                  },
                ),

                _questionListResult.forEach((e) => {
                      print('Item----' + e.question_id.toString()),
                      answers = [],
                      _anwerListResult.forEach((el) => {
                            // print('subItem----' + el.question_id.toString()),
                            // print('AnswerElement----' + el.toString()),
                            if (e.question_id == el.question_id)
                              {answers.add(el)},
                          }),
                      e.answers.addAll(answers),
                    }),
                setState(() {
                  _questionList = _questionListResult;
                }),
              },
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MainProvider _mainProvider = Provider.of<MainProvider>(context);
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
                              .map((e) {
                            return Answer(
                                e.answer,
                                e.answer_id,
                                e.isCorrect,
                                e.isCorrect == '1' && _mainProvider.getIsClick()
                                    ? Colors.green
                                    : _mainProvider.getIsClick() &&
                                            e.isCorrect == '0' &&
                                            _mainProvider.getSelectAnswerId() ==
                                                e.answer_id
                                        ? Colors.red
                                        : Colors.blue.shade50);
                          }).toList(),
                          if (_mainProvider.getIsClick())
                            Column(
                              children: [
                                SizedBox(height: 40),
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  color: Colors.yellow.shade50,
                                  height: 120,
                                  width: 350,
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Text(_questionList[_questionIndex]
                                          .correct_answer
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
                        // ignore: prefer_const_constructors
                        Expanded(
                          flex: 0,
                          // ignore: prefer_const_constructors
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
