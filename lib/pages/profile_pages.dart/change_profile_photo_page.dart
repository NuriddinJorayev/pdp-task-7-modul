import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/page_opener_push.dart';
import 'package:flutter_myinsta/models/image_loader.dart';
import 'package:flutter_myinsta/pages/new_post_pages/image_effect_page.dart';
import 'package:flutter_myinsta/services/file_service.dart';

class ChangeProfilePhoto extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const ChangeProfilePhoto({Key? key, this.cameras}) : super(key: key);

  @override
  State<ChangeProfilePhoto> createState() => _ChangeProfilePhotoState();
}

class _ChangeProfilePhotoState extends State<ChangeProfilePhoto> {
  // late CameraController _controller;
  int cameraIndex = 1;
  File? selected_image;
  bool isGallery = true;
  bool isLoading = false;
  var pageView_control = PageController();
  List<String> images_url = MyImage_Video_taker.RunAndLoad()[0];

  @override
  void initState() {
    super.initState();
    // camera_initialize();
    setState(() {
      try {
        selected_image = File(images_url[0]);
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    var allSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Feather.x, size: 25, color: Colors.black)),
          title: isGallery
              ? Row(
                  children: [
                    Text(
                      "Gallery",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Feather.chevron_down,
                      color: Colors.black,
                    )
                  ],
                )
              : Text(
                  "Photo",
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
          actions: [
            IconButton(
                onPressed: () {
                  // ignore: unused_local_variable
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => Image_effect_page(
                          image_file: [selected_image!],
                          isRound: true,
                          nextbutton: (f) {
                            setState(() {
                              isLoading = true;
                            });
                            nextButton(context);
                          })));
                },
                icon: Icon(
                  Feather.arrow_right,
                  color: Colors.black,
                ))
          ],
        ),
        body: Container(
          height: allSize.height,
          width: allSize.width,
          child: PageView(
            controller: pageView_control,
            children: [
              // first page
              Column(
                children: [
                  // base image view panel
                  Container(
                    height: allSize.width,
                    width: allSize.width,
                    alignment: Alignment.center,
                    decoration: selected_image != null
                        ? BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                                image: FileImage(selected_image!),
                                fit: BoxFit.cover),
                          )
                        : BoxDecoration(color: Colors.white),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: RadialGradient(stops: [
                        1,
                        .1
                      ], colors: [
                        Colors.transparent,
                        Colors.white.withAlpha(150)
                      ])),
                    ),
                  ),
                  // images selector panel
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 1),
                      child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 1,
                        crossAxisSpacing: 1,
                        children: images_url
                            .map((e) => _itemsOfGrid(e, allSize, () {
                                  setState(() {
                                    selected_image = File(e);
                                  });
                                }))
                            .toList(),
                      ),
                    ),
                  )
                ],
              ),
              // second page
              CameraApp(widget.cameras)
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              onTap: (index) {
                pageView_control.animateToPage(index,
                    duration: Duration(milliseconds: 800), curve: Curves.ease);
              },
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  child: Text(
                    "GALLERY",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
                Tab(
                  child: Text(
                    "PHOTO",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  nextButton(BuildContext context1) async {
    var url = await FileService.SetImage(selected_image!);
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
    Navigator.pop(context1, url);
  }

  Widget _itemsOfGrid(String url, Size size, press) => GestureDetector(
        onTap: press,
        child: Container(
            height: (size.width / 4),
            decoration: BoxDecoration(
              color: Colors.grey,
              gradient: LinearGradient(colors: [
                Colors.white,
                Colors.white,
              ]),
              image: DecorationImage(
                  image: FileImage(File(url)), fit: BoxFit.fill),
            ),
            child: selected_image!.path.compareTo(url) == 0
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      gradient: LinearGradient(colors: [
                        Colors.white.withOpacity(.5),
                        Colors.white.withOpacity(.5),
                      ]),
                    ),
                  )
                : SizedBox.shrink()),
      );
}

class CameraApp extends StatefulWidget {
  final cam;
  const CameraApp(this.cam);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  int cameraIndex = 0;
  File? image_url;

  @override
  void initState() {
    super.initState();

    controller =
        CameraController(widget.cam[cameraIndex], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  control_initalize() {
    setState(() {
      controller =
          CameraController(widget.cam[cameraIndex], ResolutionPreset.max);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  // take photo
  takePhoto(BuildContext context) async {
    final temp = await controller.takePicture();
    Directory d = Directory("/storage/emulated/0/Picture");
    int i = 0;
    File? f;
    while (i == 0) {
      if (d.existsSync()) {
        int index = 0;
        do {
          index++;
        } while (
            File("/storage/emulated/0/Picture/Photo_$index.png").existsSync());
        f = File("/storage/emulated/0/Picture/Photo_$index.png");
        if (!f.existsSync()) {
          f.createSync();
        }

        Uint8List bytes = await temp.readAsBytes();
        f.writeAsBytesSync(bytes);
        i++;
      } else {
        d.createSync();
      }
    }
    setState(() {
      image_url = f!;
    });

    PagePush.Push(
        context,
        Image_effect_page(
          image_file: [f!],
          isRound: true,
          nextbutton: (f) {
            nextButton(context);
          },
        ));
  }

  nextButton(BuildContext context1) async {
    var url = await FileService.SetImage(image_url!);
    Navigator.pop(context);
    Navigator.pop(context1, url);
  }

  @override
  Widget build(BuildContext context) {
    var allSize = MediaQuery.of(context).size;
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Column(
      children: [
        // camera viewer panel
        Container(
          height: allSize.height * .50,
          width: allSize.width,
          child: Stack(
            children: [
              Container(
                  height: allSize.height * .50,
                  width: allSize.width,
                  // camera view
                  child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: CameraPreview(controller))),
              Container(
                height: allSize.height * .50,
                width: allSize.width,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          cameraIndex = cameraIndex == 0 ? 1 : 0;
                          control_initalize();
                        });
                      },
                      icon: Icon(
                        Feather.refresh_ccw,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Ionicons.md_flash_off,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // take photo button
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: () {
                takePhoto(context);
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[400]!, width: 20)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
