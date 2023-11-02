import 'package:chats_app/src/Model/message_model.dart';
import 'package:chats_app/src/service/firebase_storage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../Model/user_model.dart';

class FirebaseProvider with ChangeNotifier{
  List<UserModel> users = [];
  UserModel? user;
  List<Message> message = [];


  List<UserModel> getAllUsers(){
    FirebaseFirestore.instance.collection("user").snapshots(includeMetadataChanges: true).listen((users){
      this.users = users.docs.map((doc) =>  UserModel.fromJson(doc.data())
      ).toList();
      notifyListeners();
    });
    return users;
  }

  UserModel? getUserById(String userId){
    FirebaseFirestore.instance
        .collection("user")
        .doc(userId)
        .snapshots(includeMetadataChanges: true)
        .listen((user){
          this.user = UserModel.fromJson(user.data()!);
          notifyListeners();
    });
    return user;
  }

  List<Message> getMessages(String reciverId){
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("user")
        .doc(user!.uid)
        .collection('chat')
        .doc(reciverId)
        .collection("message")
        .orderBy('sentTime',descending: false)
        .snapshots(includeMetadataChanges: true)
        .listen((message){
          this.message = message.docs
              .map((doc) => Message.fromJson(doc.data())
          ).toList();
          notifyListeners();
    });
    return message;
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

  static Future<void> addImageMessage({required String reciverId,required Uint8List file})async{
    final user = FirebaseAuth.instance.currentUser;
    final image = await FirebaseStorageService.uploadImage(
        file,
        "image/chat/${DateTime.now()}",
    );
    final message = Message(
        sendId: user!.uid,
        reciverId: reciverId,
        content: image,
        sentTime: DateTime.now(),
        messageType: MessageType.image
    );
    await _addMessagetoChat(reciverId, message);
  }
}