import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/home/home.dart';
import 'package:my_app/model/answer_model.dart';
import 'package:postgres/postgres.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:group_button/group_button.dart';

import '../model/lesson_model.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  String answerId = "";
  String question = "";
  String answer1 = "";
  String answer2 = "";
  String answer3 = "";
  String answer4 = "";
  String answer5 = "";
  String explain = '';
  var answerLen = 0;
  var answer = '';
  var isCorrect = '';
  int mapIndex = 1;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isChecked4 = false;
  bool _isChecked5 = false;

  String _currText = '';

  String? selectedValue;
  List<Lesson> items = [
    Lesson("1", 'Математик'),
    Lesson("2", 'Монгол хэл'),
    Lesson("3", 'Англи хэл'),
    Lesson("4", 'Хими')
  ];

  List<dynamic> answers = [];
  List<dynamic> answersResult = [];

  void initState() {
    super.initState();
  }

  var val = 0;
  void onTap() {
    if (val < 5) {
      val = val + 1;
      answers.add({"index": val, "param": {}});
      setState(() {
        answersResult = answers;
      });
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Таны хариулт 5-аас хэтэрсэн байна",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference questions =
        FirebaseFirestore.instance.collection('questions');
    CollectionReference answerses =
        FirebaseFirestore.instance.collection('answers');

    Future<Future> addQuestion() async {
      if (answer1 != "") answerLen++;
      if (answer2 != "") answerLen++;
      if (answer3 != "") answerLen++;
      if (answer4 != "") answerLen++;
      if (answer5 != "") answerLen++;
      // Call the user's CollectionReference to add a new user
      return questions
          .add({
            'question': question,
            'qyear': '2009',
            'qlevel': 'intermediate',
            'score': '2',
            'answer_type': '1',
            'correct_answer': explain,
            'isApproved': 'true',
            'lesson_id': selectedValue,
            'test_id': '24',
            'user_id': currentUser!.uid
          })
          .then(
            (value) => {
              for (int i = 1; i <= answerLen; i++)
                {
                  answer = i.toString() == '1'
                      ? answer1
                      : i.toString() == '2'
                          ? answer2
                          : i.toString() == '3'
                              ? answer3
                              : i.toString() == '4'
                                  ? answer4
                                  : answer5,
                  isCorrect = i.toString() == '1'
                      ? _isChecked1
                          ? '1'
                          : '0'
                      : i.toString() == '2'
                          ? _isChecked2
                              ? '1'
                              : '0'
                          : i.toString() == '3'
                              ? _isChecked3
                                  ? '1'
                                  : '0'
                              : i.toString() == '4'
                                  ? _isChecked4
                                      ? '1'
                                      : '0'
                                  : _isChecked5
                                      ? '1'
                                      : '0',
                  answerses.add({
                    'answer': answer,
                    'question_id': value.id,
                    'isCorrect': isCorrect
                  })
                },
              setState(() {
                answersResult = [];
                answers = [];
                question = "";
                showTopSnackBar(
                  context,
                  CustomSnackBar.success(
                    message: "Хүсэлт амжилттай илгээлээ!!!",
                  ),
                );
              }),
            },
          )
          // ignore: invalid_return_type_for_catch_error, avoid_print
          .catchError((error) => print("Failed to add user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Асуулт нэмэх"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: const [
                              Icon(
                                Icons.list,
                                size: 20,
                                color: Colors.teal,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  'Хичээлийн нэр',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          items: items
                              .map((item) => DropdownMenuItem<Object>(
                                    value: item.lesson_id,
                                    child: Text(
                                      item.lessonName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              print('Catergory ======' + value.toString());
                              selectedValue = value as String;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          buttonHeight: 55,
                          buttonPadding:
                              const EdgeInsets.only(left: 18, right: 18),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Colors.blueGrey.shade50,
                          ),
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.blueGrey.shade50,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 290,
                            child: TextFormField(
                              maxLines: 2,
                              cursorColor: Colors.black87,
                              autocorrect: false,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.question_mark_sharp,
                                    color: Colors.black54),
                                labelText: 'Асуулт нэмэх',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Colors.blueGrey.shade50,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  question = value;
                                });
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          AddButton(context, Icons.add, onTap),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ...answersResult.map(
                            (e) => Column(
                              children: [
                                SizedBox(height: 10),
                                Expanded(
                                  flex: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 290,
                                        child: TextFormField(
                                          cursorColor: Colors.black87,
                                          obscureText: false,
                                          autocorrect: false,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                                Icons.question_answer_sharp,
                                                color: Colors.black54),
                                            labelText: 'Хариулт нэмэх',
                                            labelStyle: const TextStyle(
                                                color: Colors.black54),
                                            filled: true,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            fillColor: Colors.blueGrey.shade50,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    width: 0,
                                                    style: BorderStyle.none)),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              // print("index==" + index.toString());
                                              val == 1
                                                  ? answer1 = value
                                                  : val == 2
                                                      ? answer2 = value
                                                      : val == 3
                                                          ? answer3 = value
                                                          : val == 4
                                                              ? answer4 = value
                                                              : answer5 = value;
                                            });
                                          },
                                          keyboardType:
                                              TextInputType.emailAddress,
                                        ),
                                      ),
                                      Checkbox(
                                        value: e['index'] == 1
                                            ? _isChecked1
                                            : e['index'] == 2
                                                ? _isChecked2
                                                : e['index'] == 3
                                                    ? _isChecked3
                                                    : e['index'] == 4
                                                        ? _isChecked4
                                                        : _isChecked5,
                                        onChanged: (val) {
                                          if (e['index'] == 1) {
                                            _isChecked1 = val!;
                                            _isChecked2 = false;
                                            _isChecked3 = false;
                                            _isChecked4 = false;
                                            _isChecked5 = false;
                                          }
                                          if (e['index'] == 2) {
                                            _isChecked1 = false;
                                            _isChecked2 = val!;
                                            _isChecked3 = false;
                                            _isChecked4 = false;
                                            _isChecked5 = false;
                                          }
                                          if (e['index'] == 3) {
                                            _isChecked1 = false;
                                            _isChecked2 = false;
                                            _isChecked3 = val!;
                                            _isChecked4 = false;
                                            _isChecked5 = false;
                                          }
                                          if (e['index'] == 4) {
                                            _isChecked1 = false;
                                            _isChecked2 = false;
                                            _isChecked3 = false;
                                            _isChecked4 = val!;
                                            _isChecked5 = false;
                                          }
                                          if (e['index'] == 5) {
                                            _isChecked1 = false;
                                            _isChecked2 = false;
                                            _isChecked3 = false;
                                            _isChecked4 = false;
                                            _isChecked5 = val!;
                                          }

                                          setState(() {
                                            if (_isChecked1) {
                                              _isChecked1 = true;
                                              _isChecked2 = false;
                                              _isChecked3 = false;
                                              _isChecked4 = false;
                                              _isChecked5 = false;
                                            }
                                            if (_isChecked2) {
                                              _isChecked2 = true;
                                              _isChecked1 = false;
                                              _isChecked3 = false;
                                              _isChecked4 = false;
                                              _isChecked5 = false;
                                            }
                                            if (_isChecked3) {
                                              _isChecked3 = true;
                                              _isChecked1 = false;
                                              _isChecked2 = false;
                                              _isChecked4 = false;
                                              _isChecked5 = false;
                                            }
                                            if (_isChecked4) {
                                              _isChecked4 = true;
                                              _isChecked1 = false;
                                              _isChecked2 = false;
                                              _isChecked3 = false;
                                              _isChecked5 = false;
                                            }
                                            if (_isChecked5) {
                                              _isChecked5 = true;
                                              _isChecked1 = false;
                                              _isChecked2 = false;
                                              _isChecked3 = false;
                                              _isChecked4 = false;
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      child: TextFormField(
                        cursorColor: Colors.black87,
                        obscureText: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.question_answer_sharp,
                              color: Colors.black54),
                          labelText: 'Зөв хариултын тайлбар бичнэ үү...',
                          labelStyle: const TextStyle(color: Colors.black54),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.blueGrey.shade50,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            explain = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        height: 80,
                        padding: EdgeInsets.only(bottom: 30),
                        child: Button(
                            50, 2000, "Нэмэх", Colors.teal, Colors.white, () {
                          print("cat---" + selectedValue.toString());
                          print("cat0---" + question.toString());
                          print("cat1---" + answer1.toString());
                          print("cat2---" + answer2.toString());
                          print("cat3---" + answer3.toString());
                          print("cat4---" + answer4.toString());
                          print("cat5---" + answer5.toString());
                          if (selectedValue == null) {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                message: "Хичээлийн нэрээ сонгоно уу...",
                              ),
                            );
                          } else if (!_isChecked1 &&
                              !_isChecked2 &&
                              !_isChecked3 &&
                              !_isChecked4 &&
                              !_isChecked5) {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                message: "Та зөв хариултаа сонгоно уу...",
                              ),
                            );
                          } else if (question == '') {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.error(
                                message: "Та асуултаа бичнэ үү...",
                              ),
                            );
                          } else {
                            // saveData();
                            addQuestion();
                            // addAnswers();
                          }
                        }, Icons.add),
                      ),
                    ),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
