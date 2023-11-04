import 'package:chats_app/utils/utils.dart';
import 'package:chats_app/view/screen/auth/auth_service.dart';
import 'package:chats_app/view/screen/chats_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              10.ph,
              TextFormField(
                controller: password,
                obscureText: visible,
                decoration: InputDecoration(
                  hintText: "Password",
                  suffixIcon: InkWell(
                    onTap: (){
                      visible =! visible;
                      setState(() {

                      });
                    },
                    child: Icon(
                      visible ?
                      Icons.visibility_off_outlined :
                      Icons.visibility,
                    ),
                  ),
                ),
              ),
              20.ph,
              ElevatedButton.icon(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsPage()));
                  },
                  icon: Icon(Icons.login),
                  label: Text("Login")
              ),
              30.ph,
              TextButton(
                onPressed: (){
                  AuthService().isLogin(
                    context,
                    email.text,
                    password.text,
                  );
                },
                child: Text("SignUp"),
              ),
            ],
          ),
      ),
    );
  }
}
