import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../model/user_modell.dart';

class FirebaseProvider with ChangeNotifier{
  final firestore = FirebaseFirestore.instance;
  List<UserModel> users =[];
  UserModel? user;


  List<UserModel> getAllUser(){
    firestore
        .collection("users")
        // .orderBy("lastActive",descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users = users.docs
          .map((e) => UserModel.fromJson(e.data()))
          .toList();
      notifyListeners();
      print(users);
    });
    return users;
  }
}