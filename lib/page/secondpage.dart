import 'package:flutter/material.dart';
import 'package:my_app/common/reuseable_widget.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  const SizedBox(height: 40),
                  yearButton(context, true, () {}),
                  yearButton(context, true, () {}),
                  yearButton(context, true, () {}),
                  yearButton(context, true, () {}),
                  yearButton(context, true, () {}),
                  yearButton(context, true, () {}),
                ],
              ))
            ],
          )),
    );
  }
}
