import 'package:flutter/material.dart';
import '../Model/message_model.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({Key? key,required this.message,required this.isMe,required this.isImage}) : super(key: key);
  Message message;
  bool isMe;
  bool isImage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(top: 10,right: 10,left: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: isMe ?
          BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ) :
          BorderRadius.only(
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            isImage ?
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    image: NetworkImage(message.content),
                  fit: BoxFit.cover,
                ),
              ),
            ) :
            Text(message.content,style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
