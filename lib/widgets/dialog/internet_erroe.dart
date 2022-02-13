import 'package:flutter/material.dart';

class Internet_error {
  static show(BuildContext context) {
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (com) => Dialog(
              child: Container(
                height: 280,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30),
                    Text("Error",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w800)),
                    SizedBox(height: 20),
                    text_build("Sorry, we couldn't update"),
                    text_build("your profile picture. Please"),
                    text_build("confirm you have an"),
                    text_build("Internet connecttion and try"),
                    text_build("again in a moment."),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: .8,
                      color: Colors.grey[800],
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(com);
                          },
                          child: Text(
                            "Dismiss",
                            style: TextStyle(
                                color: Colors.blue[600],
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              insetPadding: EdgeInsets.symmetric(horizontal: 75),
            ));
  }
}

Widget text_build(String text) => Text(text,
    style: TextStyle(fontSize: 17, color: Colors.grey[700], height: 1.4));
