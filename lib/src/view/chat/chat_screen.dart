import 'package:chats_app/src/apis/firebase_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/user_model.dart';
import '../../shared/chat_message_widget.dart';
import '../../shared/text_form_field.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key,required this.userId}) : super(key: key);
  final String userId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FirebaseProvider>(context,listen: false)
      ..getUserById(widget.userId)
      ..getMessages(widget.userId);

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _builderAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ChatMessages(
              reciverId: widget.userId,
            ),
            ChatTextField(
              reciverId: widget.userId,
            ),
          ],
        ),
      ),
    );
  }
  AppBar _builderAppBar() => AppBar(
    elevation: 0,
    foregroundColor: Colors.black,
    backgroundColor: Colors.transparent,
    title: Consumer<FirebaseProvider>(
      builder: (context,value,child) =>
          value.user != null ?
          ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(value.user!.image.toString()),
              ),
              title: Text(value.user!.name.toString()),
              subtitle: Text(value.user!.isOnline ? "Online" : "offline".toString(),style: TextStyle(color: value.user!.isOnline  ? Colors.green : Colors.grey,
    ),)) : SizedBox(),
    ),
  );
}







