import 'package:flutter/material.dart';

class CusttomButton extends StatelessWidget {
  CusttomButton({Key? key,this.width,this.height,this.title,this.icons,required this.boxDecoration,this.imageUrl,this.onTap}) : super(key: key);
  String? title;
  String? imageUrl;
  IconData? icons;
  double? width;
  double? height;
  BoxDecoration boxDecoration;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: boxDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("images/${imageUrl}",height: 40,width: 40,),
            Text("${title}",style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
          ],
        ),
      ),
    );
  }
}
