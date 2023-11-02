import 'dart:typed_data';
import 'package:chats_app/src/apis/firebase_provider.dart';
import 'package:chats_app/src/service/media_service.dart';
import 'package:flutter/material.dart';

class ChatTextField extends StatefulWidget {
  ChatTextField({Key? key,required this.reciverId}) : super(key: key);
  String reciverId;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  TextEditingController messageController = TextEditingController();
  Uint8List? file;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
  }
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: messageController,
            decoration: InputDecoration(
              hintText: "Add Message",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        CircleAvatar(
          child: IconButton(
            onPressed: () => _sendText(context),
            icon: Icon(Icons.send),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        CircleAvatar(
          child: IconButton(
            onPressed: () => _sendImage(context),
            icon: Icon(Icons.camera_alt),
          ),
        ),
      ],
    );
  }
  Future<void> _sendImage(BuildContext context)async{
    final pickedImage = await MediaService.pickImage();
    setState(() {
      file = pickedImage;
    });
    if(file != null){
      await FirebaseProvider.addImageMessage(
        reciverId: widget.reciverId,
        file: file!,
      );
    }
  }

  Future<void> _sendText(BuildContext context)async{
    if(messageController.text.isNotEmpty){
      await FirebaseProvider.addTextMessage(
        content: messageController.text,
        reciverId: widget.reciverId,
      );
      messageController.clear();
      FocusScope.of(context).unfocus();
    }
    FocusScope.of(context).unfocus();
  }
}

