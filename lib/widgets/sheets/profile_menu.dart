import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileMenuSheet {
  static show(BuildContext context, PageController pageController) {
    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (con) => Column(
              children: [
                Expanded(child: SizedBox.shrink()),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                      )),
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.topCenter,
                          child: grey_buttun()),
                      items("assets/images/SVGs/setting.svg", "Settings", () {
                        Navigator.pop(con);
                        WidgetsBinding.instance?.addPostFrameCallback((_) {
                          if (pageController.hasClients) {
                            pageController.animateToPage(1,
                                duration: Duration(milliseconds: 1),
                                curve: Curves.easeInOut);
                          }
                        });
                      }),
                      items("assets/images/SVGs/activity.svg", "Your activity",
                          () {}),
                      items("assets/images/SVGs/qr_code.svg", "QR code", () {}),
                      items("assets/images/SVGs/bookmark.svg", "Saved", () {}),
                      items("assets/images/SVGs/starList.svg", "Close friends",
                          () {}),
                      items("assets/images/SVGs/favourite.svg", "Favourites",
                          () {}),
                      items("assets/images/SVGs/covid.svg",
                          "COVID-19 Information Centre", () {}),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ));
  }

  static Widget grey_buttun() => Container(
        decoration: BoxDecoration(
            color: Colors.grey[800], borderRadius: BorderRadius.circular(10)),
        height: 5,
        width: 40,
      );

  static Widget items(asset, text, Function() press) => GestureDetector(
        onTap: press,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: SvgPicture.asset(
                asset,
                height: 30,
                width: 30,
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 7, left: 10),
                child: Text(text,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
      );
}
