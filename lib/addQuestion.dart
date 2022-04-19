import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:my_app/common/button.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  String categoryName = "";
  String? selectedValue;
  List<String> items = [
    'Органик хими',
    'Органик бус хими',
    'Ерөнхий хими',
    'Физик хими',
  ];
  var index = 0;
  void onTap() {
    setState(() {
      for (index = 0; index < 5; index++) {
        print(index);
      }
    });
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
              SizedBox(height: 20),
              Container(child: Text("hi")),
              Container(
                  child: TextFormField(
                cursorColor: Colors.black87,
                obscureText: false,
                autocorrect: true,
                // keyboardType: TextInputType.,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.question_answer_rounded,
                      color: Colors.black54),
                  labelText: 'Категори',
                  labelStyle: const TextStyle(color: Colors.black54),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.blueGrey.shade50,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none)),
                ),
                onChanged: (value) {
                  categoryName = value;
                },
                keyboardType: TextInputType.emailAddress,
              )),
              SizedBox(height: 20),
              Button(50, 300, "Асуулт нэмэх", Colors.blueGrey.shade50,
                  Colors.teal, onTap, Icons.add),
              index == 0
                  ? Text("hi")
                  : TextFormField(
                      cursorColor: Colors.black87,
                      obscureText: false,
                      autocorrect: true,
                      // keyboardType: TextInputType.,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.question_answer_rounded,
                            color: Colors.black54),
                        labelText: 'Категори',
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
            ],
          ),
        ));
  }
}
