import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe, unused_import
import 'package:pop_bottom_menu/pop_bottom_menu.dart';

class GalleryButtonSheet {
  static int sheet_item_length = 6;

  static Show(BuildContext context, List<String> list, List<Function()> funcs) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: list
                        .map((e) => items_builder(e, funcs[list.indexOf(e)]))
                        .toList(),
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

  static Widget items_builder(String title, Function() tap) => SizedBox(
        height: 45.0,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0.0),
          title: Text(title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          selectedColor: Colors.grey,
          onTap: tap,
        ),
      );
}
  
// Padding(
//     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
//     child: Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
//   );