import 'dart:io';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/models/post.dart';
import 'package:flutter_myinsta/pages/home_paga.dart';
import 'package:flutter_myinsta/services/data_service.dart';
import 'package:flutter_myinsta/services/file_service.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/widgets/loading_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class Last_post_Page extends StatefulWidget {
  final List<File> file_image;
  const Last_post_Page({Key? key, required this.file_image}) : super(key: key);

  @override
  _Last_post_PageState createState() => _Last_post_PageState();
}

class _Last_post_PageState extends State<Last_post_Page> {
  int min_line = 1;
  int max_line = 2;
  var my_focus;
  var control = TextEditingController();
  var keyboardKey = TextInputType.text;
  List<bool> _switch_values = [false, false, false, false];
  String location = "";
  bool isLoading = false;
  Widget? video_widget;

  @override
  void initState() {
    if (widget.file_image.length == 1) {
      if (widget.file_image[0].path.endsWith(".mp4")) {
        var con = VideoPlayerController.file(
          widget.file_image[0],
        )..initialize();
        video_widget = ClipRRect(
            borderRadius: BorderRadius.circular(15), child: VideoPlayer(con));
      }
    }
    super.initState();
    print("last page = ${widget.file_image}");
  }

  @override
  Widget build(BuildContext context) {
    var allSize = MediaQuery.of(context).size;
    return Scaffold(
      // start appbar
      appBar: AppBar(
        elevation: isLoading ? 0 : 1,
        backgroundColor: isLoading ? Colors.grey : Colors.white,
        leading: IconButton(
            onPressed: isLoading
                ? null
                : () {
                    Navigator.pop(context);
                  },
            icon: Icon(
              AntDesign.arrowleft,
              color: Colors.black,
              size: 30,
            )),
        title: Text("New Post",
            style: TextStyle(color: Colors.black, fontSize: 22)),
        actions: [
          IconButton(
              onPressed: isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() => isLoading = true);
                      var id = await Prefs.Load();
                      List<String> post_image_url = [];
                      for (var item in widget.file_image) {
                        print("====================================== $item");
                        print("rasm jo'natdim ");
                        post_image_url.add((await FileService.SetImage(item,
                            key: "all Posts images")));
                      }
                      var myuser = MyUser.FromJson(await DataService.getData());
                      var user_ob = Post(
                          myuser.user_image,
                          myuser.userName,
                          location,
                          post_image_url,
                          [],
                          control.text,
                          [],
                          get_now_date(),
                          id);
                      var setpost_to_user =
                          MyUser.FromJson(await DataService.getData());
                      DataService.SetNewData(setpost_to_user.Tojson());
                      DataService.SetNewData(
                          user_ob.ToJson(), "all Users Posts");
                      setState(() => isLoading = false);
                      Navigator.pushReplacementNamed(context, Home().id);
                    },
              icon: Icon(
                Ionicons.md_checkmark,
                color: Colors.blue,
                size: 30,
              )),
        ],
      ),
      // finish appbar
      body: SingleChildScrollView(
        child: Container(
          height: allSize.height,
          width: allSize.width,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: (widget.file_image.length == 1 &&
                              widget.file_image[0].path.endsWith(".mp4"))
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(15.0),
                            child: isVideoOrImage(context)),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextField(
                              controller: control,
                              keyboardType: TextInputType.multiline,
                              onChanged: (i) {
                                final numLines = '\n'.allMatches(i).length + 1;
                                if (max_line != numLines) {
                                  setState(() {
                                    max_line = numLines;
                                  });
                                }
                              },
                              maxLines: max_line,
                              minLines: min_line,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Write a caption...",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(color: Colors.grey[600], thickness: 1),
                    _simple_text("Tag people"),
                    Divider(color: Colors.grey[600], thickness: 1),
                    _simple_text("Add Location"),
                    Divider(color: Colors.grey[600], thickness: 1),
                    SizedBox(height: 5),
                    _simple_text("Also post to"),
                    _switch_Text("Facebook", 0),
                    _switch_Text("Twitter", 1),
                    _switch_Text("Tumblr", 2),
                    _switch_Text("Ok.ru", 3),
                    Divider(color: Colors.grey[600], thickness: 1),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 15),
                      child: Text(
                        "Advanced setting",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 20.0)
                  ],
                ),
                isLoading
                    ? Container(
                        height: allSize.height,
                        width: allSize.width,
                        color: Colors.black.withOpacity(.3),
                        child: MyLoadingWidget(progres_text: "Posting..."))
                    : SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget isVideoOrImage(BuildContext context) {
    var allSize = MediaQuery.of(context).size;
    if (widget.file_image.length == 1) {
      if (widget.file_image[0].path.endsWith(".mp4")) {
        // ignore: unused_local_variable
        var con = VideoPlayerController.file(widget.file_image[0])
          ..initialize();
        return Container(
          height: allSize.width * .30,
          width: (allSize.width / 6) + 10,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: video_widget ?? Container()),
              Container(
                height: allSize.width * .30,
                width: (allSize.width / 6) + 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(.6),
                        ])),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Cover",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: .5),
                    ),
                  ))
            ],
          ),
        );
      }
    }
    return Stack(
      children: [
        Image(
          height: (allSize.width / 6) + 5,
          width: (allSize.width / 6) + 5,
          image: FileImage(widget.file_image[0]),
          fit: BoxFit.cover,
        ),
        widget.file_image.length > 1
            ? Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SvgPicture.asset(
                      "assets/images/SVGs/fill_copy.svg",
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : SizedBox.shrink()
      ],
    );
  }

  Widget _simple_text(String text) => Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Text(text,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      );

  Widget _switch_Text(String s, int i) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(s,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
            _switch(i)
          ],
        ),
      );

  Widget _switch(int index) => Switch(
      value: _switch_values[index],
      onChanged: (bool b) {
        setState(() {
          _switch_values[index] = b;
        });
      });

  String get_now_date() {
    var min = DateTime.now().minute.toString();
    var hour = DateTime.now().hour.toString();
    var day = DateTime.now().day.toString();
    var month = DateTime.now().month.toString();
    var year = DateTime.now().year.toString();
    return ("$year-$month-$day $hour:$min");
  }
}
