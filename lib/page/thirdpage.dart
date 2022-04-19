import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/quiz/firstQuiz.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/model/user_model.dart';
import 'package:my_app/quiz/thirdQuiz.dart';
import 'package:postgres/postgres.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  void initState() {
    setState(() {
      _listUserData = _listUserResult;
      _gridList = _gridListResult;
    });
    super.initState();
  }

  List<UserModel> _listUserResult = [];
  List<UserModel> _listUserData = [];
  List<Widget> _gridListResult = [];
  List<Widget> _gridList = [];

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    var currentUser = FirebaseAuth.instance.currentUser;

    CollectionReference users = FirebaseFirestore.instance.collection("users");
    return Scaffold(
      body: Container(
        child: Column(children: [
          FutureBuilder<DocumentSnapshot>(
            future: users.doc(currentUser!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                print("data =======");
                print(data);
                print(currentUser.uid);
                print(data.entries.first.value);
                print(data.values.elementAt(2));
                _listUserResult.add(
                  UserModel(
                    currentUser.uid.toString(),
                    data.entries.first.value,
                    data.entries.elementAt(1).value,
                    data.entries.elementAt(2).value,
                    data.entries.elementAt(3).value,
                    data.entries.elementAt(4).value,
                  ),
                );
                data.entries.elementAt(2).value == "Багш"
                    ? _gridListResult.add(
                        yearButton(
                          context,
                          data.entries.first.value,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // ignore: prefer_const_constructors
                                builder: (context) =>
                                    ThirdQuiz(currentUser.uid.toString()),
                              ),
                            );
                          },
                        ),
                      )
                    : null;

                return Expanded(
                    flex: 6,
                    child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: _gridList));
              }
              return Text('loading');
            },
          )
        ]),
      ),
    );
  }
}
