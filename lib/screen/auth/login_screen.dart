import 'dart:io';
import 'dart:math';

import 'package:chats_app/APIs/apis.dart';
import 'package:chats_app/screen/home_screen.dart';
import 'package:chats_app/widget/custtom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../helper/dialogs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final respnse = MediaQuery.of(context).size * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Chat"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: "images/chat.png",
            child: Center(
                child: Image.asset(
                  "images/chat.png",
                  height: respnse.height * 0.4,
                  width: respnse.width * 0.4,
                ),
            ),
          ),
          CusttomButton(
            title: "Sign In With Google",
            imageUrl: "google.png",
            height: 60,
            width: 350,
            icons: Icons.flutter_dash,
            boxDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: Colors.black
              ),
            ),
            onTap: (){
              _handlingGoogle();
            },
          ),
        ],
      ),
    );
  }

  _handlingGoogle(){
    Dialogs.showProgressBar(context);
    signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if(user != null){
        print("\nuserAdditionalInfo : ${user.additionalUserInfo}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      if((await APIs.userExists())){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }else{
        await APIs.createUser().then((value){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        });
      }
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
   try{
     await InternetAddress.lookup("google.com");
     // Trigger the authentication flow
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

     // Obtain the auth details from the request
     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

     // Create a new credential
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth?.accessToken,
       idToken: googleAuth?.idToken,
     );

     // Once signed in, return the UserCredential
     return await APIs.auth.signInWithCredential(credential);
   }catch(e){
     Dialogs.showSnackbar(context, "Please Connect Your Device to Internet");
   }
  }
}
