import 'package:flutter/material.dart';
import 'package:my_app/common/reuseable_widget.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            teacherButton(context, true, () {}),
            teacherButton(context, false, () {}),
            teacherButton(context, true, () {}),
            teacherButton(context, false, () {}),
            teacherButton(context, true, () {}),
            teacherButton(context, false, () {}),
          ],
        ),
      ),
    );
  }
}
