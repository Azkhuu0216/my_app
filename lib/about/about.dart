import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common/input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../common/button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class About extends StatefulWidget {
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String lastname = '';
  String firstname = '';
  String phone = '';
  String email = '';

  final _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  // @override
  // void initState() {
  //   super.initState();
  //   print("completed");
  //   setState(() {
  //     // autoLogIn();
  //   });
  // }

  // void autoLogIn() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? lastName = prefs.getString('lastname');
  //   final String? firstName = prefs.getString('firstname');
  //   final String? Phone = prefs.getString('phone');
  //   final String? Email = prefs.getString('email');

  //   if (lastName != null &&
  //       firstName != null &&
  //       Phone != null &&
  //       Email != null) {
  //     setState(() {
  //       lastname = lastName;
  //       firstname = firstName;
  //       phone = Phone;
  //       email = Email;
  //     });
  //     return;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print(currentUser!.email);

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // ignore: non_constant_identifier_names

    Future<void> UpdateUser() async {
      return users.doc(currentUser!.uid).update({
        'lastname': lastname,
        'firstname': firstname,
        'phone': phone,
        'email': email,
      }).then(
        ((value) {
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message: "Амжилттай хадгалаа!!!",
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

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Expanded(
                              flex: 6,
                              child: Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: <Widget>[
                                  const CircleAvatar(
                                    radius: 90,
                                    backgroundImage: AssetImage(
                                        "assets/images/profile.jpeg"),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // const Input(
                                  //   placeholder: "${data['lastname']}",
                                  //   height: 50,
                                  //   icon: Icons.supervised_user_circle_sharp,
                                  // ),

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
                                      initialValue: "${data['lastname']}",
                                      cursorColor: Colors.black87,
                                      obscureText: false,
                                      autocorrect: true,
                                      // keyboardType: TextInputType.,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                            Icons.supervised_user_circle,
                                            color: Colors.black54),
                                        labelText: "Таны овог",
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
                                        lastname = value;
                                      },
                                      keyboardType: TextInputType.emailAddress,
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
                                      initialValue: "${data['firstname']}",
                                      cursorColor: Colors.black87,
                                      obscureText: false,
                                      autocorrect: true,
                                      // keyboardType: TextInputType.,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                            Icons.supervised_user_circle,
                                            color: Colors.black54),
                                        labelText: "Таны нэр",
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
                                        firstname = value;
                                      },
                                      keyboardType: TextInputType.emailAddress,
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
                                      initialValue: "${data['phone']}",
                                      cursorColor: Colors.black87,
                                      obscureText: false,
                                      autocorrect: true,
                                      // keyboardType: TextInputType.,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.call,
                                            color: Colors.black54),
                                        labelText: "Таны утасны дугаар",
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
                                        phone = value;
                                      },
                                      keyboardType: TextInputType.emailAddress,
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
                                      initialValue: "${data['email']}",
                                      cursorColor: Colors.black87,
                                      obscureText: false,
                                      autocorrect: true,
                                      // keyboardType: TextInputType.,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email,
                                            color: Colors.black54),
                                        labelText: "Таны и-мэйл",
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
                                        email = value;
                                      },
                                      keyboardType: TextInputType.emailAddress,
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
                          Button(50, 300, "Хадгалах", Colors.teal, Colors.white,
                              UpdateUser, null),
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
