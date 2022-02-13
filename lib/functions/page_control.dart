import 'package:flutter/cupertino.dart';

class MyPage_Controller {
  static PageController? _pageController;
  static set (PageController c){
    _pageController = c;
  }
  

  static go_page(int index) {
    if (_pageController != null) {
       WidgetsBinding.instance?.addPostFrameCallback((_) {
                      if (_pageController!.hasClients) {
                        _pageController!.animateToPage(index,
                            duration: Duration(milliseconds: 1),
                            curve: Curves.easeInOut);
                      }
                    });
    }
  }
}
