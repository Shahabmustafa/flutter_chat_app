


import 'package:chats_app/view/widgets/custem_text_field.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users Search"),
        elevation: 0,
      ),
      body: Column(
        children: [
          CustomTextField(
              hintText: hintText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              controller: controller,
              onTap: null,
          ),
        ],
      ),
    );
  }
}
