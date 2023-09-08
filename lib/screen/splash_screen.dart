import 'dart:async';
import 'dart:developer';

import 'package:chats_app/APIs/apis.dart';
import 'package:chats_app/screen/auth/login_screen.dart';
import 'package:chats_app/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
         systemNavigationBarColor: Colors.white,
        ),
      );
      if(APIs.auth.currentUser != null){
        log("${APIs.auth.currentUser}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }
  Widget build(BuildContext context) {
    final respnse = MediaQuery.of(context).size * 1;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: "tag-1",
            child: Center(
              child: Image.asset(
                "images/chat.png",
                height: respnse.height * 0.4,
                width: respnse.width * 0.4,
              ),
            ),
          ),
          Text(
            "Hello Chat",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
