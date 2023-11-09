import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({Key? key,
    required this.hintText,
    required this.suffixIcon,
    required this.prefixIcon,
    required this.controller,
    required this.onTap,
  }) : super(key: key);
  String hintText;
  IconData suffixIcon;
  IconData prefixIcon;
  VoidCallback onTap;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: Offset.zero,
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ]
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          suffixIcon: InkWell(
            onTap: onTap,
            child: Icon(
              suffixIcon,
              color: Colors.green,
            ),
          ),
          prefixIcon: Icon(prefixIcon),
        ),
      ),
    );
  }
}
