import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Last_post_Page extends StatefulWidget {
  final File file_image;
  const Last_post_Page({Key? key, required this.file_image}) : super(key: key);

  @override
  _Last_post_PageState createState() => _Last_post_PageState();
}

class _Last_post_PageState extends State<Last_post_Page> {
  List<bool> _switch_values = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    var allSize = MediaQuery.of(context).size;
    return Scaffold(
      // start appbar
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              AntDesign.arrowleft,
              color: Colors.black,
              size: 30,
            )),
        title: Text("New Post",
            style: TextStyle(color: Colors.black, fontSize: 22)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Ionicons.md_checkmark,
                color: Colors.blue,
                size: 30,
              )),
        ],
      ),
      // start appbar
      body: SingleChildScrollView(
        child: Container(
          height: allSize.height,
          width: allSize.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Image(
                      height: allSize.width / 6,
                      width: allSize.width / 6,
                      image: FileImage(widget.file_image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write a caption...",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              ),
              Divider(color: Colors.grey[600], thickness: 1),
              _simple_text("Tag people"),
              Divider(color: Colors.grey[600], thickness: 1),
              _simple_text("Add Location"),
              Divider(color: Colors.grey[600], thickness: 1),
              SizedBox(height: 5),
              _simple_text("Also post to"),
              _switch_Text("Facebook", 0),
              _switch_Text("Twitter", 1),
              _switch_Text("Tumblr", 2),
              _switch_Text("Ok.ru", 3),
              Divider(color: Colors.grey[600], thickness: 1),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                child: Text(
                  "Advanced setting",
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _simple_text(String text) => Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Text(text, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      );

  Widget _switch_Text(String s, int i) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(s, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)), _switch(i)],
        ),
      );

  Widget _switch(int index) => Switch(
      value: _switch_values[index],
      onChanged: (bool b) {
        setState(() {
          _switch_values[index] = b;
        });
      });
}
