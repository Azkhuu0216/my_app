import 'package:flutter/material.dart';
import 'package:my_app/firstQuiz.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/category_model.dart';
import 'package:my_app/secondQuiz.dart';
import 'package:postgres/postgres.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  void initState() {
    Postgre();
    super.initState();
  }

  List<Category> _listCategoryResult = [];
  List<Category> _listCategoryData = [];
  List<Widget> _gridListResult = [];
  List<Widget> _gridList = [];
  // List<DraggableGridItem> _listOfDraggableGridItem = [
  //   DraggableGridItem(child: Text('a'), isDraggable: false),
  //   DraggableGridItem(child: Text('b'), isDraggable: false),
  // ];
  Future<void> Postgre() async {
    var connection = PostgreSQLConnection("10.2.203.219", 5433, "Chemistry",
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

    List<Map<String, Map<String, dynamic>>> results =
        await connection.mappedResultsQuery("SELECT  * FROM categories ");
    results.forEach((element) {
      _listCategoryResult.add(Category(
          element.values.first.entries.first.value.toString(),
          element.values.first.entries.elementAt(1).value,
          element.values.first.entries.elementAt(2).value.toString()));
      // print(element.values.first.entries.first.value);
      // print(element.values.first.entries.elementAt(1).value);
      _gridListResult.add(yearButton(
          context, element.values.first.entries.elementAt(1).value, () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // ignore: prefer_const_constructors
            builder: (context) =>
                SecondQuiz(element.values.first.entries.first.value.toString()),
          ),
        );
      }));
    });

    setState(() {
      _listCategoryData = _listCategoryResult;
      _gridList = _gridListResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: _gridList,
    ));
  }
}
