// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls, avoid_unnecessary_containers, unused_import, annotate_overrides, unused_field, avoid_print, prefer_const_constructors

import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/model/lesson_model.dart';
import 'package:my_app/quiz/firstQuiz.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/quiz/myQuiz.dart';
import 'package:my_app/quiz/thirdQuiz.dart';
import 'package:postgres/postgres.dart';

class Mytests extends StatefulWidget {
  const Mytests({Key? key}) : super(key: key);

  @override
  State<Mytests> createState() => _MytestsState();
}

class _MytestsState extends State<Mytests> {
  var loading = true;

  final _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  void initState() {
    Timer(
        const Duration(seconds: 1),
        () => setState(() {
              loading = false;
            }));
    getData();
    super.initState();
  }

  List<Lesson> LessonResult = [];
  List<Lesson> LessonData = [];
  List<Widget> ListModel = [];
  List<Widget> ColumnList = [];

  Future<void> getData() async {
    FirebaseFirestore.instance.collection("lessons").get().then(
      (value) {
        value.docs.forEach(
          (element) {
            LessonResult.add(Lesson(
              element.id,
              element.get('lessonName'),
            ));
            // print('element =  ' + element.get('firstname'));
            ListModel.add(
              yearButton(
                context,
                element.get('lessonName'),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // ignore: prefer_const_constructors
                      builder: (context) =>
                          MyQuiz(currentUser!.uid, element.id),
                    ),
                  );
                },
              ),
            );
            setState(() {
              LessonData = LessonResult;
              ColumnList = ListModel;
            });
          },
        );
      },
    );
  }

  // print("Userresult" + UserResult.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Миний тестүүд"),
        backgroundColor: Colors.teal,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Linear progress indicator',
              ),
            )
          : Container(
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: ColumnList),
                  ),
                ],
              ),
            ),
    );
  }
}
            // FutureBuilder<DocumentSnapshot>(
            //   future: users.doc(currentUser!.uid).get(),
            //   builder: (BuildContext context,
            //       AsyncSnapshot<DocumentSnapshot> snapshot) {
            //     if (snapshot.hasError) {
            //       return Text("Something went wrong");
            //     }
            //     if (snapshot.hasData && !snapshot.data!.exists) {
            //       return Text("Document does not exist");
            //     }

            //     if (snapshot.connectionState == ConnectionState.done) {
            //       Map<String, dynamic> data =
            //           snapshot.data!.data() as Map<String, dynamic>;

            //       print("data =======");
            //       print(data);
            //       print(currentUser.uid);
            //       print(data.entries.first.value);
            //       print(data.values.elementAt(2));
            //       _listUserResult.add(
            //         UserModel(
            //           currentUser.uid.toString(),
            //           data.entries.first.value,
            //           data.entries.elementAt(1).value,
            //           data.entries.elementAt(2).value,
            //           data.entries.elementAt(3).value,
            //           data.entries.elementAt(4).value,
            //         ),
            //       );
            //       data.entries.elementAt(2).value == "Багш"
            //           ? _gridListResult.add(
            //               yearButton(
            //                 context,
            //                 data.entries.first.value,
            //                 () {
            //                   Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                       // ignore: prefer_const_constructors
            //                       builder: (context) =>
            //                           ThirdQuiz(currentUser.uid.toString()),
            //                     ),
            //                   );
            //                 },
            //               ),
            //             )
            //           : null;

            //       return Expanded(
            //           flex: 6,
            //           child: Column(
            //               // ignore: prefer_const_literals_to_create_immutables
            //               children: _gridList));
            //     }
            //     return Text('loading');
            //   },
            // )
           
