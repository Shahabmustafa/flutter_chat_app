import 'package:chats_app/model/user_modell.dart';
import 'package:flutter/material.dart';

class UserItems extends StatefulWidget {
  UserItems({Key? key,required this.user}) : super(key: key);
  UserModel user;
  @override
  State<UserItems> createState() => _UserItemsState();
}

class _UserItemsState extends State<UserItems> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.user.image.toString()),
          ),
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
              color: widget.user.isOnline ? Colors.green : Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ],
      ),
      title: Text(widget.user.name.toString(),style: TextStyle(color: Colors.black),),
    );
  }
}
