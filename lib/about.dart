import 'package:flutter/material.dart';
import 'package:my_app/common/input.dart';

import 'common/button.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    void _about() {
      Navigator.pop(context);
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Хувийн мэдээлэл"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 52, right: 52),
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          const CircleAvatar(
                            radius: 90,
                            backgroundImage:
                                AssetImage("assets/images/profile.jpeg"),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Input(
                            placeholder: "Овог",
                            height: 50,
                            icon: Icons.supervised_user_circle_sharp,
                          ),
                          const Input(
                            placeholder: "Нэр",
                            height: 50,
                            icon: Icons.supervised_user_circle_rounded,
                          ),
                          const Input(
                            placeholder: "Утасны дугаар",
                            height: 50,
                            icon: Icons.phone,
                          ),
                          const Input(
                            placeholder: "И-мэйл",
                            height: 50,
                            icon: Icons.mail_rounded,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Button(
                            height: 50,
                            width: 300,
                            title: "Хадгалах",
                            color: Colors.teal,
                            color1: Colors.white,
                            onPress: _about,
                          ),
                        ],
                      ),
                    ),
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
