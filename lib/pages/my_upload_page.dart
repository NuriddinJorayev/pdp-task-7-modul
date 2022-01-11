import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MyUploadPage extends StatefulWidget {
  const MyUploadPage({Key? key}) : super(key: key);

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  File? image_file;
  bool bottomSheet = false;
  var cap_control = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text("Upload",
              style: TextStyle(color: Colors.black, fontFamily: 'Billbong_family', fontSize: 25)),
          actions: [
            IconButton(
              onPressed: _addNewPost,
              icon: Icon(Icons.post_add, color:Color.fromARGB(255, 245, 96, 63)),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: allsize.height,
            width: allsize.width,
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // image_picker(true);
                      _bottomSheet();
                    },
                    splashColor: Colors.black54.withOpacity(.3),
                    child: Container(
                        height: allsize.width,
                        width: allsize.width,
                        alignment: Alignment.center,
                        child: image_file == null
                            ? Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey.withOpacity(.5),
                                child: Icon(Icons.add_a_photo, size: 60.0),
                              )
                            : Stack(
                                children: [
                                  Image.file(image_file!,
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.cover),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10.0),
                                            color: Colors.black12,
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  image_file = null;
                                                });
                                              },
                                              icon: Icon(Icons.highlight_remove,
                                                  color: Colors.white54),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )),
                  ),
                ),
                // text field
                Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: TextField(
                    style: TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.w500),
                    controller: cap_control,
                    decoration: InputDecoration(
                      hintText: "Caption",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 18.0)
                      ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  //new post adder to server
  _addNewPost() {
    if (cap_control.text.trim().isNotEmpty && image_file != null) {}
  }

  // buttton sheet open function
  _bottomSheet() {
    showCupertinoModalBottomSheet(
      barrierColor: Colors.black54.withOpacity(.5),
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      builder: (con) => Container(
        height: 120,
        color: Colors.white54,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  image_picker(false);
                  Navigator.of(con).pop();
                },
                leading: Icon(Icons.photo_size_select_actual_rounded),
                title: Text("Pick Photo",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w600)),
              ),
              ListTile(
                onTap: () {
                  image_picker(true);
                  Navigator.of(con).pop();
                },
                leading: Icon(Icons.camera_alt),
                title: Text("Take Photo",
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  image_picker(bool isCamera) async {
    final ImagePicker _picker = ImagePicker();

    try {
      if (!isCamera) {
        final image = await _picker.pickImage(source: ImageSource.gallery);
        setState(() {
          image_file = File(image!.path);
        });
      } else {
        final photo = await _picker.pickImage(source: ImageSource.camera);
        setState(() {
          image_file = File(photo!.path);
        });
      }
    } catch (e) {}
  }
}
