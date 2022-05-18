// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_app/page/firstpage.dart';
import 'package:my_app/page/secondpage.dart';
import '../page/thirdpage.dart';

class Upper extends StatelessWidget {
  const Upper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Сэдэвүүд",
              ),
              Tab(
                text: "Хичээл",
              ),
              Tab(
                text: "Насанд хүрсэн",
              ),
            ],
          ),
          title: const Text('Ахисан түвшний тест'),
          backgroundColor: Colors.indigo,
        ),
        body: TabBarView(
          children: <Widget>[
            FirstPage(),
            SecondPage(),
            ThirdPage(),
          ],
        ),
      ),
    );
  }
}
