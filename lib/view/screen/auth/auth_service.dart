import 'dart:async';
import 'package:chats_app/model/user_modell.dart';
import 'package:chats_app/view/screen/auth/login_screen.dart';
import 'package:chats_app/view/screen/auth/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chats_screen.dart';


class AuthService{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // login account only update user online turn on
  isLogin(BuildContext context,String email,String password)async{
    User? user = auth.currentUser;
    try{
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value){
        firestore.doc(user!.uid).update({
          "isOnline" : true,
          "lastActive" : DateTime.now(),
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
      }).onError((error, stackTrace){
        print(error.toString());
      });
    }catch(e){
      print(e);
    }
  }

  // sign account and user data store in firstore
  isSignUp(BuildContext context,String userName,String email,String password)async{
    User? user = auth.currentUser;
    try{
      await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      ).then((value){
        firestore.collection("users").doc(user!.uid).set(
            UserModel(
              uid: user.uid,
              name: userName,
              email: user.email,
              image: "https://i.pinimg.com/474x/22/c6/4d/22c64d99a15c53f031dce89da274901a.jpg",
              isOnline: true,
              lastActive: DateTime.now(),
            ) as Map<String, dynamic>,
        ).then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsPage()));
        }).onError((error, stackTrace){
          print('Not Save');
        });
      });
    }catch(e){

    }
  }

  // sign out account only update user online turn off
  isSignOut(BuildContext context)async{
    User? user = auth.currentUser;
    await auth.signOut().then((value){
      firestore.collection('user').doc(user!.uid).update({
        "isOnline" : false,
      });
    });
  }

  // account delete and the user delete data to firestore
  accountDelete(BuildContext context)async{
    User? user = auth.currentUser;
    await user!.delete().then((value){
      firestore.doc(user.uid).delete();
    });
  }

  SplashServer(BuildContext context){
    User? user = auth.currentUser;
    if(user != null){
      Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsPage()));
      });
    }else{
      Timer(Duration(seconds: 3), () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    }
  }
}