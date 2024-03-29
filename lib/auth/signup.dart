// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_null_comparison, avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/common/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:postgres/postgres.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email = "";
  String _pwd = "";
  String _lastName = "";
  String _firstName = "";
  String _phone = "";
  String _repwd = "";
  String? Urole;
  final _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  var items = [
    'Багш',
    'Сурагч',
  ];
  var loading = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    Future<void> addUser() async {
      // Call the user's CollectionReference to add a new user
      return users
          .doc(_auth.currentUser!.uid)
          .set({
            'lastname': _lastName,
            'firstname': _firstName,
            'phone': _phone,
            'email': _email,
            'Urole': Urole,
          })
          .then((value) => (print("User Added")))
          .catchError((error) => print("Failed to add user: $error"));
    }

    void _signUp() async {
      if (_email == "") {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Та и-мэйлээ оруулна уу!",
          ),
        );
        setState(() {
          loading = false;
        });
      } else if (_pwd == "") {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Та нууц үгээ оруулна уу!",
          ),
        );
        setState(() {
          loading = false;
        });
      } else if (_pwd != _repwd) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Нууц үг таарахгүй байна!",
          ),
        );
        setState(() {
          loading = false;
        });
      } else {
        try {
          final user = await _auth.createUserWithEmailAndPassword(
              email: _email, password: _pwd);
          if (user != null) {
            addUser();
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: "Амжилттай бүртгэлээ!!!",
              ),
            );
            Timer(const Duration(seconds: 2),
                () => Navigator.pushNamed(context, '/home'));
          } else {
            print("User creating is not successful!");
          }
        } catch (e) {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: "Таны и-мэйл болон нууц үгээ шалгаад дахин оролдоно уу!",
            ),
          );
          setState(() {
            loading = false;
          });
          print(e);
        }
      }
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Бүртгүүлэх"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: <Widget>[
              //left side background design. I use a svg image here
              Positioned(
                left: -34,
                top: 181.0,
                child: SvgPicture.string(
                  // Group 3178
                  '<svg viewBox="-34.0 181.0 99.0 99.0" ><path transform="translate(-34.0, 181.0)" d="M 74.25 0 L 99 49.5 L 74.25 99 L 24.74999618530273 99 L 0 49.49999618530273 L 24.7500057220459 0 Z" fill="none" stroke="#21899c" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-26.57, 206.25)" d="M 0 0 L 42.07500076293945 16.82999992370605 L 84.15000152587891 0" fill="none" stroke="#21899c" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(15.5, 223.07)" d="M 0 56.42999649047852 L 0 0" fill="none" stroke="#21899c" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 99.0,
                  height: 99.0,
                ),
              ),

              //right side background design. I use a svg image here
              Positioned(
                right: -52,
                top: 45.0,
                child: SvgPicture.string(
                  // Group 3177
                  '<svg viewBox="288.0 45.0 139.0 139.0" ><path transform="translate(288.0, 45.0)" d="M 104.25 0 L 139 69.5 L 104.25 139 L 34.74999618530273 139 L 0 69.5 L 34.75000762939453 0 Z" fill="none" stroke="#21899c" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(298.42, 80.45)" d="M 0 0 L 59.07500076293945 23.63000106811523 L 118.1500015258789 0" fill="none" stroke="#21899c" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(357.5, 104.07)" d="M 0 79.22999572753906 L 0 0" fill="none" stroke="#21899c" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 139.0,
                  height: 139.0,
                ),
              ),

              //content ui
              Positioned(
                top: 8.0,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 38, right: 38),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              //email and password TextField here
                              // reTextField(
                              //     "Овог", Icons.supervised_user_circle, false),
                              Container(
                                child: TextFormField(
                                  cursorColor: Colors.black87,
                                  obscureText: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                        Icons.supervised_user_circle,
                                        color: Colors.black54),
                                    labelText: 'Таны овог',
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
                                    print("asuult===" + value.toString());
                                    setState(() {
                                      _lastName = value;
                                    });
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),

                              const SizedBox(height: 10),
                              // reTextField(
                              //     "Нэр", Icons.supervised_user_circle, true),
                              Container(
                                child: TextFormField(
                                  cursorColor: Colors.black87,
                                  obscureText: false,
                                  autocorrect: false,
                                  // keyboardType: TextInputType.,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                        Icons.supervised_user_circle,
                                        color: Colors.black54),
                                    labelText: 'Таны нэр',
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
                                    setState(() {
                                      _firstName = value;
                                    });
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 60,
                                // margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 3.0,
                                      style: BorderStyle.solid),
                                ),

                                child: TextFormField(
                                  cursorColor: Colors.black87,
                                  obscureText: false,
                                  autocorrect: false,
                                  // keyboardType: TextInputType.,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email,
                                        color: Colors.black54),
                                    labelText: 'Таны и-мэйл',
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
                                    _email = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // reTextField("утас", Icons.call, false),
                              Container(
                                height: 60,
                                // margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 3.0,
                                      style: BorderStyle.solid),
                                ),
                                child: TextFormField(
                                  cursorColor: Colors.black87,
                                  obscureText: false,
                                  autocorrect: false,
                                  // keyboardType: TextInputType.,
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.call, color: Colors.black54),
                                    labelText: 'Таны утасны дугаар',
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
                                    _phone = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 60,
                                // margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(32),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 3.0,
                                      style: BorderStyle.solid),
                                ),
                                child: TextFormField(
                                  obscureText: true,
                                  cursorColor: Colors.black87,

                                  // keyboardType: TextInputType.,
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.black54),
                                    labelText: 'Таны нууц үг',
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
                                    _pwd = value;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                ),
                              ),
                              SizedBox(height: 10),
                              // reTextField("Нууц үг давтах", Icons.lock, true),
                              Container(
                                height: 60,
                                // margin: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                      color: Colors.white,
                                      width: 3.0,
                                      style: BorderStyle.solid),
                                ),

                                child: TextFormField(
                                  cursorColor: Colors.black87,
                                  obscureText: true,
                                  autocorrect: false,
                                  // keyboardType: TextInputType.,
                                  decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.black54),
                                    labelText: 'Нууц үг давтах',
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
                                    _repwd = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              SizedBox(height: 10),

                              DropdownButtonHideUnderline(
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
                                          'Таны эрх',
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
                                  value: Urole,
                                  onChanged: (value) {
                                    setState(() {
                                      Urole = value as String;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 14,
                                  buttonHeight: 55,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 18, right: 18),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Colors.blueGrey.shade50,
                                  ),
                                  buttonElevation: 2,
                                  itemHeight: 40,
                                  itemPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  dropdownMaxHeight: 200,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blueGrey.shade50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //sign in button & continue with text here
                        Expanded(
                          flex: 2,
                          child: Column(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              // ignore: prefer_const_constructors
                              // Button(50, double.infinity, "Бүртгүүлэх",
                              //     Colors.teal, Colors.white, _signUp, null),

                              SizedBox(
                                height: 50,
                                width: 350,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.teal,
                                    onPrimary: Colors.white, // foreground
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      loading = true;
                                      _signUp();
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      loading
                                          ? CircularProgressIndicator(
                                              semanticsLabel:
                                                  'Linear progress indicator',
                                            )
                                          : SizedBox(),
                                      Text(
                                        "Бүртгүүлэх",
                                        style: const TextStyle(fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // signInSingUpButton(context, false, () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => const Home(),
                              //     ),
                              //   );
                              // }),

                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),

                        //footer section. google, facebook button and sign up text here
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
