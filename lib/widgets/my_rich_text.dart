import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  final String text;
  const MyRichText({ Key? key, required this.text }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    List<String> list  = text.split(" ");
    return RichText(
      
    text: TextSpan(
      children: list.map((e) {
        if(e.startsWith('@') || e.startsWith('#')){
          return withColor(e);
        }else{
          return withoutColor(e);
        }
      }).toList()
    ),
  );
  }

  TextSpan withColor(String t) => TextSpan(
    text: t + " ",
    style: TextStyle(color: Colors.blue[900])
    
  );
  TextSpan withoutColor(String t) => TextSpan(
    text: t + " ",
    style: TextStyle(color: Colors.black)
    
  );
}