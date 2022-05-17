// ignore_for_file: prefer_final_fields, annotate_overrides, unused_field, avoid_function_literals_in_foreach_calls, unused_import, prefer_const_constructors

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/quiz/firstQuiz.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/lesson_model.dart';
import 'package:my_app/quiz/secondQuiz.dart';
import 'package:postgres/postgres.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  var loading = true;
  void initState() {
    Timer(
        const Duration(seconds: 1),
        () => setState(() {
              loading = false;
            }));
    getData();
    super.initState();
  }

  List<Lesson> _listLessonResult = [];
  List<Lesson> _listLessonData = [];
  List<Widget> _gridListResult = [];
  List<Widget> _gridList = [];

  CollectionReference users = FirebaseFirestore.instance.collection('lessons');

  Future<void> getData() async {
    FirebaseFirestore.instance.collection("lessons").get().then(
      (value) {
        value.docs.forEach(
          (element) {
            _listLessonResult.add(Lesson(
              element.id,
              element.get('lessonName'),
            ));
            // print('element =  ' + element.get('firstname'));
            _gridListResult.add(
              yearButton(
                context,
                element.get('lessonName'),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // ignore: prefer_const_constructors
                      builder: (context) => SecondQuiz(element.id),
                    ),
                  );
                },
              ),
            );
            setState(() {
              _listLessonData = _listLessonResult;
              _gridList = _gridListResult;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? Center(
                child: CircularProgressIndicator(
                  semanticsLabel: 'Linear progress indicator',
                ),
              )
            : Column(
                children: _gridList,
              ));
  }
}
