import 'package:chats_app/model/message_model.dart';
import 'package:chats_app/provider/firebase_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'message_bubble_widget.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({Key? key,required this.receiverId}) : super(key: key);
  String receiverId;
  final message = [
    Message(
        senderId: "Y2n6Ml9gcBS1wJc6rf4F2OOWu8H2",
        receiverId: "2",
        content: "Hello",
        sentTime: DateTime.now(),
        messageType: MessageType.text,
    ),
    Message(
        senderId: "2",
        receiverId: "Y2n6Ml9gcBS1wJc6rf4F2OOWu8H2",
        content: "Hello",
        sentTime: DateTime.now(),
        messageType: MessageType.text,
    ),
    Message(
      senderId: "Y2n6Ml9gcBS1wJc6rf4F2OOWu8H2",
      receiverId: "2",
      content: "How are you",
      sentTime: DateTime.now(),
      messageType: MessageType.text,
    ),
    Message(
      senderId: "2",
      receiverId: "Y2n6Ml9gcBS1wJc6rf4F2OOWu8H2",
      content: "I am Good and You",
      sentTime: DateTime.now(),
      messageType: MessageType.text,
    ),
    Message(
      senderId: "Y2n6Ml9gcBS1wJc6rf4F2OOWu8H2",
      receiverId: "2",
      content: "I am well",
      sentTime: DateTime.now(),
      messageType: MessageType.text,
    ),
    Message(
      senderId: "2",
      receiverId: "Y2n6Ml9gcBS1wJc6rf4F2OOWu8H2",
      content: "What are you doing",
      sentTime: DateTime.now(),
      messageType: MessageType.text,
    ),
    Message(
      senderId: "Y2n6Ml9gcBS1wJc6rf4F2OOWu8H2",
      receiverId: "2",
      content: "I am Working",
      sentTime: DateTime.now(),
      messageType: MessageType.text,
    ),
    Message(
      senderId: "2",
      receiverId: "Y2n6Ml9gcBS1wJc6rf4F2OOWu8H2",
      content: "https://i.pinimg.com/474x/ae/2d/65/ae2d65d73a98f127fdc0b320b2482c8b.jpg",
      sentTime: DateTime.now(),
      messageType: MessageType.image,
    ),
    Message(
      senderId: "Y2n6Ml9gcBS1wJc6rf4F2OOWu8H2",
      receiverId: "2",
      content: "https://i.pinimg.com/474x/43/c3/8a/43c38af968d3b8be468d64837b32b3fe.jpg",
      sentTime: DateTime.now(),
      messageType: MessageType.image,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
        builder: (context,value,child){
          return value.messages.isEmpty ? Expanded(
              child: Center(child: Text("say Hello"))
          ) : ListView.builder(
              controller: Provider.of<FirebaseProvider>(context,listen: false).scrollController,
              itemCount: value.messages.length,
              itemBuilder: (context,index){
                final isTextMessage = value.messages[index].messageType == MessageType.text;
                final isMe = receiverId != value.messages[index].senderId;
                return isTextMessage ?
                MessageBubble(
                  isImage: false,
                  isMe: isMe,
                  message: value.messages[index],
                ) :
                MessageBubble(
                  isImage: true,
                  isMe: isMe,
                  message: value.messages[index],
                );
              }
          );
        }
    );
  }
}
