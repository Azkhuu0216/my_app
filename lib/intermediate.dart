// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:my_app/page/firstpage.dart';
import 'package:my_app/page/secondpage.dart';
import 'page/thirdpage.dart';

class Intermediate extends StatelessWidget {
  const Intermediate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Холимог",
              ),
              Tab(
                text: "Онууд",
              ),
              Tab(
                text: "Багш",
              ),
            ],
          ),
          title: const Text('Анхан шат'),
          backgroundColor: Colors.teal,
        ),
        body: const TabBarView(
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
