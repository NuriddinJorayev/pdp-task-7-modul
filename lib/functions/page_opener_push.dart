import 'package:flutter/material.dart';

class PagePush {
  static Push(BuildContext con, page){
    Navigator.push(con, MaterialPageRoute(builder: (_)=>page));
  }
  
}