import 'dart:io';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/main_page_controller.dart';
import 'package:flutter_myinsta/functions/page_opener_push.dart';
import 'package:flutter_myinsta/models/image_loader.dart';
import 'package:flutter_myinsta/pages/new_post_pages/image_effect_page.dart';
import 'package:flutter_myinsta/pages/new_post_pages/last_post_page.dart';
import 'package:flutter_myinsta/utils/bitmap_image.dart';
import 'package:flutter_myinsta/widgets/gallery_button.dart';
import 'package:flutter_myinsta/widgets/gallery_image.dart';
import 'package:flutter_myinsta/widgets/sheets/gallry_button_sheet.dart';
import 'package:native_video_view/native_video_view.dart';

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
  var single_con = ScrollController();
  double index_test = 0.0;
  List<String> all_Images_url = [];
  bool select_able = false;
  List<bool> select_image = [];
  List<int> select_count = [];
  List<File>? file_image;
  List<File>? temp_file_image;
  int ini = 0;
  // ignore: unused_field

  @override
  void initState() {
    super.initState();
    setState(() {
      for (var e in MyImage_Video_taker.RunAndLoad()[0]) {
        all_Images_url.add(e);
      }
      for (var e in MyImage_Video_taker.RunAndLoad()[1]) {
        all_Images_url.add(e);
      }
    });
    // ignore: unused_local_variable
    for (var e in all_Images_url) {
      select_image.add(false);
      select_count.add(0);
    }
    if (select_image.isNotEmpty) {
      setState(() {
        file_image = [File(all_Images_url[0])];
      });
    }

    single_con.addListener(() {
      if (single_con.hasClients) {
        if (ini > single_con.offset.toInt()) {
          if (single_con.offset.toInt() == 110 ||
              single_con.offset.toInt() == 111 ||
              single_con.offset.toInt() == 109) {
            single_con.animateTo(0.0,
                duration: Duration(milliseconds: 880), curve: Curves.linear);
            ini = 0;
          }
        } else {
          ini = single_con.offset.toInt();
        }
      }
    });
  }

  @override
  void dispose() {
    print("dddddddddddddddddddddddddddddddddddddddddd");
    super.dispose();
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
                  PagePush.Push(
                      context,
                      Image_effect_page(
                        image_file: file_image!,
                        isRound: false,
                        nextbutton: (file) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Last_post_Page(
                                      file_image: file_image!))).then((value) {
                            setState(() {});
                          });
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
                      controller: single_con,
                      physics: BouncingScrollPhysics(
                          parent: ClampingScrollPhysics()),
                      child: Container(
                        height: allsize.height - 105,
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
                                    ? all_Images_url[0].endsWith(".mp4")
                                        ? Video_wid(url: all_Images_url[0])
                                        : BitmapImage.bitmap(
                                            all_Images_url[0], 50)
                                    : file_image!.last.path.endsWith(".mp4")
                                        ? Video_wid(url: file_image!.last.path)
                                        : BitmapImage.bitmap(
                                            file_image!.last.path, 50)),

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
                                // @all image grid viewer
                                child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: GridView.count(
                                physics: BouncingScrollPhysics(
                                    parent: ClampingScrollPhysics()),
                                crossAxisCount: 4,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2,
                                children: all_Images_url
                                    .map((e) => Gallery_Image_builder.build(
                                        context,
                                        e,
                                        select_able,
                                        (String file_url) {
                                          if (file_url.isNotEmpty) {
                                            setState(() {
                                              if (select_able) {
                                                if (!path_contains(
                                                    file_image!, file_url)) {
                                                  file_image!
                                                      .add(File(file_url));
                                                }
                                              } else {
                                                file_image = [File(file_url)];
                                              }
                                            });
                                            print(file_image);
                                          }
                                        },
                                        select_image.isNotEmpty
                                            // @select image selected or unselected list
                                            ? select_image[
                                                all_Images_url.indexOf(e)]
                                            : false,
                                        // @select counter list
                                        select_count.isNotEmpty
                                            ? select_count[
                                                    all_Images_url.indexOf(e)]
                                                .toString()
                                            : 0.toString(),
                                        // @func
                                        () {
                                          print("print 1111111111111");

                                          setState(() {
                                            select_able = true;
                                            MyGalleryButton.iselect = true;
                                          });
                                        },
                                        // @func round button
                                        (String url) {
                                          print("print 2222222222");
                                          setState(() {
                                            if (select_able) {
                                              if (!path_contains(
                                                  file_image!, url)) {
                                                file_image!.add(File(url));
                                              }
                                            } else {
                                              file_image = [File(url)];
                                            }
                                            if (select_image[
                                                all_Images_url.indexOf(e)]) {
                                              select_image[all_Images_url
                                                  .indexOf(e)] = false;
                                            } else
                                              select_image[all_Images_url
                                                  .indexOf(e)] = true;
                                            counter_select();
                                          });
                                        }))
                                    .toList(),
                              ),
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

  bool path_contains(List<File> f, String s) {
    for (var e in f) {
      if (e.path == s) {
        return true;
      }
    }
    return false;
  }
}

class Video_wid extends StatefulWidget {
  final String url;
  bool autoPlay;
  Video_wid({Key? key, required this.url, this.autoPlay = true})
      : super(key: key) {}

  @override
  _Video_widState createState() => _Video_widState();
}

class _Video_widState extends State<Video_wid> {
  VideoViewController? main_con;
  bool ispause = false;
  String? last_url;
  @override
  void initState() {
    last_url = widget.url;

    super.initState();
    setState(() {
      last_url = widget.url;
    });

    print(last_url);
  }

  @override
  void dispose() {
    main_con!.dispose();
    main_con = null;
    print("dddddddddddddddddddddddddddddddddddddddddd");
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print("diddiddidiidiididididiidiididididididididiidididiidididididididi");

    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    print("dededededededededededededededededededededede");

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            NativeVideoView(
                onCreated: (controller) {
                  main_con = controller;
                  main_con!.setVideoSource(
                    widget.url,
                    sourceType: VideoSourceType.network,
                  );
                  if (widget.autoPlay) {
                    main_con!.play();
                  }
                },
                onPrepared: (con, info) {},
                onProgress: (i, k) {
                  if (last_url != null && last_url != widget.url) {
                    setState(() {
                      last_url = widget.url;
                    });
                    main_con!.stop();
                    main_con!.setVideoSource(
                      widget.url,
                      sourceType: VideoSourceType.network,
                    );
                    main_con!.play();
                  }
                },
                onCompletion: (con) {
                  main_con!.play();
                }),
            ispause
                ? SizedBox(
                    child:
                        Icon(Icons.play_arrow, color: Colors.white, size: 50))
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
            InkWell(
              onTap: () {
                setState(() => ispause = !ispause);
                if (ispause) {
                  main_con!.pause();
                  print("111111111");
                } else {
                  print("22222");
                  main_con!.play();
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}
