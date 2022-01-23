
import 'package:flutter/material.dart';

class MyMain_page_control {
  static PageController? _pageController;
  static set (PageController c){
    _pageController = c;
  }
  

  static go_page(int index) {
    
      _pageController!.animateToPage(index,
          duration: Duration(milliseconds: 100), curve: Curves.easeOutBack);
    
  }
}