import 'package:chats_app/src/apis/api.dart';
import 'package:chats_app/src/shared/text_form_field.dart';
import 'package:chats_app/src/view/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ApiService service = ApiService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              service.login(
                context,
                email.text,
                password.text,
              );
            },
            child: Text("Login"),
          ),
          TextButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
            },
            child: Text("Create your Account"),
          ),
        ],
      ),
    );
  }
}
