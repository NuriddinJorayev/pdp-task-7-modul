import 'package:flutter/material.dart';

class MyScrollButtn extends StatelessWidget {
  final Alignment? alignment;
   final String? select_text;
  final Function (String s)  onPressed;
  const MyScrollButtn({ Key? key, this.alignment, this.select_text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 250),
              alignment: alignment,
              child: Container(
                alignment: Alignment.center,
                height: 42.0,
                width: (allsize.width / 2) + 10,
                decoration: BoxDecoration(
                    color: select_text!.compareTo("POST") == 0
                        ? Colors.black.withOpacity(.89)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextBuilder("POST", select_text!),
                    TextBuilder("STORY", select_text!),
                    TextBuilder("LIVE", select_text!),
                  ],
                ),
              ),
            ),
          );
  }
   // text builder
  Widget TextBuilder(String _text, String select) {
    return _text.compareTo(select) == 0
        ? GestureDetector(
            onTap: ()=> onPressed(_text),
            child: Text(_text,
                style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          )
        : GestureDetector(
            onTap: ()=> onPressed(_text),
            child: Text(_text,
                style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 1.0,
                    color: Colors.white38,
                    fontWeight: FontWeight.bold)),
          );
  }
}