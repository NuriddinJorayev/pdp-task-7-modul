import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class Sreach_Textfield extends StatelessWidget {
  const Sreach_Textfield({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 3),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withAlpha(30),
      ),
      child: TextField(
        cursorColor: Colors.black,
        cursorWidth: 1,
        cursorHeight: 20,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(
              color: Colors.black.withAlpha(150), letterSpacing: .5, height: 1),
          constraints: BoxConstraints(maxHeight: 35, minHeight: 30),
          prefixIcon: Icon(
            AntDesign.search1,
            color: Colors.black.withAlpha(150),
            size: 18,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
