import 'dart:io';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/main_page_controller.dart';
import 'package:flutter_myinsta/functions/page_opener_push.dart';
import 'package:flutter_myinsta/models/image_loader.dart';
import 'package:flutter_myinsta/pages/new_post_pages/image_effect_page.dart';
import 'package:flutter_myinsta/pages/new_post_pages/last_post_page.dart';
import 'package:flutter_myinsta/widgets/gallery_button.dart';
import 'package:flutter_myinsta/widgets/gallery_image.dart';
import 'package:flutter_myinsta/widgets/sheets/gallry_button_sheet.dart';

class GelleryPage extends StatefulWidget {
  final String id = "home_page";
  final String? story;
  final PageController? page_control;
  const GelleryPage({Key? key, this.page_control, this.story})
      : super(key: key);

  @override
  _GelleryPageState createState() => _GelleryPageState();
}

class _GelleryPageState extends State<GelleryPage> {
  double index_test = 0.0;
  List<List<String>> all_Images_url = [];
  bool select_able = false;
  List<bool> select_image = [];
  List<int> select_count = [];
  File? file_image;

  @override
  void initState() {
    super.initState();
    all_Images_url = MyImage_Video_taker.RunAndLoad();
    // ignore: unused_local_variable
    for (var e in all_Images_url[0]) {
      select_image.add(false);
      select_count.add(0);
    }
    if (select_image.isNotEmpty) {
      setState(() {
        file_image = File(all_Images_url[0][0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                if (widget.story!.compareTo("STORY") == 0) {
                  MyMain_page_control.go_page(1);
                } else {
                  Navigator.pop(context);
                  MyMain_page_control.go_page(1);
                }
              },
              icon: Icon(
                Feather.x,
                color: Colors.black,
                size: 30,
              )),
          title: Text("New Post",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              )),
          actions: [
            // @next button
            IconButton(
                onPressed: () {
                  PagePush.Push(context, Image_effect_page(
                    image_file: file_image!, isRound: false, nextbutton: () {
                          PagePush.Push(context, Last_post_Page(file_image: file_image!));
                        },
                      ));
                },
                icon: Icon(
                  MaterialIcons.arrow_forward,
                  color: Colors.blue,
                  size: 30,
                ))
          ],
        ),

        // @start body routes
        body: select_image.isNotEmpty
            ? Container(
                height: allsize.height,
                width: allsize.width,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        height: allsize.height,
                        width: allsize.width,
                        child: Column(
                          children: [
                            // @single big  image panel
                            Container(
                                height: allsize.height / 2,
                                width: allsize.width,
                                color: Colors.grey,
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                child: file_image == null
                                    ? Image(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                            File(all_Images_url[0].first)),
                                        filterQuality: FilterQuality.high,
                                      )
                                    : Image(
                                        fit: BoxFit.cover,
                                        image: FileImage(file_image!),
                                        filterQuality: FilterQuality.high,
                                      )),
                            Container(
                              height: 50,
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // @gallery panel
                                  GestureDetector(
                                    onTap: () {
                                      GalleryButtonSheet.Show(context);
                                    },
                                    child: Row(
                                      children: [
                                        Text("Gallery  ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Image.asset('assets/images/down.png',
                                            height: 16, width: 16)
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      MyGalleryButton.build(
                                          "assets/images/SVGs/copy-outline.svg",
                                          0, () {
                                        setState(() {
                                          if (MyGalleryButton.iselect &&
                                              select_able) {
                                            MyGalleryButton.iselect = false;
                                            for (int i = 0;
                                                i < select_image.length;
                                                i++) {
                                              select_image[i] = false;
                                              select_count[i] = 0;
                                            }
                                            select_able = false;
                                          } else {
                                            MyGalleryButton.iselect = true;
                                            select_able = true;
                                            select_image[0] = true;
                                            select_count[0] = 1;
                                          }
                                        });
                                      }),
                                      SizedBox(width: 10.0),
                                      MyGalleryButton.build(
                                          Feather.camera, 1, () {}),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                                // @all image viewer
                                child: GridView.count(
                              crossAxisCount: 4,
                              crossAxisSpacing: 2,
                              mainAxisSpacing: 2,
                              children: all_Images_url[0]
                                  .map((e) => Gallery_Image_builder.build(
                                      context,
                                      e,
                                      select_able,
                                      (String file_url) {
                                        if (file_url.isNotEmpty) {
                                          setState(() {
                                            file_image = File(file_url);
                                          });
                                        }
                                      },
                                      select_image.isNotEmpty
                                          // @select image selected or unselected list
                                          ? select_image[
                                              all_Images_url[0].indexOf(e)]
                                          : false,
                                      // @select counter list
                                      select_count.isNotEmpty
                                          ? select_count[
                                                  all_Images_url[0].indexOf(e)]
                                              .toString()
                                          : 0.toString(),
                                      // @func
                                      () {
                                        setState(() {
                                          select_able = true;
                                          MyGalleryButton.iselect = true;
                                        });
                                      },
                                      // @func
                                      () {
                                        setState(() {
                                          if (select_image[
                                              all_Images_url[0].indexOf(e)]) {
                                            select_image[all_Images_url[0]
                                                .indexOf(e)] = false;
                                          } else
                                            select_image[all_Images_url[0]
                                                .indexOf(e)] = true;
                                          counter_select();
                                        });
                                      }))
                                  .toList(),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Image"),
                    Text("No Vedio"),
                  ],
                ),
              ));
  }

  List nulllist = [1, 2, 3];

  counter_select() {
    int temp = 0;
    for (int i = 0; i < select_image.length; i++) {
      if (select_image[i]) {
        setState(() {
          for (var w in select_image) {
            if (w) {
              temp++;
            }
          }
          if (!select_count.contains(temp)) {
            if (select_count[i] == 0) {
              setState(() {
                select_count[i] = temp;
              });
            }
          }
        });
      } else {
        setState(() {
          select_count[i] = 0;
        });
      }
      temp = 0;
    }
    // chack
    int temple = 0;
    for (int i = 0; i < select_count.length; i++) {
      if (!select_count.contains(i) && select_count.contains(i + 1)) {
        temple = i;
      }
    }
    if (temple > 0) {
      for (int j = 0; j < select_count.length; j++) {
        if (temple < select_count[j]) {
          setState(() {
            select_count[j] = select_count[j] - 1;
          });
        }
      }
    }
  }
}
