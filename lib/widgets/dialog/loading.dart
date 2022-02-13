import 'package:flutter/material.dart';

class Loading_dialog {

  static show(BuildContext context){
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size;
    showDialog(context: context, builder: (con)=> Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        child: Row(
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.black87,
                strokeWidth: 2,
              ),
            ), 
            SizedBox(width: 20),
            Text("Loading...", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: .8),)
          ],
        ),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 120),
      
    ));
  }
  
}