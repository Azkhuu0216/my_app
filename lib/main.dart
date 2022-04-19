import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/home/home.dart';
import 'package:my_app/provider/mainProvider.dart';
import 'package:my_app/auth/signIn.dart';
import 'package:my_app/auth/signup.dart';
import 'package:provider/provider.dart';
import 'auth/splashscreen.dart';

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
    var currentUser = FirebaseAuth.instance.currentUser;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (ctx) => MainProvider(0, false, "", currentUser!.uid, 0)),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: SplashScreen(),
          initialRoute: "/",
          routes: {
            '/': (context) => const SplashScreen(),
            '/signIn': (context) => const SignIn(),
            '/home': (context) => const Home(),
            '/signUp': (context) => const SignUp(),
          },
        ));
  }
}
