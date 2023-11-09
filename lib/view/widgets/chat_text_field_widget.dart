import 'dart:typed_data';

import 'package:chats_app/service/firebase_storage_service.dart';
import 'package:chats_app/service/media_services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../service/firebase_firestore_services.dart';
import 'custem_text_field.dart';

class ChatTextField extends StatefulWidget {
  ChatTextField({Key? key,required this.receiverId}) : super(key: key);
  String receiverId;
  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  TextEditingController controller = TextEditingController();
  Uint8List? file;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: CustomTextField(
            hintText: "Aa....",
            prefixIcon: CupertinoIcons.link,
            suffixIcon: Icons.photo,
            controller: controller,
            onTap: (){
              _sendImage();
            },
          ),
        ),
        SizedBox(
          width: 20,
        ),
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => _sendMessage(context),
          child: CircleAvatar(
            child: Icon(Icons.send),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
  Future<void> _sendMessage(BuildContext context)async{
    if(controller.text.isNotEmpty){
      await FirebaseFirestoreService.addMessage(
        content: controller.text,
        receiverId: widget.receiverId,
      );
      controller.clear();
      FocusScope.of(context).unfocus();
    }
    FocusScope.of(context).unfocus();
  }
  Future<void> _sendImage()async{
    final pickImage = await MediaService.pickImage();
    setState(() {
      file = pickImage;
    });
    if(file != null){
      await FirebaseFirestoreService.addImageMessage(
          receiverId: widget.receiverId,
          file: file!,
      );
    }
  }
}
