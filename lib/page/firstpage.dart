import "package:flutter/material.dart";
import 'package:my_app/Quiz.dart';
import 'package:my_app/common/reuseable_widget.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: Row(
                  children: <Widget>[
                    TestButton(context, true, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Quiz(),
                        ),
                      );
                    }),
                    TestButton(context, true, () {}),
                    TestButton(context, true, () {}),
                    TestButton(context, true, () {}),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Row(
                  children: <Widget>[
                    TestButton(context, true, () {}),
                    TestButton(context, true, () {}),
                    TestButton(context, true, () {}),
                    TestButton(context, true, () {}),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  // ignore: non_constant_identifier_names

}
