import 'package:flutter/material.dart';

class PostRemoveDialog {
  static show(BuildContext context, String s, tap()) async {
    showDialog(
        context: context,
        builder: (con) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              insetPadding: EdgeInsets.symmetric(horizontal: 70),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                height: 240,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 25),
                    _text_builder(
                        "Delete ${s.contains(".mp4") ? "video" : "this post"}?"),
                    SizedBox(height: 10),
                    _text_builder2(
                        "You can restore this post from Recently deleted in Your activity within 30 days. After that, it will be permanently deleted."),
                    SizedBox(height: 25),
                    _myDivider(),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              tap();
                              Navigator.pop(con);
                              Navigator.pop(con);
                            },
                            child: _colorly_text_builder(
                                "Delete", Color.fromARGB(255, 21, 90, 146))),
                      ),
                    ),
                    _myDivider(),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          onTap: () {
                            Navigator.pop(con);
                            Navigator.pop(con);
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                "${s.contains(".mp4") ? "Cancel" : "Don't delete"}?",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  static Widget _myDivider() => Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey,
      );
  static Widget _text_builder(s) => Container(
        alignment: Alignment.center,
        child: Text(
          s,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      );
  static Widget _text_builder2(s) => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: Text(
          s,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12, height: 1.4, fontWeight: FontWeight.normal),
        ),
      );
  static Widget _colorly_text_builder(s, [xcolor]) => Container(
        alignment: Alignment.center,
        child: Text(
          s,
          style: TextStyle(
              color: xcolor != null ? xcolor : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: .9),
        ),
      );
}
