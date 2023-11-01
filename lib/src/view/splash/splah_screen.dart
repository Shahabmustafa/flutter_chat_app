import 'dart:async';

import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  isLogin(){
    Timer(Duration(seconds: 3), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Hello Chat",
            ),
          ),
          Image.asset("images/chat.png",height: 100,width: 100,)
        ],
      ),
    );
  }
}
