import 'package:chats_app/src/Model/user_model.dart';
import 'package:chats_app/src/apis/firebase_provider.dart';
import 'package:chats_app/src/view/chat/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance.currentUser;
  final signOut = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FirebaseProvider>(context,listen: false).getAllUsers();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: (){
                signOut.signOut().then((value){
                  Navigator.pop(context);
                });
              },
              icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Consumer<FirebaseProvider>(
        builder: (context,value,child) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (context,index){
              return SizedBox(
                height: 5,
              );
            },
            itemCount: value.users.length,
            itemBuilder: (context,index){
              return value.users[index].uid != auth!.uid ? UserItem(user: value.users[index],) : SizedBox();
            },
          );
        }
      ),
    );
  }
}

class UserItem extends StatefulWidget {
  UserItem({Key? key,required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<UserItem> createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("${widget.user.image}"),
          ),
          CircleAvatar(
            radius: 5,
            backgroundColor: widget.user.isOnline ? Colors.green : Colors.grey,
          ),
        ],
      ),
      title: Text("${widget.user.name}"),
      subtitle: Text("${widget.user.email}"),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(userId: widget.user.uid.toString(),)));
      },
    );
  }
}

