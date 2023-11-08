import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key,
    required this.hintText,
    required this.suffixIcon,
    required this.prefixIcon,

  }) : super(key: key);
  String hintText;
  IconData suffixIcon;
  IconData prefixIcon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: hintText,

            suffixIcon: Icon(suffixIcon),
            prefixIcon: Icon(prefixIcon),
          ),
        ),
    );
  }
}
