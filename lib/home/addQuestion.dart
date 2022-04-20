import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/answer_model.dart';
import 'package:postgres/postgres.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../model/category_model.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  String categoryName = "";
  String answer1 = "";
  String answer2 = "";
  String answer3 = "";
  String answer4 = "";
  String answer5 = "";
  bool _isChecked = false;
  String _currText = '';

  String? selectedValue;
  List<Category> items = [
    Category("1", 'Органик хими', ''),
    Category("2", 'Органик бус хими', ''),
    Category("3", 'Ерөнхий хими', ''),
    Category("4", 'Физик хими', '')
  ];

  List<dynamic> answers = [];
  List<dynamic> answersResult = [];

  void initState() {
    super.initState();
  }

  Future<void> saveData() async {
    var connection = PostgreSQLConnection("10.10.203.29", 5433, "Chemistry",
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
    String query =
        "insert into questions(question, question_image, qyear, qlevel, score, answer_type, correct_answer, cat_id, exam_id, user_id ) values ( '" +
            categoryName +
            "', 'null',  '1000', 'intermediate', '2', 1, '1', 1, 1, '" +
            currentUser!.uid +
            "') RETURNING question_id";
    List<Map<String, Map<String, dynamic>>> results =
        await connection.mappedResultsQuery(query);
    if (results.length < 1) {
      return;
    }
    var qId = 0;
    results.forEach((e) => qId = e.values.first.entries.first.value);
    print("id ==" + qId.toString());

    var answerLen = 0;
    if (answer1 != "") answerLen++;
    if (answer2 != "") answerLen++;
    if (answer3 != "") answerLen++;
    if (answer4 != "") answerLen++;
    if (answer5 != "") answerLen++;
    print("answerLen ==" + answerLen.toString());
    for (int i = 1; i <= answerLen; i++) {
      var answer = i.toString() == '1'
          ? answer1
          : i.toString() == '2'
              ? answer2
              : i.toString() == '3'
                  ? answer3
                  : i.toString() == '4'
                      ? answer4
                      : answer5;

      print("answer====" + answer);
      String queryAnswer =
          "insert into Answers(answer, question_id, isCorrect) values ('" +
              answer +
              "', '" +
              qId.toString() +
              "', '0')";
      List<Map<String, Map<String, dynamic>>> resultsAnswer =
          await connection.mappedResultsQuery(queryAnswer);

      if (resultsAnswer.length < 1) {
        return;
      }
      var aId = 0;
      resultsAnswer.forEach((e) => aId = e.values.first.entries.first.value);
      print("AnswerId ==" + aId.toString());
    }
  }

  var index = 0;
  void onTap() {
    if (index < 5) {
      print(index);
      index = index + 1;
      answers.add({});
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
    return Scaffold(
        appBar: AppBar(
          title: Text("Асуулт нэмэх"),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                flex: 0,
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
                            'Категори',
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
                              value: item.category_id,
                              child: Text(
                                item.category_name,
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
                        selectedValue = value as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    buttonHeight: 55,
                    buttonPadding: const EdgeInsets.only(left: 18, right: 18),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.blueGrey.shade50,
                    ),
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueGrey.shade50,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 290,
                      child: TextFormField(
                        maxLines: 2,
                        cursorColor: Colors.black87,
                        obscureText: false,
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.question_mark_sharp,
                              color: Colors.black54),
                          labelText: 'Асуулт нэмэх',
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
                          print("asuult===" + value.toString());
                          setState(() {
                            categoryName = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    AddButton(context, Icons.add, onTap),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 290,
                                  child: TextFormField(
                                    cursorColor: Colors.black87,
                                    obscureText: false,
                                    autocorrect: true,
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
                                        print("index==" + index.toString());
                                        index == 1
                                            ? answer1 = value
                                            : index == 2
                                                ? answer2 = value
                                                : index == 3
                                                    ? answer3 = value
                                                    : index == 4
                                                        ? answer4 = value
                                                        : answer5 = value;
                                      });
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                Checkbox(
                                  value: _isChecked,
                                  onChanged: (val) {
                                    setState(() {
                                      if (val == true) {
                                        _currText = '1';
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Container(
                      //   width: 200,
                      //   child: Row(
                      //     children: [
                      //       SizedBox(height: 10),
                      //       TextFormField(
                      //         cursorColor: Colors.black87,
                      //         obscureText: false,
                      //         autocorrect: true,
                      //         decoration: InputDecoration(
                      //           prefixIcon: Icon(Icons.question_answer_sharp,
                      //               color: Colors.black54),
                      //           labelText: 'Хариулт нэмэх',
                      //           labelStyle:
                      //               const TextStyle(color: Colors.black54),
                      //           filled: true,
                      //           floatingLabelBehavior:
                      //               FloatingLabelBehavior.never,
                      //           fillColor: Colors.blueGrey.shade50,
                      //           border: OutlineInputBorder(
                      //               borderRadius: BorderRadius.circular(10),
                      //               borderSide: const BorderSide(
                      //                   width: 0, style: BorderStyle.none)),
                      //         ),
                      //         onChanged: (value) {
                      //           setState(() {
                      //             print("index==" + index.toString());
                      //             index == 1
                      //                 ? answer1 = value
                      //                 : index == 2
                      //                     ? answer2 = value
                      //                     : index == 3
                      //                         ? answer3 = value
                      //                         : index == 4
                      //                             ? answer4 = value
                      //                             : answer5 = value;
                      //           });
                      //         },
                      //         keyboardType: TextInputType.emailAddress,
                      //       ),
                      //       CheckboxListTile(
                      //         title: Text(answer1),
                      //         value: _isChecked,
                      //         onChanged: (val) {
                      //           setState(() {
                      //             _isChecked = val!;
                      //             if (val == true) {
                      //               _currText = answer1;
                      //             }
                      //           });
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  child:
                      Button(50, 2000, "Нэмэх", Colors.teal, Colors.white, () {
                    print("cat---" + selectedValue.toString());
                    print("cat0---" + categoryName.toString());
                    print("cat1---" + answer1.toString());
                    print("cat2---" + answer2.toString());
                    print("cat3---" + answer3.toString());
                    print("cat4---" + answer4.toString());
                    print("cat5---" + answer5.toString());
                    saveData();
                  }, Icons.add),
                ),
              ),
            ],
          ),
        ));
  }
}
