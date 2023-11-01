

import 'package:flutter/material.dart';

import '../Model/message_model.dart';
import 'message_bubble.dart';

class ChatMessages extends StatelessWidget {
  ChatMessages({Key? key,required this.reciverId}) : super(key: key);
  String reciverId;
  final message = [
    Message(
      sendId: "2",
      reciverId: "VHRWMQovZQRwf6USyKg9p6fLnlP2",
      content: "hello",
      sentTime: DateTime.now(),
      messageType: MessageType.text,
    ),
    Message(
      sendId: "VHRWMQovZQRwf6USyKg9p6fLnlP2",
      reciverId: "2",
      content: "hello",
      sentTime: DateTime.now(),
      messageType: MessageType.text,
    ),
    Message(
      sendId: "2",
      reciverId: "VHRWMQovZQRwf6USyKg9p6fLnlP2",
      content: "hello",
      sentTime: DateTime.now(),
      messageType: MessageType.text,
    ),
    Message(
      sendId: "VHRWMQovZQRwf6USyKg9p6fLnlP2",
      reciverId: "2",
      content: "https://i.pinimg.com/474x/ad/73/1c/ad731cd0da0641bb16090f25778ef0fd.jpg",
      sentTime: DateTime.now(),
      messageType: MessageType.image,
    ),
    Message(
      sendId: "2",
      reciverId: "VHRWMQovZQRwf6USyKg9p6fLnlP2",
      content: "hello how are you",
      sentTime: DateTime.now(),
      messageType: MessageType.text,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: message.length,
        itemBuilder: (context,index){
          final isMe = reciverId != message[index].sendId;
          final isTextMessage = message[index].messageType == MessageType.text;
          return isTextMessage ?
          MessageBubble(
            isMe: isMe,
            message: message[index],
            isImage: false,
          ) :
          MessageBubble(
            isMe: isMe,
            message: message[index],
            isImage: true,
          );
        },
      ),
    );
  }
}
