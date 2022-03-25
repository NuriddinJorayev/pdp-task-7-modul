import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:video_player/video_player.dart';

class Feed_Video extends StatefulWidget {
  final String likes;
  final String appbar_title;
  final List comments;
  final String user_image;
  final String user_name;
  final String video_url;
  final String caption;

  const Feed_Video(
      {Key? key,
      required this.likes,
      required this.comments,
      required this.user_image,
      required this.appbar_title,
      required this.user_name,
      required this.video_url,
      required this.caption})
      : super(key: key);

  @override
  _Feed_VideoState createState() => _Feed_VideoState();
}

class _Feed_VideoState extends State<Feed_Video> {
  VideoPlayerController? con;
  bool isnoice = true;
  bool isview = false;

  @override
  void initState() {
    con = VideoPlayerController.network(widget.video_url)..initialize();
    con!.setLooping(true);
    super.initState();
    con!.play();
  }

  setvolume() {
    setState(() {
      con!.setVolume(isnoice ? 1 : 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    var appbar_size = AppBar().preferredSize.height;
    var statusbar = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 47, 45, 54),
      extendBodyBehindAppBar: true,
      body: Container(
          alignment: Alignment.center,
          height: allsize.height,
          width: allsize.width,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: statusbar),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: VideoPlayer(con!),
                    ),
                  ),
                ],
              ),

              Container(
                height: allsize.height,
                width: allsize.width,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isnoice = !isnoice;
                      isview = true;
                    });
                    setvolume();
                    await Future.delayed(Duration(seconds: 2));

                    setState(() {
                      isview = false;
                    });
                  },
                ),
              ),

              // appbar panel
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: statusbar),
                  height: 50,
                  width: allsize.width * .82,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            PhosphorIcons.arrow_left,
                            color: Colors.white,
                            size: 30,
                          )),
                      SizedBox(width: 15),
                      Text(
                        widget.appbar_title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: .5),
                      )
                    ],
                  ),
                ),
              ),
              // user all info
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: allsize.height * .20,
                  width: allsize.width,
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Colors.black.withOpacity(.5),
                        Colors.black.withOpacity(.05),
                      ])),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            user_image(widget.user_image, widget.user_name),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.caption,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.normal)),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  widget.user_name +
                                      '\u2022' +
                                      " Original Audio",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                      ),
                      // more and squer userview panel
                      SizedBox(
                        height: allsize.height * .20,
                        width: allsize.width * .18,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.more_vert_outlined,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            Squer_userImage(widget.user_image)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // center right like comment sent buttons
              Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: (allsize.height * .80) - statusbar,
                      width: allsize.width * .18,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 50,
                              child: Icon(
                                PhosphorIcons.camera,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Feather.heart,
                                  size: 30, color: Colors.white),
                              build_text(widget.likes),
                              tran_wiget(Icon(PhosphorIcons.chat_circle,
                                  size: 30, color: Colors.white)),
                              build_text(widget.comments.length.toString()),
                              Icon(Feather.send, size: 30, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: allsize.height * .20,
                    )
                  ],
                ),
              ),

              isview ? voice_view() : SizedBox.shrink(),
            ],
          )),
    );
  }

  Widget user_image(String url, String username) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: url != null
                      ? url.isNotEmpty
                          ? Image.network(url, fit: BoxFit.cover)
                          : Image.asset("assets/images/default_user.png",
                              fit: BoxFit.cover)
                      : Image.asset("assets/images/default_user.png",
                          fit: BoxFit.cover)),
            ),
            SizedBox(width: 10),
            Text(username,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800))
          ],
        ),
      );

  Widget Like_button() => GestureDetector(
        onTap: () {},
        child: Icon(Feather.heart),
      );

  build_text(String text) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 18),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 17)),
      );

  Widget Squer_userImage(String url) => Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue,
          image: url != null
              ? url.isNotEmpty
                  ? DecorationImage(image: NetworkImage(url), fit: BoxFit.fill)
                  : DecorationImage(
                      image: AssetImage("assets/images/default_user.png"),
                      fit: BoxFit.fill)
              : DecorationImage(
                  image: AssetImage("assets/images/default_user.png"),
                  fit: BoxFit.fill)));

  Widget voice_view() {
    return Center(
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: Colors.black.withOpacity(.5)),
        child: Icon(
          isnoice ? Icons.volume_up : Icons.volume_off,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget tran_wiget(Widget w) => Transform.rotate(
        angle: -1.7,
        child: w,
      );
}
