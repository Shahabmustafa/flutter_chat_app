import 'package:chats_app/src/apis/firebase_provider.dart';
import 'package:chats_app/src/view/auth/login_screen.dart';
import 'package:chats_app/src/view/auth/sign_up_screen.dart';
import 'package:chats_app/src/view/splash/splah_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FirebaseProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hello Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        home: SplashPage(),
      ),
    );
  }
}
