import 'package:flutter/material.dart';
import 'package:my_app/intermediate.dart';

import 'package:my_app/password.dart';
import 'package:my_app/signIn.dart';
import 'package:my_app/upper.dart';

import 'about.dart';
import 'common/button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    void _signOut() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    }

    void _intermediate() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Intermediate()));
    }

    void _upper() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Upper()));
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                  Button(
                    height: 50,
                    width: 300,
                    title: "Анхан",
                    color: Colors.teal,
                    color1: Colors.white,
                    onPress: _intermediate,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // ignore: avoid_unnecessary_containers
                  Button(
                      height: 50,
                      width: 300,
                      title: "Ахисан",
                      color: Colors.teal,
                      color1: Colors.white,
                      onPress: _upper),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  // ignore: avoid_unnecessary_containers
                  Button(
                      height: 50,
                      width: 300,
                      title: "Тест нэмэх",
                      color: Colors.teal,
                      color1: Colors.white,
                      onPress: _intermediate,
                      icon: Icons.note_add_sharp),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    height: 50,
                    width: 300,
                    title: "Сэдэв нэмэх",
                    color: Colors.teal,
                    color1: Colors.white,
                    onPress: _intermediate,
                    icon: Icons.topic,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Button(
                    height: 50,
                    width: 300,
                    title: "Асуулт нэмэх",
                    color: Colors.teal,
                    color1: Colors.white,
                    onPress: _intermediate,
                    icon: Icons.quiz,
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
                    Button(
                      height: 50,
                      width: 250,
                      title: "Гарах",
                      color: Colors.white,
                      color1: Colors.teal,
                      onPress: _signOut,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
        MaterialPageRoute(builder: (context) => const About()),
      );
      break;
    case 1:
      Navigator.pop(context);
      break;
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Password()),
      );
  }
}
