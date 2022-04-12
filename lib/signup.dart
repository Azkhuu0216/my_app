import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/home.dart';
import 'common/reuseable_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController lastnameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // void _signUp() {
    //   FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(
    //           email: emailController.text, password: passController.text)
    //       .then((value) => {
    //             print("Create new account"),
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) => const Home(),
    //               ),
    //             ),
    //           })
    //       .onError(
    //         (error, stackTrace) => {
    //           print("Error ${error.toString()}"),
    //         },
    //       );
    // }

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
                              reTextField("Овог", Icons.supervised_user_circle,
                                  false, emailController),
                              const SizedBox(height: 10),
                              reTextField("Нэр", Icons.supervised_user_circle,
                                  true, passController),
                              const SizedBox(height: 10),
                              reTextField("и-мэйл", Icons.email, false,
                                  emailController),
                              const SizedBox(height: 10),
                              reTextField(
                                  "утас", Icons.call, false, emailController),
                              const SizedBox(height: 10),
                              reTextField(
                                  "Нууц үг", Icons.key, true, passController),
                              SizedBox(height: 10),
                              reTextField("Нууц үг давтах", Icons.key, true,
                                  passController),
                              SizedBox(height: 10),
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
                              // Button(
                              //   height: 50,
                              //   width: 300,
                              //   title: "Бүртгүүлэх",
                              //   color: Colors.teal,
                              //   color1: Colors.white,
                              //   onPress: _signUp,
                              // ),
                              signInSingUpButton(context, false, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              }),
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
