import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:my_app/quiz/firstQuiz.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/exam_model.dart';
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

  List<Exam> _listExamResult = [];
  List<Exam> _listExamData = [];
  List<Widget> _gridListResult = [];
  List<Widget> _gridList = [];
  // List<DraggableGridItem> _listOfDraggableGridItem = [
  //   DraggableGridItem(child: Text('a'), isDraggable: false),
  //   DraggableGridItem(child: Text('b'), isDraggable: false),
  // ];
  // Future<void> Postgre() async {
  //   var connection = PostgreSQLConnection("192.168.55.209", 5433, "Chemistry",
  //       // ignore: non_constant_identifier_names
  //       username: "postgres",
  //       password: "azaa");
  //   try {
  //     await connection.open();
  //     print("connect");
  //   } catch (e) {
  //     print('error....');
  //     print(e.toString());
  //   }

  //   List<Map<String, Map<String, dynamic>>> results =
  //       await connection.mappedResultsQuery("SELECT  * FROM exams ");
  //   // print(results);

  //   results.forEach((element) {
  //     _listExamResult.add(Exam(
  //         element.values.first.entries.first.value.toString(),
  //         element.values.first.entries.elementAt(1).value,
  //         element.values.first.entries.elementAt(2).value));
  //     _gridListResult.add(TestButton(
  //         context, element.values.first.entries.elementAt(1).value, () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           // ignore: prefer_const_constructors
  //           builder: (context) =>
  //               Quiz(element.values.first.entries.first.value.toString()),
  //         ),
  //       );
  //     }));
  //   });

  //   setState(() {
  //     _listExamData = _listExamResult;
  //     _gridList = _gridListResult;
  //   });
  // }

  CollectionReference users = FirebaseFirestore.instance.collection('exams');

  Future<void> getData() async {
    FirebaseFirestore.instance.collection("exams").get().then(
      (value) {
        value.docs.forEach(
          (element) {
            _listExamResult.add(Exam(
              element.id,
              element.get('exam_name'),
            ));
            // print('element =  ' + element.get('firstname'));
            _gridListResult.add(
              TestButton(
                context,
                element.get('exam_name'),
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
              _listExamData = _listExamResult;
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
