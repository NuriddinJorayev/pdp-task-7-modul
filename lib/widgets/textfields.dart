
import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  final String text ;
  final  control;
  const MyTextFields({required this.text, this.control});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: Colors.white54.withOpacity(.2)
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: control,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Colors.white54, fontSize: 16),
          border: InputBorder.none
        ),
      ),
    );
  }
}