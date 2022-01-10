import 'package:flutter/material.dart';

class MyOutLineButoon extends StatelessWidget {
  final String textname;
  final Function() onPressed;
  const MyOutLineButoon({ Key? key, required this.onPressed, required this.textname }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(7),
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.orange[900]!.withOpacity(.5),
        borderRadius: BorderRadius.circular(7),
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Colors.transparent,
            border: Border.all(
              color: Colors.white54.withOpacity(.3),
              width: 2
            ),
          ),
          alignment: Alignment.center,
          child: Text(textname, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}