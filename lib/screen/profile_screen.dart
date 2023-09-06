import 'package:cached_network_image/cached_network_image.dart';
import 'package:chats_app/screen/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../APIs/apis.dart';
import '../model/chat_user.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key,required this.user}) : super(key: key);
  final ChatUser user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final key = GlobalKey<FormState>();
  final Name = TextEditingController();
  final about = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size * 1;
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomRight,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.user.image.toString(),
                          errorWidget: (context,url,error) => Icon(Icons.error),
                        ),
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text(widget.user.emaill.toString(),
                style: GoogleFonts.asapCondensed(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: Name,
                          validator: (value){
                            return Name.text.isEmpty ? "Please Enter Your Name" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Name",
                            label: Text("Name"),
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: about,
                          validator: (value){
                            return about.text.isEmpty ? "Please Enter Your Name" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Hey,I am useing Hello Chat",
                            label: Text("About"),
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        ElevatedButton.icon(
                            onPressed: (){
                              if(key.currentState!.validate()){

                              }
                            },
                            icon: Icon(Icons.edit),
                            label: Text("Update")
                        ),
                      ],
                    ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red,
            onPressed: ()async{
              await APIs.auth.signOut().then((value)async{
                await GoogleSignIn().signOut().then((value){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                });
              });
            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.exit_to_app),
                SizedBox(
                  width: 10,
                ),
                Text("Logout")
              ],
            )
        ),
      ),
    );
  }
}
