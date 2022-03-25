import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/camera_page.dart';
import 'package:flutter_myinsta/pages/gallery.dart';
import 'package:flutter_myinsta/widgets/scrol_button.dart';

class MyUploadPage extends StatefulWidget {
  final String selectText;
  const MyUploadPage({Key? key, required this.selectText}) : super(key: key);

  @override
  State<MyUploadPage> createState() => _MyUploadPageState();
}

class _MyUploadPageState extends State<MyUploadPage> {
  String select_text = "POST";
  Alignment _alignment = Alignment.bottomRight;
  PageController? scroll_conterol;

  @override
  void initState() {
    super.initState();
    scroll_conterol = PageController(
        initialPage: widget.selectText.compareTo('POST') == 0 ? 0 : 1,
        keepPage: true);
    initialize();

    setState(() {
      select_text = widget.selectText;
      if (select_text.compareTo("STORY") == 0) {
        _alignment = Alignment.bottomCenter;
      }
    });
  }

  var cam;
  initialize() async {
    cam = await availableCameras();
    if (cam != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: allsize.height,
      width: allsize.width,
      child: Stack(
        children: [
          // pages gallery, camera, live camera
          PageView(
            controller: scroll_conterol,
            physics: NeverScrollableScrollPhysics(),
            children: [
              GelleryPage(story: widget.selectText),
              cam != null
                  ? MyCameraPage(
                      alignment: _alignment,
                      select_text: select_text,
                      cameras: cam,
                      ismainPage: widget.selectText.compareTo("STORY") == 0
                          ? true
                          : false,
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
          // scrolling panel. POST, STORY, LIVE buttons
          MyScrollButtn(
              alignment: _alignment,
              select_text: select_text,
              onPressed: (String s) {
                _check_fill(s);
              })
        ],
      ),
    ));
  }

  // changer alignment when onpressed
  _check_fill(String _text) async {
    if (mounted)
      setState(() {
        select_text = _text;
        switch (_text) {
          case 'POST':
            {
              setState(() => _alignment = Alignment.bottomRight);
              go_page(0);
              break;
            }
          case 'STORY':
            {
              setState(() => _alignment = Alignment.bottomCenter);
              go_page(1);

              break;
            }
          case 'LIVE':
            {
              setState(() => _alignment = Alignment.bottomLeft);
              go_page(1);

              break;
            }
        }
      });
  }

  go_page(int index) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (scroll_conterol!.hasClients) {
        scroll_conterol!.animateToPage(index,
            duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      }
    });
  }
}
