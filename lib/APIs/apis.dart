import 'package:chats_app/model/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs{
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers(){
    return firestore.collection("user").where('id',isNotEqualTo: user.uid).snapshots();
  }
}