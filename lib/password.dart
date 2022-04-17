import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/common/button.dart';
import 'package:my_app/common/input.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  String nowPassword = '';
  String newPassword = '';
  String reNewPassword = '';
  final _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('azaa1234');
    void _about() {
      Navigator.pop(context);
    }

    Future<void> UpdateUser() async {
      return users.doc(currentUser!.email).update({
        'repass': nowPassword,
      }).then(
        ((value) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Амжилттай солигдлоо!!!",
            ),
          );
        }),
      ).catchError(
        (error) => showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Амжилтгүй!!!",
          ),
        ),
      );
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
                    children: [
                      FutureBuilder<DocumentSnapshot>(
                          future: users.doc(currentUser!.email).get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }
                            if (snapshot.hasData && !snapshot.data!.exists) {
                              return Text("Document does not exist");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Expanded(
                                flex: 6,
                                child: Column(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: <Widget>[
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
                                        autocorrect: true,
                                        // keyboardType: TextInputType.,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.lock,
                                              color: Colors.black54),
                                          labelText: "Одоогийн нууц үг",
                                          labelStyle: const TextStyle(
                                              color: Colors.black54),
                                          filled: true,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: Colors.blueGrey.shade50,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none)),
                                        ),
                                        onChanged: (value) {
                                          nowPassword = value;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
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
                                        autocorrect: true,
                                        // keyboardType: TextInputType.,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.lock,
                                              color: Colors.black54),
                                          labelText: "Шинэ нууц үг",
                                          labelStyle: const TextStyle(
                                              color: Colors.black54),
                                          filled: true,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: Colors.blueGrey.shade50,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none)),
                                        ),
                                        onChanged: (value) {
                                          newPassword = value;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
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
                                        autocorrect: true,
                                        // keyboardType: TextInputType.,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.lock,
                                              color: Colors.black54),
                                          labelText: "Шинэ нууц үг давтах",
                                          labelStyle: const TextStyle(
                                              color: Colors.black54),
                                          filled: true,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          fillColor: Colors.blueGrey.shade50,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  width: 0,
                                                  style: BorderStyle.none)),
                                        ),
                                        onChanged: (value) {
                                          reNewPassword = value;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Text('loading');
                          }),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Button(50, 300, "Хадгалах", Colors.teal,
                                Colors.white, UpdateUser, null),
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
      ),
    );
  }
}
