import 'package:flutter/material.dart';
import 'package:my_app/provider/mainProvider.dart';
import 'package:provider/provider.dart';

class Answer extends StatefulWidget {
  final String answerText;
  final String answerId;
  final String isCorrect;
  Color _backColor;

  Answer(
    this.answerText,
    this.answerId,
    this.isCorrect,
    this._backColor,
  );

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  var check;
  void initState() {
    super.initState();
  }

  void checkAnswer() {
    print("checkAnswer========");
    setState(() {
      widget.isCorrect == '1' ? check = 1 : check = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    MainProvider _mainProvider =
        Provider.of<MainProvider>(context, listen: true);
    print("aaaaa=== " + widget.isCorrect);
    print('check--------' + check.toString());
    return Container(
      width: 350,
      height: 60,
      margin: const EdgeInsets.only(left: 20, top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
        child: Text(
          widget.answerText,
          style: const TextStyle(
              color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            } else {
              return widget._backColor;
            }
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: () {
          if (_mainProvider.getIsClick()) {
            return;
          }
          checkAnswer();
          _mainProvider.setCheck(check);

          widget.isCorrect == '1'
              ? _mainProvider.setPoint(_mainProvider.getPoint() + 2)
              : _mainProvider.getPoint();
          _mainProvider.setIsClick(true);
          _mainProvider.setSelectAnswerId(widget.answerId);
          // setState(() {
          //   widget._backColor =
          //       widget.isCorrect == '1' ? Colors.green : Colors.red;
          // });
        },
      ),
    );

    // return Container(
    //   width: double.infinity,
    //   child: ElevatedButton(
    //       child: const Text("hariult"), onPressed: selectHandler),
    // );
  }
}
