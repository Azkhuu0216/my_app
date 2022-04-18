import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_app/addQuestion.dart';
import 'package:my_app/intermediate.dart';
import 'package:my_app/password.dart';
import 'package:my_app/signIn.dart';
import 'package:my_app/upper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'about.dart';
import 'common/button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn = true;
  final _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // print(_auth.currentUser);
    void _signOut() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('username');
      setState(() {
        isLoggedIn = false;
      });
    }

    void _intermediate() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Intermediate()));
    }

    void _addQuestion() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AddQuestion()));
    }

    void _upper() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Upper()));
    }

    void Loading() {
      EasyLoading.show(status: 'loading...');
    }

    final size = MediaQuery.of(context).size;
    return isLoggedIn
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              title: const Text(
                "Хими ЭЕШ",
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
            ),
            body: Container(
              alignment: Alignment.center,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        // ignore: avoid_unnecessary_containers
                        Button(50, 300, "Анхан", Colors.teal, Colors.white,
                            _intermediate, null),
                        const SizedBox(
                          height: 20,
                        ),
                        // ignore: avoid_unnecessary_containers
                        Button(50, 300, "Ахисан", Colors.teal, Colors.white,
                            _upper, null),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        // ignore: avoid_unnecessary_containers
                        Button(
                          50,
                          300,
                          "Асуулт нэмэх",
                          Colors.teal,
                          Colors.white,
                          _addQuestion,
                          Icons.quiz,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            drawer: Drawer(
              backgroundColor: Colors.teal,
              child: Material(
                color: Colors.teal,
                child: Column(
                  children: <Widget>[
                    // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                    AppBar(
                      elevation: 0,
                      title: const Text("Миний тухай"),
                      backgroundColor: Colors.teal,
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        height: 200,
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            const CircleAvatar(
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/images/profile.jpeg"),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Azkhuu Amgalanbaatar",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 45),
                            menuItem(
                                text: 'Хувийн мэдээлэл',
                                icon: Icons.supervised_user_circle_rounded,
                                onClicked: () => _selectItem(context, 0)),
                            menuItem(
                                text: 'Хими ЭЕШ',
                                icon: Icons.create_sharp,
                                onClicked: () => _selectItem(context, 1)),
                            menuItem(
                                text: 'Нууц үг солих',
                                icon: Icons.password,
                                onClicked: () => _selectItem(context, 2)),
                            menuItem(
                              text: 'Миний тестүүд',
                              icon: Icons.quiz,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Button(50, 250, "Гарах", Colors.white, Colors.teal,
                              _signOut, null)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : SignIn();
  }
}

Widget menuItem(
    {required String text, required IconData icon, VoidCallback? onClicked}) {
  // ignore: prefer_const_declarations
  final color = Colors.white;
  // ignore: prefer_const_declarations
  final hoverColor = Colors.white70;
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(text, style: TextStyle(color: color)),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void _selectItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => About()),
      );
      break;
    case 1:
      Navigator.pop(context);
      break;
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Password()),
      );
  }
}
