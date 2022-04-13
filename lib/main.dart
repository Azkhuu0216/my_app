import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/home.dart';
import 'package:my_app/signIn.dart';
import 'package:my_app/signup.dart';
import 'splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashScreen(),
        '/signIn': (context) => const SignIn(),
        '/home': (context) => const Home(),
        '/signUp': (context) => const SignUp(),
      },
    );
  }
}
