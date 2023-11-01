import 'package:chats_app/src/Model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../Model/user_model.dart';

class FirebaseProvider with ChangeNotifier{
  List<UserModel> users = [];


  List<UserModel> getAllUsers(){
    FirebaseFirestore.instance.collection("user").snapshots(includeMetadataChanges: true).listen((users){
      this.users = users.docs.map((doc) =>  UserModel.fromJson(doc.data())
      ).toList();
      notifyListeners();
    });
    return users;
  }

  static Future<void> addTextMessage({required String content,required String reciverId})async{
    final user = FirebaseAuth.instance.currentUser;
    final message = Message(
        sendId: user!.uid,
        reciverId: reciverId,
        content: content,
        sentTime: DateTime.now(),
        messageType: MessageType.text
    );
    await _addMessagetoChat(reciverId,message);
  }

  static Future<void> _addMessagetoChat(String reciverId,Message message)async{
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .collection("chat")
        .doc(reciverId)
        .collection("messages")
        .add(message.toJson());

    await FirebaseFirestore.instance
        .collection("user")
        .doc(reciverId)
        .collection("chat")
        .doc(user.uid)
        .collection("messages")
        .add(message.toJson());
  }
}