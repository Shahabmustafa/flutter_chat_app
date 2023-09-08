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
  List<ChatUser> _searchList = [];
  bool _issearching = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.getSelfInfo();
  }
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: (){
          if(_issearching){
            setState(() {
              _issearching = !_issearching;
            });
            return Future.value(false);
          }else{
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.home),
            ),
            title: _issearching ? TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email or Name",
              ),
              style: TextStyle(
                fontSize: 17,
                letterSpacing: 0.8,
              ),
              onChanged: (value){
                _searchList.clear();
                for(var i in ListUser){
                  if(i.name!.toLowerCase().contains(value.toLowerCase()) ||
                      i.emaill!.toLowerCase().contains(value.toLowerCase())){
                    _searchList.add(i);
                  }
                  setState(() {
                    _searchList;
                  });
                }
              },
            ) : Text("Hello Chat"),
            actions: [
              IconButton(
                onPressed: (){
                  setState(() {
                    _issearching = !_issearching;
                  });
                },
                icon: Icon(_issearching ? Icons.close : Icons.search_rounded,),
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
                        itemCount: _issearching ? _searchList.length : ListUser.length,
                        itemBuilder: (context,index){
                          if(ListUser.isNotEmpty){
                            return ChatUserCard(
                              user: _issearching ? _searchList[index] : ListUser[index],
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
        ),
      ),
    );
  }
}
