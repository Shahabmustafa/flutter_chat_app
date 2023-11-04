import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/firebase_provider.dart';
import '../widgets/user_item.dart';
import 'auth/auth_service.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<FirebaseProvider>(context,listen: false).getAllUser();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          InkWell(
            onTap: (){
              AuthService().isSignOut(context);
            },
            child: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Consumer<FirebaseProvider>(
          builder: (context, value, child) {
            return ListView.separated(
              padding:
              const EdgeInsets.symmetric(horizontal: 16),
              itemCount: value.users.length,
              separatorBuilder: (context, index) =>
              const SizedBox(height: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => value
                  .users[index].uid !=
                  FirebaseAuth.instance.currentUser?.uid
                  ? UserItems(user: value.users[index])
                  : const SizedBox(),
            );
          }),
    );
  }
}
