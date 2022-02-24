import 'package:flutter/cupertino.dart';

class MyPage_Controller {
  static PageController? pageController;
  static set (PageController c){
    pageController = c;
  }
  

  static go_page(int index) {
    if (pageController != null) {
       WidgetsBinding.instance?.addPostFrameCallback((_) {
                      if (pageController!.hasClients) {
                        pageController!.animateToPage(index,
                            duration: Duration(milliseconds: 1),
                            curve: Curves.easeInOut);
                      }
                    });
    }
  }
}
