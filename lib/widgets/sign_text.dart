import 'package:flutter/material.dart';

class MySignText extends StatelessWidget {
    final String firstText;
    final String lastText;
    final Function()? onpressed;
  const MySignText({Key? key, required this.firstText, required this.lastText, this.onpressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Text(firstText, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
          SizedBox(width: 10.0),
          onpressed != null ? GestureDetector(
            onTap: onpressed,
            child: Text(lastText, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ):
           Text(lastText, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
