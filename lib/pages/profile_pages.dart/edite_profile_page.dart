// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/models/myUser.dart';
import 'package:flutter_myinsta/pages/profile_pages.dart/change_profile_photo_page.dart';
import 'package:flutter_myinsta/pages/profile_pages.dart/textfield_page_one.dart';
import 'package:flutter_myinsta/pages/profile_pages.dart/textfield_page_two.dart';
import 'package:flutter_myinsta/services/data_service.dart';
import 'package:flutter_myinsta/services/file_service.dart';
import 'package:flutter_myinsta/services/hive_db.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/widgets/loading_widget.dart';
import 'package:flutter_myinsta/widgets/sheets/edit_profile_sheet.dart';

class EditeProfilePage extends StatefulWidget {
  final cam;
  EditeProfilePage({Key? key, this.cam}) : super(key: key);

  @override
  State<EditeProfilePage> createState() => _EditeProfilePageState();
}

class _EditeProfilePageState extends State<EditeProfilePage> {
  String name = "";
  String username = "";
  String bio_text = "";
  String image_url = '';
  bool isLoading = false;
  static const IconData tik_icon =
      IconData(0xe156, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    var user = MyUser.FromJson(await DataService.getData());
    var user1 = MyUser.FromJson(Hive_db.load(await Prefs.Load()));
    if (mounted) {
      setState(() {
        if (!user1.operator(user)) {
          print("user111111111111");
          print(image_url);
          isLoading = true;
          name = user.name;
          username = user.userName;
          bio_text = user.bio;
          image_url = user.user_image;
          isLoading = false;
        } else {
          print("user0000000000000");
          print(image_url);
          isLoading = true;
          name = user1.name;
          username = user1.userName;
          bio_text = user1.bio;
          image_url = user1.user_image;
          isLoading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    // final double appbar_height = kToolbarHeight;
    var status_height = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isLoading ? Colors.black.withOpacity(.3) : Colors.white,
        leading: IconButton(
            onPressed: () {
              if (!isLoading) exit(context);
            },
            icon: Icon(
              Feather.x,
              color: Colors.black,
              size: 30,
            )),
        title: Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: .8),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (!isLoading) changedSave(context);
              },
              icon: Icon(tik_icon, color: Colors.blue[700]))
        ],
        elevation: 0,
      ),
      body: Container(
        height: allsize.height + 10,
        width: allsize.width,
        color: Colors.white,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: allsize.height - (status_height),
                width: allsize.width,
                child: Column(
                  children: [
                    GestureDetector(
                        onTap: () => _open_changePhotoPage(context),
                        child: _user_image(context, image_url)),
                    GestureDetector(
                        onTap: () => _open_changePhotoPage(context),
                        child: Text("Change profile photo",
                            style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 20,
                                height: 1.5))),
                    Expanded(
                        flex: 5,
                        child: Container(
                          child:
                              _textfield_view(context, "Name", name, () async {
                            var pop_string = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TextfieldPageOne(
                                          name: name,
                                          fierstWidget: SizedBox(
                                            height: 20,
                                          ),
                                          lastWidget: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "Help people discover your account by using the name\nthat you're known bu: either your full name, nickname or\nbusiness name.",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withAlpha(180))),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "You can only change your name twice within 14 days.",
                                                    style: TextStyle(
                                                      color: Colors.black
                                                          .withAlpha(180),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )));
                            if (pop_string != null) {
                              setState(() {
                                name = pop_string;
                              });
                            }
                          }),
                        )),
                    SizedBox(height: 5),
                    Expanded(
                        flex: 5,
                        child: Container(
                          child: _textfield_view(context, "Username", username,
                              () async {
                            var pop_string = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TextfieldPageTwo(
                                          textInputFormat:
                                              FilteringTextInputFormatter.deny(
                                                  RegExp(r'[\ | \.]*'),
                                                  replacementString: "_"),
                                          name: username,
                                          lastWidget: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 20),
                                                Text(
                                                    "You'llbe able to change your username back to\nlastUsername for another 14 days.",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withAlpha(180))),
                                                SizedBox(height: 2),
                                                Text("Learn more",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.blue,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: .8)),
                                              ],
                                            ),
                                          ),
                                        )));
                            if (pop_string != null) {
                              setState(() {
                                username = pop_string;
                              });
                            }
                          }),
                        )),
                    SizedBox(height: 10),
                    Expanded(
                        flex: 5,
                        child: Container(
                          child: _empty_textfield_view(context, "Pronouns"),
                        )),
                    Expanded(
                        flex: 5,
                        child: Container(
                          child: _empty_textfield_view(context, "Website"),
                        )),
                    Expanded(
                        flex: 4,
                        child: Container(
                          child: _textfield_view(context, "Bio", bio_text,
                              () async {
                            var pop_string = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TextfieldPageTwo(
                                          name: bio_text,
                                          textInputFormat:
                                              LengthLimitingTextInputFormatter(
                                                  150),
                                          isBio: true,
                                          lastWidget: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              // sdfghjk
                                            ],
                                          ),
                                        )));
                            if (pop_string != null) {
                              setState(() {
                                bio_text = pop_string;
                              });
                              _runData();
                            }
                          }),
                        )),
                    Expanded(flex: 2, child: Container(color: Colors.white)),
                    Expanded(
                        flex: 4,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myDivider(context),
                              Expanded(child: SizedBox.shrink()),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text("Switch to Professional account",
                                    style: TextStyle(
                                      color: Colors.blue[700],
                                      fontSize: 19,
                                    )),
                              ),
                              Expanded(child: SizedBox.shrink()),
                              myDivider(context)
                            ],
                          ),
                        )),
                    Expanded(flex: 2, child: Container(color: Colors.white)),
                    Expanded(
                        flex: 5,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myDivider(context),
                              Expanded(child: SizedBox.shrink()),
                              Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Personal information settings",
                                    style: TextStyle(
                                        color: Colors.blue[700],
                                        fontSize: 20,
                                        height: 1.5)),
                              ),
                              Expanded(child: SizedBox.shrink()),
                              myDivider(context)
                            ],
                          ),
                        )),
                    Expanded(flex: 1, child: Container(color: Colors.white)),
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
                    child: MyLoadingWidget(progres_text: "Loading..."))
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void _runData() async {
    var id = await Prefs.Load();
    MyUser user = MyUser(id, image_url, name, username, bio_text, [], 122, 83);
    DataService.SetNewData(user.Tojson());
    Hive_db.set(id, user.Tojson());
    initialize();
  }

  Widget myDivider(BuildContext con) => Container(
        width: MediaQuery.of(con).size.width,
        height: 1,
        color: Colors.grey,
      );

  // circle image builder
  Widget _user_image(BuildContext con, String url) => ClipRRect(
      borderRadius: BorderRadius.circular(MediaQuery.of(con).size.width / 4),
      child: url != null
          ? url.isNotEmpty
              ? CachedNetworkImage(
                  height: MediaQuery.of(con).size.width / 4,
                  width: MediaQuery.of(con).size.width / 4,
                  imageUrl: url,
                  fit: BoxFit.fill,
                )
              : Container(
                  height: MediaQuery.of(con).size.width / 4,
                  width: MediaQuery.of(con).size.width / 4,
                  color: Colors.grey[300],
                  child: Icon(Feather.user),
                )
          : Container(
              height: MediaQuery.of(con).size.width / 4,
              width: MediaQuery.of(con).size.width / 4,
              color: Colors.grey[300],
              child: Icon(Feather.user),
            ));

  // textfield view builder
  Widget _textfield_view(BuildContext con, text1, text2, press()) =>
      GestureDetector(
        onTap: press,
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 15),
          width: MediaQuery.of(con).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SizedBox.shrink()),
              Text(text1,
                  style: TextStyle(
                      color: Colors.black.withAlpha(160),
                      fontWeight: FontWeight.w400,
                      fontSize: 14)),
              SizedBox(height: 2),
              Text(text2, style: TextStyle(fontSize: 18)),
              Expanded(child: SizedBox.shrink()),
              myDivider(con)
            ],
          ),
        ),
      );

  Widget _empty_textfield_view(BuildContext con, text1) => Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(con).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text1,
                style: TextStyle(
                    color: Colors.black.withAlpha(160),
                    fontWeight: FontWeight.w400,
                    fontSize: 20)),
            SizedBox(height: 18),
            myDivider(con)
          ],
        ),
      );

  _open_changePhotoPage(BuildContext con) async {
    Edit_prfile_sheet.Show(context, () {
      Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ChangeProfilePhoto(cameras: widget.cam)))
          .then((value) {
        setState(() => isLoading = true);
        setState(() {
          image_url = value;
        });
        Navigator.pop(con);
        _runData();
      });
    },
        // remove function
        () {
      setState(() {
        image_url = "";
        FileService.DeleteImage();
        Navigator.pop(context);
      });
    });
    // Loading_dialog.show(context);
  }

  changedSave(BuildContext con) {
    _runData();
    // write anything else
    Navigator.of(con).pop("yes");
    // exit(con);
  }

  exit(BuildContext con) {
    Navigator.of(con).pop("yes");
  }
}
