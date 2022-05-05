import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:my_app/quiz/firstQuiz.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/test_model.dart';
import 'package:my_app/model/question_model.dart';
import 'package:my_app/provider/mainProvider.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_draggable_gridview/flutter_draggable_gridview.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void initState() {
    // Postgre();
    getData();
    super.initState();
  }

  List<Test> _listTestResult = [];
  List<Test> _listTestData = [];
  List<Widget> _gridListResult = [];
  List<Widget> _gridList = [];

  CollectionReference users = FirebaseFirestore.instance.collection('tests');

  Future<void> getData() async {
    FirebaseFirestore.instance.collection("tests").get().then(
      (value) {
        value.docs.forEach(
          (element) {
            _listTestResult.add(Test(
              element.id,
              element.get('testname'),
            ));
            // print('element =  ' + element.get('firstname'));
            _gridListResult.add(
              TestButton(
                context,
                element.get('testname'),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // ignore: prefer_const_constructors
                      builder: (context) => Quiz(element.id),
                    ),
                  );
                },
              ),
            );
            setState(() {
              _listTestData = _listTestResult;
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
      body: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        children: _gridList,
      ),
    );
  }
}
