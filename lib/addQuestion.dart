import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/answer_model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  void initState() {
    super.initState();
  }

  String categoryName = "";
  String answer1 = "";
  String answer2 = "";
  String answer3 = "";
  String answer4 = "";
  String answer5 = "";

  String? selectedValue;
  List<String> items = [
    'Органик хими',
    'Органик бус хими',
    'Ерөнхий хими',
    'Физик хими',
  ];

  List<dynamic> answers = [];
  List<dynamic> answersResult = [];
  var index = 0;
  void onTap() {
    if (index < 5) {
      print(index);
      index = index + 1;
      answers.add({});
      setState(() {
        answersResult = answers;
      });
    } else {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "Таны хариулт 5-аас хэтэрсэн байна",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Асуулт нэмэх"),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                flex: 0,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        Icon(
                          Icons.list,
                          size: 20,
                          color: Colors.teal,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Категори',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                    ),
                    iconSize: 14,
                    buttonHeight: 55,
                    buttonPadding: const EdgeInsets.only(left: 18, right: 18),
                    buttonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      color: Colors.blueGrey.shade50,
                    ),
                    itemHeight: 40,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueGrey.shade50,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 290,
                      child: TextFormField(
                        maxLines: 2,
                        cursorColor: Colors.black87,
                        obscureText: false,
                        autocorrect: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.question_mark_sharp,
                              color: Colors.black54),
                          labelText: 'Асуулт нэмэх',
                          labelStyle: const TextStyle(color: Colors.black54),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.blueGrey.shade50,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 0, style: BorderStyle.none)),
                        ),
                        onChanged: (value) {
                          categoryName = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    AddButton(context, Icons.add, onTap),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    ...answers.map(
                      (e) => Container(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            TextFormField(
                              cursorColor: Colors.black87,
                              obscureText: false,
                              autocorrect: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.question_answer_sharp,
                                    color: Colors.black54),
                                labelText: 'Хариулт нэмэх',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                filled: true,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                fillColor: Colors.blueGrey.shade50,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                              ),
                              onChanged: (value) {
                                index == 0
                                    ? answer1
                                    : index == 1
                                        ? answer2
                                        : index == 2
                                            ? answer3
                                            : answer4 = value;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  child: Button(50, 2000, "Нэмэх", Colors.teal, Colors.white,
                      onTap, Icons.add),
                ),
              ),
            ],
          ),
        ));
  }
}
