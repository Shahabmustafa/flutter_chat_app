import 'dart:convert';

import 'package:chats_app/APIs/apis.dart';
import 'package:chats_app/screen/profile_screen.dart';
import 'package:chats_app/widget/chat_user_card.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/chat_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ChatUser> ListUser = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.getSelfInfo();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){

          },
          icon: Icon(Icons.home),
        ),
        title: Text("Hello Chat"),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.search_rounded),
          ),
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage(
                user: APIs.me,
              )));
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: APIs.getAllUsers(),
        builder: (context,snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                final data = snapshot.data?.docs;
                ListUser = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
                return ListView.builder(
                    padding: EdgeInsets.only(top: 5),
                    physics: BouncingScrollPhysics(),
                    itemCount: ListUser.length,
                    itemBuilder: (context,index){
                      if(ListUser.isNotEmpty){
                        return ChatUserCard(
                          user: ListUser[index],
                        );
                      }else{
                        return Text(
                          "Could Not Find User!",
                        );
                      }
                    }
                );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.message),
      ),
    );
  }
}
