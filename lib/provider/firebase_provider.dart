import 'package:chats_app/model/message_model.dart';
import 'package:chats_app/service/firebase_firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/user_modell.dart';

class FirebaseProvider with ChangeNotifier{
  final firestore = FirebaseFirestore.instance;
  static final auth = FirebaseAuth.instance;
  ScrollController scrollController = ScrollController();
  List<UserModel> users =[];
  UserModel? user;
  List<Message> messages = [];
  List<UserModel> search = [];

  List<UserModel> getAllUser(){
    firestore
        .collection("users")
        .orderBy("lastActive",descending: true)
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

  UserModel? getUserById(String userId){
    firestore
    .collection("users")
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user){
          this.user = UserModel.fromJson(user.data()!);
          notifyListeners();
    });
    return user;
  }

  List<Message> getMessage(String receiverId){
    firestore
    .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chat")
        .doc(receiverId)
        .collection("messages")
        .orderBy("sentTime",descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((message){
          this.messages = message
              .docs.map((doc) => Message.fromJson(doc.data()),
          ).toList();
          notifyListeners();
          scrollDown();
    });
    return messages;
  }
  void scrollDown() =>
      WidgetsBinding.instance.addPostFrameCallback((_){
        if(scrollController.hasClients){
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        }
      });

  Future<void> searchUser(String name)async{
    search = await FirebaseFirestoreService.searchUser(name);
    notifyListeners();
  }
}