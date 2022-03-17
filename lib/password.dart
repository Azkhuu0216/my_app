import 'package:flutter/material.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/input.dart';

class Password extends StatelessWidget {
  const Password({Key? key}) : super(key: key);

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
          title: const Text("Нууц үг солих"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: SizedBox(
          height: size.height,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 50),
            child: Column(
              children: [
                Expanded(
                  flex: 12,
                  child: Column(
                    children: const [
                      Input(
                        placeholder: "Одоогийн нууц үг",
                        height: 50,
                        icon: Icons.lock,
                      ),
                      Input(
                        placeholder: "Шинэ нууц үг",
                        height: 50,
                        icon: Icons.lock,
                      ),
                      Input(
                        placeholder: "Шинэ нууц үг давтах",
                        height: 50,
                        icon: Icons.lock,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
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
        ),
      ),
    );
  }
}
