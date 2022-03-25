import 'dart:io';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/models/effect_list.dart';
import 'package:flutter_myinsta/pages/gallery.dart';
import 'package:flutter_myinsta/widgets/loading_widget.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class Image_effect_page extends StatefulWidget {
  final List<File> image_file;
  final Function(File f) nextbutton;
  final bool isRound;

  const Image_effect_page(
      {Key? key,
      required this.image_file,
      required this.isRound,
      required this.nextbutton})
      : super(key: key);

  @override
  _Image_effect_pageState createState() => _Image_effect_pageState();
}

class _Image_effect_pageState extends State<Image_effect_page> {
  List l = [
    "Normal",
    "Clarendon",
    "Gingham",
    "Moon",
    "Lark",
    "Reyes",
    "juno",
    "Slumber",
    "Crema",
    "Ludwing",
    "Aden",
    "Perpetua",
    "Amora",
    "Rise",
    "Valencia",
    "x-Pro II",
    "Sierra",
    "Willow",
    "Lo_Fi",
    "Inkwell",
    "Nashville"
  ];
  bool isselect = false;
  bool isLoading = false;
  var _base_colorFilter;
  int select_index = 0;
  Widget? wid_Video_image;

  @override
  void initState() {
    if (widget.image_file[0].path.endsWith(".mp4")) {
      get_wid(widget.image_file[0].path);
    }
    super.initState();
    _base_colorFilter = Effect_list.ListColorFilter[0];
  }

  get_wid(String url) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: url,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 100,
    );
    if (uint8list != null) {
      setState(() {
        wid_Video_image = Image.memory(
          uint8list,
          fit: BoxFit.fill,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;

    var status_height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      // app bar start
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor:
            isLoading ? Colors.black.withOpacity(.3) : Colors.white,
        leading: IconButton(
            onPressed: () {
              if (!isLoading) Navigator.pop(context);
            },
            icon: Icon(
              AntDesign.arrowleft,
              color: Colors.black,
              size: 30,
            )),
        centerTitle: true,
        title: Icon(
          FontAwesome.magic,
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (!isLoading) {}
                setState(() {
                  isLoading = true;
                });

                widget.nextbutton(File("/"));

                // widget.isRound ? Navigator.pop(context) : {};
              },
              icon: Icon(
                AntDesign.arrowright,
                color: Colors.blue,
                size: 30,
              )),
        ],
      ),
      // app bar finish
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: allsize.height -
                  (status_height + AppBar().preferredSize.height + 50),
              width: allsize.width,
              child: Column(
                children: [
                  // base image
                  !widget.isRound
                      ? image_builder(widget.image_file)
                      : Container(
                          height: allsize.width,
                          width: allsize.width,
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Container(
                                height: (allsize.height / 2) + status_height,
                                child: ColorFiltered(
                                  colorFilter: _base_colorFilter,
                                  child: Image.file(
                                    widget.image_file[0],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    gradient: RadialGradient(stops: [
                                  1,
                                  0.5
                                ], colors: [
                                  Colors.transparent,
                                  Colors.white.withAlpha(150)
                                ])),
                              ),
                            ],
                          ),
                        ),
                  // effects panel
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: l
                                  .map((e) => Effect_items(
                                      e,
                                      Effect_list
                                          .ListColorFilter[l.indexOf(e)]))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          isLoading
              ? Container(
                  height: allsize.height,
                  width: allsize.width,
                  color: Colors.black.withOpacity(.3),
                  alignment: Alignment.center,
                  child: MyLoadingWidget(progres_text: "Processing..."))
              : SizedBox.shrink()
        ],
      ),

      bottomNavigationBar: Container(
        height: 50,
        padding: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () => select_changeer(false),
              child: Container(
                height: 45,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Filter"),
                    SizedBox(height: 5),
                    Container(
                        height: 1,
                        color: isselect ? Colors.white : Colors.black),
                  ],
                ),
              ),
            )),
            Expanded(
                child: GestureDetector(
              onTap: () => select_changeer(true),
              child: Container(
                height: 45,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Edit"),
                    SizedBox(height: 5),
                    Container(
                        height: 1,
                        color: !isselect ? Colors.white : Colors.black),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget image_builder(List<File> list) {
    if (list.length == 1) {
      return single_img_or_video(list[0]);
    } else {
      return Container(
          height: (MediaQuery.of(context).size.height / 2) * .80,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
              controller: PageController(viewportFraction: .85),
              physics: BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (con, index) {
                if (list[index].path.endsWith(".mp4")) {
                  return Container(
                      height: (MediaQuery.of(context).size.height * .80),
                      width: (MediaQuery.of(context).size.width * .50),
                      padding: EdgeInsets.only(left: 10),
                      child: ColorFiltered(
                        colorFilter: _base_colorFilter,
                        child: Video_wid(
                          url: list[index].path,
                          autoPlay: false,
                        ),
                      ));
                } else
                  return Container(
                    height: (MediaQuery.of(context).size.height * .80),
                    width: (MediaQuery.of(context).size.width * .50),
                    padding: EdgeInsets.only(left: 10),
                    child: ColorFiltered(
                      colorFilter: _base_colorFilter,
                      child: Image.file(
                        list[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  );
              }));
    }
  }

  Widget rounded_plus() {
    return Container(
      height: 100,
      width: 100,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
    );
  }

  single_img_or_video(File s) {
    if (!s.path.endsWith(".mp4")) {
      return Container(
        height: (MediaQuery.of(context).size.height / 2),
        width: (MediaQuery.of(context).size.width),
        child: ColorFiltered(
          colorFilter: _base_colorFilter,
          child: Image.file(
            s,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      );
    } else {
      return Container(
        height: (MediaQuery.of(context).size.height / 2),
        width: (MediaQuery.of(context).size.width),
        child: Video_wid(url: s.path),
      );
    }
  }

  // isselect change
  select_changeer(bool b) {
    setState(() {
      isselect = b;
    });
  }

  // build effect items
  Widget Effect_items(
    String name,
    _color,
  ) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name),
          GestureDetector(
              onTap: () {
                setState(() {
                  _base_colorFilter = _color;
                  select_index = l.indexOf(name);
                });
              },
              child: !widget.image_file[0].path.endsWith(".mp4")
                  ? Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: (MediaQuery.of(context).size.width / 3.5) - 16,
                      color: Colors.amber,
                      margin: EdgeInsets.all(8),
                      child: ColorFiltered(
                        colorFilter: _color,
                        child: Image.file(
                          widget.image_file[0],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height / 8,
                      width: (MediaQuery.of(context).size.width / 3.5) - 16,
                      padding: EdgeInsets.all(8),
                      child: ColorFiltered(
                          colorFilter: _color,
                          child: wid_Video_image ??
                              Container(
                                color: Colors.blue,
                              )),
                    )),
        ],
      ),
    );
  }
}
