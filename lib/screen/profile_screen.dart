import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chats_app/screen/auth/login_screen.dart';
import 'package:chats_app/widget/custtom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../APIs/apis.dart';
import '../helper/dialogs.dart';
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
  String? _image;
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
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _image != null ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                            File(_image!),
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                      ) : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                          imageUrl: widget.user.image.toString(),
                          errorWidget: (context,url,error) => Icon(Icons.error),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          showModalBottomSheet(
                            context: context,
                            builder: (context){
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text('Pick Profile Image',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.camera_alt,color: Colors.blue,),
                                    title: Text("Camera"),
                                    onTap: ()async{
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? files = await picker.pickImage(source: ImageSource.camera);
                                      if (files != null) {
                                        setState(() {
                                          _image = files.path;
                                        });
                                        APIs.updateProfilePicture(File(_image!));
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo,color: Colors.green,),
                                    title: Text("Gallery"),
                                    onTap: ()async{
                                      final ImagePicker picker = ImagePicker();
                                      final XFile? files = await picker.pickImage(source: ImageSource.gallery);
                                      if (files != null) {
                                        setState(() {
                                          _image = files.path;
                                        });
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              );
                            },
                          );
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
                          onSaved: (value) => APIs.me.about = value ?? "",
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
                          onSaved: (value) => APIs.me.name = value ?? "",
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
                        CusttomButton(
                          height: 50,
                          width: double.infinity,
                          title: "Update",
                          imageUrl: "edit.png",
                          onTap: (){
                            if(key.currentState!.validate()){
                              key.currentState!.save();
                              APIs.updateUserInfo();
                              Dialogs.showSnackbar(context, "Profile Update Successfully");
                            }
                          },
                          boxDecoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(40),
                          ),
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
