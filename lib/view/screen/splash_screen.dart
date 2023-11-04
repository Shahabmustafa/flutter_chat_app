import 'dart:async';

import 'package:chats_app/view/screen/auth/auth_service.dart';
import 'package:chats_app/view/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AuthService service  = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service.SplashServer(context);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
                "images/chat.png",
                height: 200,
                width: 200,
              ),
          ),
          Center(
            child: Text(
            "HELLO CHAT",
            style: GoogleFonts.acme(
                fontSize: 35,
            ),
          ),
          ),
        ],
      ),
    );
  }
}
