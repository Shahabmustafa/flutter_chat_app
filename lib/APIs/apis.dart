import 'dart:io';

import 'package:chats_app/model/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class APIs{
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  static User get user => auth.currentUser!;

  static late ChatUser me;

  static Future<bool> userExists()async{
    return (await firestore.
    collection('user').
    doc(user.uid)
        .get()).exists;
  }

  static Future<void> getSelfInfo()async{
    await firestore.collection('user').doc(user.uid).get().then((user)async{
      if(user.exists){
        me = ChatUser.fromJson(user.data()!);
      }else{
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  static Future<void> createUser()async{
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
      id: user.uid,
      emaill: user.email,
      image: user.photoURL,
      name: user.displayName,
      about: "I am Flutter Developer",
      createAt: time,
      isOnline: false,
      lastActiive: time,
      pushToken: "",
    );
    return await firestore
        .collection('user')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Future<void> updateUserInfo()async{
    await firestore.collection('user')
        .doc(user.uid)
        .update({
      "name" : me.name,
      "about" : me.about,
    });
  }


  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(){
    return firestore.collection("user").where('id',isNotEqualTo: user.uid).snapshots();
  }

  static Future<void> updateProfilePicture(File file)async{
    final ext = file.path.split(".").last;
    final ref = storage.ref().child("profile_picture${user.uid}.${ext}");
    await ref.putFile(file , SettableMetadata(contentType: "image/$ext")).then((p0){
      print("Data Transferred ${p0.bytesTransferred / 1000} kb");
    });
    me.image = await ref.getDownloadURL();
    firestore.collection("user").doc(user.uid).update({
      "image" : me.image,
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessage(){
    return firestore.collection("user").snapshots();
  }
}