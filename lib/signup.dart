import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/home.dart';
import 'common/reuseable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController repasswordController = TextEditingController();

    CollectionReference users =
        FirebaseFirestore.instance.collection('azaa1234');
    Future<void> addUser() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lastname', lastNameController.text);
      prefs.setString('firstname', firstNameController.text);
      prefs.setString('phone', phoneController.text);
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
      prefs.setString('repassword', repasswordController.text);
      // Call the user's CollectionReference to add a new user
      return users
          // .doc("user")
          .add({
            'lastname': _lastName,
            'firstname': _firstName,
            'phone': _phone,
            'email': _email,
            'repass': _repwd
          })
          .then((value) => (print("User Added")))
          .catchError((error) => print("Failed to add user: $error"));
    }

    void _signUp() async {
      if (_email == "") {
        //TODO:Real singin code will be here
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Та и-мэйлээ оруулна уу!",
          ),
        );
      } else if (_pwd == "") {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Та нууц үгээ оруулна уу!",
          ),
        );
      } else if (_pwd != _repwd) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Нууц үг таарахгүй байна!",
          ),
        );
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
                        //email and password TextField here
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              // reTextField(
                              //     "Овог", Icons.supervised_user_circle, false),
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
                                  controller: lastNameController,
                                  cursorColor: Colors.black87,
                                  obscureText: false,
                                  autocorrect: true,
                                  // keyboardType: TextInputType.,
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
                                    _lastName = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // reTextField(
                              //     "Нэр", Icons.supervised_user_circle, true),
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
                                  controller: firstNameController,
                                  cursorColor: Colors.black87,
                                  obscureText: false,
                                  autocorrect: true,
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
                                    _firstName = value;
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
                                  controller: emailController,
                                  cursorColor: Colors.black87,
                                  obscureText: false,
                                  autocorrect: true,
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
                                  controller: phoneController,
                                  cursorColor: Colors.black87,
                                  obscureText: false,
                                  autocorrect: true,
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
                                  controller: passwordController,
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
                                  controller: repasswordController,
                                  cursorColor: Colors.black87,
                                  obscureText: true,
                                  autocorrect: true,
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
                              const SizedBox(
                                height: 35,
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
                              Button(50, 300, "Бүртгүүлэх", Colors.teal,
                                  Colors.white, _signUp, null),

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
