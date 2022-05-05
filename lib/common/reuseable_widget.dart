import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/provider/mainProvider.dart';
import 'package:provider/provider.dart';

TextField reTextField(
  String text,
  IconData icon,
  bool isPasswordType,
) {
  return TextField(
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: Colors.black87,
      style: const TextStyle(color: Colors.black54),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black54),
        labelText: text,
        labelStyle: const TextStyle(color: Colors.black54),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.blueGrey.shade50,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress);
}

Container signInSingUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? "Нэвтрэх" : "Бүртгүүлэх",
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          } else {
            return Colors.teal;
          }
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Container AddButton(BuildContext context, IconData icon, VoidCallback onTap) {
  final _auth = FirebaseAuth.instance;
  var currenUser = FirebaseAuth.instance.currentUser;
  MainProvider _mainProvider =
      Provider.of<MainProvider>(context, listen: false);
  return Container(
    width: 55,
    height: 55,
    margin: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
    ),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          } else {
            return Colors.teal;
          }
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
      onPressed: () {
        _mainProvider.setIsClick(false);
        _mainProvider.setSelectAnswerId('');
        _mainProvider.setCheck(0);
        onTap();
      },
      child: Icon(icon),
    ),
  );
}

Container TestButton(BuildContext context, String text, Function onTap) {
  final _auth = FirebaseAuth.instance;
  var currenUser = FirebaseAuth.instance.currentUser;
  MainProvider _mainProvider =
      Provider.of<MainProvider>(context, listen: false);

  return Container(
    // width: 40,
    // height: 50,
    margin: const EdgeInsets.all(9),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: ElevatedButton(
      onPressed: () {
        _mainProvider.setIsClick(false);
        _mainProvider.setSelectAnswerId('');
        _mainProvider.setCheck(0);
        _mainProvider.setPoint(0);
        onTap();
      },
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 15),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          } else {
            return Colors.blue.shade50;
          }
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
  );
}

Container yearButton(BuildContext context, String text, Function onTap) {
  final _auth = FirebaseAuth.instance;
  var currenUser = FirebaseAuth.instance.currentUser;
  MainProvider _mainProvider =
      Provider.of<MainProvider>(context, listen: false);
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: ElevatedButton(
      onPressed: () {
        _mainProvider.setIsClick(false);
        _mainProvider.setSelectAnswerId('');
        _mainProvider.setPoint(0);
        onTap();
      },
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          } else {
            return Colors.teal;
          }
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
  );
}

Container teacherButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
    ),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? "Дорж" : "Дулам",
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          } else {
            return Colors.teal;
          }
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),
  );
}
