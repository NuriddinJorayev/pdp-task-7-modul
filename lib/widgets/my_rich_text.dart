import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  final String text;
  final String userName;
  const MyRichText({ Key? key, required this.text, required this.userName }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    List<String> list  = text.split(" ");
    return RichText(
      
    text: TextSpan(
      children: list.map((e) {
        if(e.startsWith('@') || e.startsWith('#')){
          return withColor(e);
        }
        if(e.startsWith(userName)){
          return addUserName(e);
        }
        else{
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
  TextSpan addUserName(String t) => TextSpan(
    text: t + " ",
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, letterSpacing: .5)
    
  );
}