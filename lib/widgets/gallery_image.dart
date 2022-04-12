import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_myinsta/utils/bitmap_image.dart';
import 'package:video_player/video_player.dart';

class Gallery_Image_builder {
  static VideoPlayerController? v_control;

  static Widget build(
          BuildContext context,
          String img_url,
          bool select_able,
          Function(String url) url_func,
          bool isticked,
          String n,
          Function(String url) press,
          Function(String url) ontap,
          [h]) =>
      GestureDetector(
          onLongPress: () {
            press(img_url);
          },
          onTap: () {
            select_able ? ontap(img_url) : () {};
            url_func(img_url);
          },
          child: !img_url.toLowerCase().endsWith(".mp4")
              ? Container(
                  height: h ?? 100,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(File(img_url)), fit: BoxFit.cover)),
                  alignment: Alignment.topRight,
                  child: select_able
                      ? roundBuilder(context, n, isticked, () {
                          ontap(img_url);
                        })
                      : SizedBox.shrink(),
                )
              : Container(
                  height: h ?? 100,
                  child: Stack(
                    children: [
                      imageOrvideo(img_url),
                      select_able
                          ? Container(
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.all(6),
                              child: roundBuilder(context, n, isticked, () {
                                ontap(img_url);
                              }),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ));

  static Widget roundBuilder(BuildContext context, String value, bool isselect,
          Function() ontap) =>
      GestureDetector(
        onTap: ontap,
        child: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1),
              shape: BoxShape.circle,
              color: isselect ? Colors.blue : Colors.grey.withOpacity(.3),
            ),
            child: isselect
                ? Text(value,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))
                : SizedBox.shrink()),
      );

  static Widget imageOrvideo(String file) {
    if (file.toLowerCase().endsWith(".mp4")) {
      return VideoWidget_VideoThumbnail(url: file);
    }
    return BitmapImage.bitmap(file, 5);
  }
}

class VideoWidget_VideoThumbnail extends StatefulWidget {
  final String url;
  const VideoWidget_VideoThumbnail({Key? key, required this.url})
      : super(key: key);

  @override
  State<VideoWidget_VideoThumbnail> createState() =>
      _VideoWidget_VideoThumbnailState();
}

class _VideoWidget_VideoThumbnailState
    extends State<VideoWidget_VideoThumbnail> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.url)
      ..initialize();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(videoPlayerController!);
  }
}
