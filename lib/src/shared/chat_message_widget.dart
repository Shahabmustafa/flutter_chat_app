

import 'package:chats_app/src/apis/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/message_model.dart';
import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({Key? key,required this.reciverId}) : super(key: key);
  String reciverId;

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
        builder: (context,value,child) =>
        value.message.isEmpty ? Text("say Hello") : Expanded(
          child: ListView.builder(
            itemCount: value.message.length,
            itemBuilder: (context,index){
              final isMe = reciverId != value.message[index].sendId;
              final isTextMessage = value.message[index].messageType == MessageType.text;
              return isTextMessage ?
              MessageBubble(
                isMe: isMe,
                message: value.message[index],
                isImage: false,
              ) :
              MessageBubble(
                isMe: isMe,
                message: value.message[index],
                isImage: true,
              );
            },
          ),
        ),
    );
  }
}
