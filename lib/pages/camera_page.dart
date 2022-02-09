import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/main_page_controller.dart';
import 'package:flutter_myinsta/functions/page_control.dart';
import 'package:flutter_myinsta/widgets/camera_widgets/left_button.dart';
// ignore: unused_import
import 'package:flutter_myinsta/widgets/scrol_button.dart';

// ignore: must_be_immutable
class MyCameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  String select_text; // re
  Alignment alignment; // re
  final bool ismainPage;
  final PageController? page_control;
  MyCameraPage(
      {this.cameras,
      this.page_control,
      required this.alignment,
      required this.select_text, required this.ismainPage});

  @override
  _MyCameraPageState createState() => _MyCameraPageState();
}

class _MyCameraPageState extends State<MyCameraPage> {
  late CameraController controller;
  List<double> xiconsize = [35.0, 35.0];
  int cameraIndex = 0;
  XFile? pictureFile;
  List flash_list_icons = [
    MaterialIcons.flash_on,
    MaterialIcons.flash_auto,
    MaterialIcons.flash_off
  ];
  int selected_flash_index = 0;

  @override
  void initState() {
    super.initState();
    camera_initialize();
  }

  camera_initialize() {
    controller =
        CameraController(widget.cameras![cameraIndex], ResolutionPreset.max);
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

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    var allSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: CameraPreview(controller)),

              // take photo button
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    height: 80,
                    width: 80,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5)),
                      child: GestureDetector(
                        onTap: () async {
                          // take photo func
                        },
                        child: Container(
                          height: 90.0,
                          width: 90.0,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                      ),
                    ),
                  ),

                  // buttom panel
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        compareToAlign(
                                widget.alignment, Alignment.bottomCenter)
                            ?
                            // image gallery page open button
                            GestureDetector(
                                onTapDown: (l) =>
                                    setState(() => xiconsize.first = 32.0),
                                onTapUp: (l) =>
                                    setState(() => xiconsize.first = 35.0),
                                onTap: () {},
                                child: Icon(Feather.image,
                                    size: xiconsize.first,
                                    color: Colors.white),
                              )
                            : SizedBox.shrink(),
                        // camera change front or back button
                        GestureDetector(
                          onTapDown: (l) =>
                              setState(() => xiconsize.last = 32.0),
                          onTapUp: (l) =>
                              setState(() => xiconsize.last = 35.0),
                          onTap: () {
                            setState(() {
                              cameraIndex = (cameraIndex == 0 ? 1 : 0);
                              camera_initialize();
                              setState(() {});
                            });
                          },
                          child: Icon(Icons.flip_camera_ios_rounded,
                              size: xiconsize.last, color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),

              // top setting, flash, exit buttons
              Container(
                height: allSize.height,
                width: allSize.width,
                alignment: Alignment.topCenter,
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.settings, color: Colors.white, size: 30),
                    !compareToAlign(widget.alignment, Alignment.bottomLeft)
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selected_flash_index == 2)
                                  selected_flash_index = 0;
                                else
                                  selected_flash_index++;
                              });
                            },
                            child: Icon(
                                flash_list_icons[selected_flash_index],
                                size: 30,
                                color: Colors.white),
                          )
                        : SizedBox.shrink(),
                    GestureDetector(
                      onTap: () {
                        if(widget.ismainPage){
                          MyMain_page_control.go_page(1);
                        }else{
                          Navigator.pop(context);
                           MyPage_Controller.go_page(0);
                        }
                        
                       
                      },
                      child: Icon(Feather.x, color: Colors.white, size: 30),
                    ),
                  ],
                ),
              ),
              // left column buttons beackground gradient
              Container(
                height: allSize.height,
                width: allSize.width,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      height: allSize.height /1.2,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2000),
                        boxShadow: [
                        BoxShadow(
                            blurRadius: 500,
                            color: Colors.black.withOpacity(.3),
                            offset: Offset(-50, 0.0),
                            spreadRadius: 100,
                            )
                      ]),
                    ),
                    
                  ],
                ),
              ),
              // left column buttons
              Camera_left_button.build(allSize, Icons.ac_unit," text")
              
            ],
          ),
        ),
      ),
    );
  }

  bool compareToAlign(Alignment a, Alignment b) {
    if (a.x == b.x && a.y == b.y) {
      return true;
    }
    return false;
  }
}
