import 'package:flutter/material.dart';
import '../../Model/user_model.dart';
import '../../shared/chat_message_widget.dart';
import '../../shared/text_form_field.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key,required this.user}) : super(key: key);
  UserModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _builderAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ChatMessages(
              reciverId: widget.user.uid.toString(),
            ),
            ChatTextField(
              reciverId: widget.user.uid.toString(),
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
    title: ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.user.image.toString()),
      ),
      title: Text(widget.user.name.toString()),
      subtitle: Text(widget.user.isOnline ? "Online" : "offline".toString(),style: TextStyle(
        color: widget.user.isOnline ? Colors.green : Colors.grey,
      ),),
    ),
  );
}







