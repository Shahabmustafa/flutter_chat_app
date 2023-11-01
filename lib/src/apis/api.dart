import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/chat/home_screen.dart';



class ApiService{
  final firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  get user => firebaseAuth.currentUser!.uid;

  login(BuildContext context,String email,String password)async{
    firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  signUp(BuildContext context,String email,String password,String userName)async{
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){
      _db.collection("user").doc(user).set({
        "uid" : user,
        "name" : userName,
        "email" : email,
        "isOnline" : false,
        "image" : "https://i.pinimg.com/474x/ad/73/1c/ad731cd0da0641bb16090f25778ef0fd.jpg",
        "lastActive" : "",
      }).then((value){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        print("add data");
      });
    });
  }
}