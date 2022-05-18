// ignore_for_file: file_names, prefer_final_fields, duplicate_ignore, avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/common/answer.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/answer_model.dart';
import 'package:my_app/model/question_model.dart';
import 'package:my_app/provider/mainProvider.dart';
import 'package:my_app/common/question.dart';
import 'package:provider/provider.dart';

class SecondQuiz extends StatefulWidget {
  final String lessonId;

  @override
  State<SecondQuiz> createState() => _SecondQuizState();
  SecondQuiz(this.lessonId);
  // ignore: non_constant_identifier_names
}

// ignore: duplicate_ignore
class _SecondQuizState extends State<SecondQuiz> {
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
    List qIdList = [];
    int index = 1;
    FirebaseFirestore.instance.collection("questions").get().then(
      (value) {
        // print('FirsStore result ------' + value.docs.length.toString());
        // print('FirsStore Docs ------' + value.docs.toString());

        value.docs.forEach((element) {
          if (index == value.docs.length) {
            // qIdList += "'" + element.id.toString() + "']";
            qIdList.add("'" + element.id.toString() + "'");
          } else {
            // qIdList += "'" + element.id.toString() + "',";
            qIdList.add("'" + element.id.toString() + "'");
          }
          print("index-----" + index.toString());
          index++;
          // print('qIdList --333----' + qIdList.toString());
          // print('FirsStore result ------' + value.docs.length.toString());

          print(element.id);
          print(element.get('question'));
          print(element.get('qyear'));
          print(element.get('qlevel'));
          print(element.get('score'));
          print(element.get('answer_type'));
          print(element.get('correct_answer'));
          print(element.get('isApproved'));
          print(element.get('lesson_id'));
          print(element.get('test_id'));
          print(element.get('user_id'));
          element.get('lesson_id') == widget.lessonId &&
                  element.get('isApproved') == 'true'
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

        final cities = _answers.where("question_id", arrayContains: qIdList);
        // print("aaaaaaaaaaaaaaaa" + cities.toString());

        FirebaseFirestore.instance.collection("answers").get().then(
              (value) => {
                // print("Answer------" + value.docs.length.toString()),
                value.docs.forEach(
                  (element) {
                    element.get("question_id") == cities;
                    _anwerListResult.add(
                      AnswerModel(element.id, element.get('answer'),
                          element.get('question_id'), element.get('isCorrect')),
                    );
                  },
                ),
                print("_QuestionListResult.===========" +
                    _questionListResult.toString()),
                _questionListResult.forEach((item) => {
                      // print('Item----' + item.question_id.toString()),
                      answers = [],
                      _anwerListResult.forEach((subItem) => {
                            // print(
                            //     'subItem----' + subItem.question_id.toString()),
                            if (item.question_id == subItem.question_id)
                              {answers.add(subItem)},
                          }),
                      item.answers.addAll(answers),
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
    // print('questionLength============' + _questionList.length.toString());
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          title: Text("Асуулт"),
          backgroundColor: Colors.indigo,
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
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
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
                                : Column(
                                    children: [
                                      SizedBox(height: 40),
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
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
                        Expanded(
                          flex: 0,
                          child: Text(
                            "Баяр хүргэе!",
                            style: TextStyle(
                              color: Colors.indigo,
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
                              color: Colors.indigo,
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
                                    color: Colors.indigo,
                                    fontSize: 40,
                                    fontFamily: "TimesNewRoman",
                                  ),
                                ),
                                Text(
                                  '/',
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 40,
                                    fontFamily: "TimesNewRoman",
                                  ),
                                ),
                                Text(
                                  AllPoint.toString(),
                                  style: TextStyle(
                                    color: Colors.indigo,
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
