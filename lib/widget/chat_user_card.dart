import 'package:cached_network_image/cached_network_image.dart';
import 'package:chats_app/model/chat_user.dart';
import 'package:chats_app/screen/chatt_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  ChatUserCard({Key? key,required this.user}) : super(key: key);
  final ChatUser user;
  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImage(
            height: 50,
            width: 50,
            imageUrl: "${widget.user.image}",
            errorWidget: (context,url,error) => Icon(Icons.error),
          ),
        ),
        title: Text(widget.user.name.toString()),
        subtitle: Text("Last Message"),
        trailing: Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ChatPage(
                user: widget.user,
              )));
        },
      ),
    );
  }
}
