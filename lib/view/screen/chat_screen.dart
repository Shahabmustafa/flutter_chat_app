import 'package:flutter/material.dart';
import '../../model/user_modell.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key,required this.user}) : super(key: key);

  final UserModel user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
    );
  }
  AppBar _buildAppBar() =>
      AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.image.toString()),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name.toString(),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  widget.user.isOnline == true ?
                  "Online" :
                  "Offline",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
