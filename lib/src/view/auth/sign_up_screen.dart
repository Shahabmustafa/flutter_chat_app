import 'dart:async';

import 'package:chats_app/src/shared/text_form_field.dart';
import 'package:chats_app/src/view/auth/login_screen.dart';
import 'package:flutter/material.dart';

import '../../apis/api.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ApiService service = ApiService();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: userName,
            decoration: InputDecoration(
              hintText: "UserName",
            ),
          ),
          TextFormField(
            controller: email,
            decoration: InputDecoration(
              hintText: "Email",
            ),
          ),
          TextFormField(
            controller: password,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          ElevatedButton(
            onPressed: (){
              service.signUp(
                  context,
                  email.text,
                  password.text,
                  userName.text,
              );
            },
            child: Text("sign up"),
          ),
        ],
      ),
    );
  }
}
