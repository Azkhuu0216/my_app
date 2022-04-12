// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/common/reuseable_widget.dart';
import 'package:my_app/signup.dart';
import 'package:postgres/postgres.dart';
// import './common/input.dart';
import 'common/button.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  void sign() async {
    //TODO:Real Loging code will be here
    if (_email == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Анхаар!!!"),
            content: new Text("Та и-мэйлээ оруулна уу!"),
            actions: <Widget>[
              new ElevatedButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (_pwd == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Анхаар!!!"),
            content: new Text("Та нууц үгээ оруулна уу!"),
            actions: <Widget>[
              new ElevatedButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: _email, password: _pwd);
        if (user != null) {
          print("Success!");
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Амжилттай!!!"),
                backgroundColor: Colors.green,
                titleTextStyle: TextStyle(color: Colors.white),
              );
            },
          );
          Timer(const Duration(seconds: 5),
              () => Navigator.pushNamed(context, '/home'));
        } else {
          print("User is not found!");
        }
      } catch (e) {
        print("buruu!!!");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Анхаар!!!"),
              content: new Text("Таны и-мэйл эсвэл нууц үг буруу байна!"),
              actions: <Widget>[
                new ElevatedButton(
                  child: new Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        print(e);
      }
    }
  }

  String _email = "";
  String _pwd = "";
  final _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    print("completed");
    setState(() {
      getCurrentUser();
    });
    Firebase.initializeApp().whenComplete(() {});
  }

  void getCurrentUser() async {
    // if (_auth.currentUser != null) {
    //   return Home();
    // } else {
    //   return SignIn();
    // }

    // if (_auth.currentUser != null) {
    //  Navigator.pushNamed(context, '/home');
    // }

    // if (currentUser != null) {
    //   Navigator.pushNamed(context, '/home_screen');
    //   print(currentUser!.email);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //logo section
                        const SizedBox(
                          height: 66,
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 70,
                                backgroundImage:
                                    AssetImage("assets/images/logo.png"),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              richText(23.12),
                            ],
                          ),
                        ),

                        //email and password TextField here
                        Expanded(
                          flex: 0,
                          child: Column(
                            children: [
                              // reTextField("И-мэйлээ оруулна уу", Icons.email,
                              //     false, onChanged),

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
                              // reTextField("Нууц үгээ оруулна уу", Icons.key,
                              //     true, _pwd),

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
                              buildRemember(size),
                              const SizedBox(
                                height: 36,
                              ),
                              Button(50, 350, "Нэвтрэх", Colors.teal,
                                  Colors.white, sign, Icons.login),

                              const SizedBox(
                                height: 16,
                              ),
                              buildContinueText(),
                            ],
                          ),
                        ),

                        //footer section. google, facebook button and sign up text here
                        Expanded(
                          flex: 6,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              signInGoogleFacebookButton(size),
                              const SizedBox(
                                height: 16,
                              ),
                              signOption()
                            ],
                          ),
                        ),
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

  // ignore: non_constant_identifier_names

  Widget richText(double fontSize) {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: 23.12,
          color: const Color(0xFF4DA1B0),
          letterSpacing: 1.999999953855673,
        ),
        children: const [
          TextSpan(
            text: 'Химийн',
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'ЭЕШ',
            style: TextStyle(
              color: Color(0xFFFE9879),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRemember(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Icon(
            Icons.check_box,
            color: Colors.teal,
          ),
        ),
        const SizedBox(
          width: 13,
        ),
        Text(
          'Намайг сана',
          style: GoogleFonts.inter(
            fontSize: 14.0,
            color: Colors.teal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget buildContinueText() {
    return Row(
      children: <Widget>[
        const Expanded(
            child: Divider(
          color: Color(0xFF4DA1B0),
        )),
        Expanded(
          child: Text(
            'Or Continue with',
            style: GoogleFonts.inter(
              fontSize: 12.0,
              color: const Color(0xFF4DA1B0),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Expanded(
            child: Divider(
          color: Color(0xFF4DA1B0),
        )),
      ],
    );
  }

  Widget signInGoogleFacebookButton(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //sign in google button
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUp()),
          ),
          child: Container(
            alignment: Alignment.center,
            width: size.width / 2.8,
            height: size.height / 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                width: 1.0,
                color: const Color(0xFF4DA1B0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //icon of google
                SvgPicture.string(
                  '<svg viewBox="63.54 641.54 22.92 22.92" ><path transform="translate(63.54, 641.54)" d="M 22.6936149597168 9.214142799377441 L 21.77065277099609 9.214142799377441 L 21.77065277099609 9.166590690612793 L 11.45823860168457 9.166590690612793 L 11.45823860168457 13.74988651275635 L 17.93386268615723 13.74988651275635 C 16.98913192749023 16.41793632507324 14.45055770874023 18.33318138122559 11.45823860168457 18.33318138122559 C 7.661551475524902 18.33318138122559 4.583295345306396 15.25492572784424 4.583295345306396 11.45823860168457 C 4.583295345306396 7.661551475524902 7.661551475524902 4.583295345306396 11.45823860168457 4.583295345306396 C 13.21077632904053 4.583295345306396 14.80519008636475 5.244435787200928 16.01918983459473 6.324374675750732 L 19.26015281677246 3.083411931991577 C 17.21371269226074 1.176188230514526 14.47633838653564 0 11.45823860168457 0 C 5.130426406860352 0 0 5.130426406860352 0 11.45823860168457 C 0 17.78605079650879 5.130426406860352 22.91647720336914 11.45823860168457 22.91647720336914 C 17.78605079650879 22.91647720336914 22.91647720336914 17.78605079650879 22.91647720336914 11.45823860168457 C 22.91647720336914 10.68996334075928 22.83741569519043 9.940022468566895 22.6936149597168 9.214142799377441 Z" fill="#F7AF0E" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(64.86, 641.54)" d="M 0 6.125000953674316 L 3.764603137969971 8.885863304138184 C 4.78324031829834 6.363905429840088 7.250198841094971 4.583294868469238 10.13710117340088 4.583294868469238 C 11.88963890075684 4.583294868469238 13.48405265808105 5.244434833526611 14.69805240631104 6.324373722076416 L 17.93901443481445 3.083411693572998 C 15.89257335662842 1.176188111305237 13.15520095825195 0 10.13710117340088 0 C 5.735992908477783 0 1.919254422187805 2.484718799591064 0 6.125000953674316 Z" fill="red" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(64.8, 655.32)" d="M 10.20069408416748 9.135653495788574 C 13.16035556793213 9.135653495788574 15.8496036529541 8.003005981445312 17.88286781311035 6.161093711853027 L 14.33654403686523 3.160181760787964 C 13.14749050140381 4.064460277557373 11.69453620910645 4.553541660308838 10.20069408416748 4.55235767364502 C 7.220407009124756 4.55235767364502 4.689855575561523 2.6520094871521 3.736530303955078 0 L 0 2.878881216049194 C 1.896337866783142 6.589632034301758 5.747450828552246 9.135653495788574 10.20069408416748 9.135653495788574 Z" fill="#2D9C41" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(75.0, 650.71)" d="M 11.23537635803223 0.04755179211497307 L 10.31241607666016 0.04755179211497307 L 10.31241607666016 0 L 0 0 L 0 4.583295345306396 L 6.475625038146973 4.583295345306396 C 6.023715496063232 5.853105068206787 5.209692478179932 6.962699413299561 4.134132385253906 7.774986743927002 L 4.135851383209229 7.773841857910156 L 7.682177066802979 10.77475357055664 C 7.431241512298584 11.00277233123779 11.45823955535889 8.020766258239746 11.45823955535889 2.291647672653198 C 11.45823955535889 1.523372769355774 11.37917804718018 0.773431122303009 11.23537635803223 0.04755179211497307 Z" fill="#346CF0" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 22.92,
                  height: 22.92,
                ),
                const SizedBox(
                  width: 16,
                ),
                //google txt
                Text(
                  'Google',
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: const Color(0xFF4DA1B0),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),

        //sign in facebook button
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUp(),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            width: size.width / 2.8,
            height: size.height / 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                width: 1.0,
                color: const Color(0xFF4DA1B0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //facebook icon
                SvgPicture.string(
                  '<svg viewBox="0.3 0.27 22.44 22.44" ><defs><linearGradient id="gradient" x1="0.500031" y1="0.970054" x2="0.500031" y2="0.0"><stop offset="0.0" stop-color="#175DEE"  /><stop offset="1.0" stop-color="#175DEE"  /></linearGradient></defs><path transform="translate(0.3, 0.27)" d="M 9.369577407836914 22.32988739013672 C 4.039577960968018 21.3760986328125 0 16.77546882629395 0 11.22104930877686 C 0 5.049472332000732 5.049472808837891 0 11.22105026245117 0 C 17.39262962341309 0 22.44210624694824 5.049472332000732 22.44210624694824 11.22104930877686 C 22.44210624694824 16.77546882629395 18.40252304077148 21.3760986328125 13.07252502441406 22.32988739013672 L 12.45536518096924 21.8249397277832 L 9.986735343933105 21.8249397277832 L 9.369577407836914 22.32988739013672 Z" fill="url(#gradient)" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(6.93, 4.65)" d="M 8.976840972900391 9.986734390258789 L 9.481786727905273 6.844839572906494 L 6.508208274841309 6.844839572906494 L 6.508208274841309 4.656734466552734 C 6.508208274841309 3.759051322937012 6.844841003417969 3.085787773132324 8.191367149353027 3.085787773132324 L 9.650103569030762 3.085787773132324 L 9.650103569030762 0.2244201600551605 C 8.864629745483398 0.1122027561068535 7.966946125030518 0 7.181471347808838 0 C 4.600629806518555 0 2.805262804031372 1.570946097373962 2.805262804031372 4.376209735870361 L 2.805262804031372 6.844839572906494 L 0 6.844839572906494 L 0 9.986734390258789 L 2.805262804031372 9.986734390258789 L 2.805262804031372 17.8975715637207 C 3.422420024871826 18.00978851318359 4.039577484130859 18.06587600708008 4.656735897064209 18.06587600708008 C 5.273893356323242 18.06587600708008 5.89105224609375 18.009765625 6.508208274841309 17.8975715637207 L 6.508208274841309 9.986734390258789 L 8.976840972900391 9.986734390258789 Z" fill="#ffffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                  width: 22.44,
                  height: 22.44,
                ),
                const SizedBox(
                  width: 16,
                ),

                //facebook txt
                Text(
                  'Facebook',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14.0,
                    color: const Color(0xFF4DA1B0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row signOption() {
    // ignore: prefer_const_literals_to_create_immutables
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        "Та бүртгэлтэй юу?",
        style: TextStyle(color: Colors.teal),
      ),
      const SizedBox(
        width: 10,
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const SignUp()));
        },
        child: const Text(
          "Бүртгүүлэх",
          style:
              TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),
        ),
      )
    ]);
  }
}
