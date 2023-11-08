import 'package:chats_app/utils/utils.dart';
import 'package:chats_app/view/screen/auth/auth_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final authService = AuthService();
  bool visible = true;
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
              controller: userName,
              decoration: InputDecoration(
                hintText: "User Name",
              ),
            ),
            10.ph,
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
                  authService.isSignUp(
                    context,
                    userName.text,
                    email.text,
                    password.text,
                  );
                },
                icon: Icon(Icons.login),
                label: Text("Sign Up")
            ),
            30.ph,
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
