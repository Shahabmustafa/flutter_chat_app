import 'package:cached_network_image/cached_network_image.dart';
import 'package:chats_app/model/chat_user.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key,required this.user}) : super(key: key);
  final ChatUser user;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
            ),
            Flexible(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    height: 40,
                    width: 40,
                    imageUrl: "${widget.user.image}",
                    errorWidget: (context,url,error) => Icon(Icons.error),
                  ),
                ),
                title: Text(widget.user.name.toString()),
                subtitle: Text("Last seen is not Avilible"),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  builder: (context,snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final ListUser = [];
                          return ListView.builder(
                              padding: EdgeInsets.only(top: 5),
                              physics: BouncingScrollPhysics(),
                              itemCount: ListUser.length,
                              itemBuilder: (context,index){
                                if(ListUser.isNotEmpty){
                                  return Text("Message ${ListUser[index]}");
                                }else{
                                  return Text(
                                    "Could Not Find User!",
                                  );
                                }
                              }
                          );
                      }
                    } else {
                      return Center(child: Text("No Message Found!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),));
                    }
                  }
              ),
          ),
          _chatSearch(),
        ],
      ),
    );
  }
  Widget _chatSearch(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions,color: Colors.orangeAccent)),
                  Expanded(child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "type Something...",
                      border: InputBorder.none,
                    ),
                  )),
                  IconButton(onPressed: (){}, icon: Icon(Icons.photo,color: Colors.green,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.camera_alt,color: Colors.blue,)),
                ],
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.shade300,
            ),
            child: TextButton(
              onPressed: (){},
              child: Icon(
                    Icons.send,
                    color: Colors.green,
                ),
            ),
          ),
        ],
      ),
    );
  }
}
