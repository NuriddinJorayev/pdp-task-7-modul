import 'package:flutter/material.dart';

class OtherUserMoreSheet {
  static int sheet_item_length = 6;
  static List<String> sheet_item_titles = [
    "Hide",
    "Unfollow",
  ];

  static Show(BuildContext context, Function() tap) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent.withOpacity(.0),
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  color: Colors.black.withOpacity(.0),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 35,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey[700]),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            round_button("Link", Icons.link, -0.8),
                            round_button("Share", Icons.share_outlined, 0.0),
                            round_button(
                                "Report...",
                                Icons.report_gmailerrorred_sharp,
                                0.0,
                                Colors.red),
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        margin: EdgeInsets.only(top: 8),
                        width: double.infinity,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        sheet_item_titles.map((e) => items_builder(e)).toList(),
                  ),
                  SizedBox(
                    height: 15.0,
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  static Widget items_builder(String title) => SizedBox(
        height: 45.0,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
          title: Text(title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          onTap: () {},
        ),
      );

  static Widget round_button(String text, icons, double angle,
          [Color colors = Colors.black]) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: colors.withAlpha(210), width: 1.5),
                  shape: BoxShape.circle),
              child: Transform.rotate(
                angle: angle,
                child: Icon(
                  icons,
                  size: 30,
                  color: colors,
                ),
              )),
          SizedBox(height: 6),
          Text(text,
              style: TextStyle(
                  color: colors, fontSize: 12, fontWeight: FontWeight.w700))
        ],
      );
}
