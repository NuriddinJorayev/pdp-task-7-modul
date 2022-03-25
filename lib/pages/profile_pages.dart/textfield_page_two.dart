// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class TextfieldPageTwo extends StatefulWidget {
  final Widget? fierstWidget;
  final Widget? lastWidget;
  final String name;
  final textInputFormat;
  final bool? isBio;

  const TextfieldPageTwo(
      {Key? key,
      required this.name,
      this.fierstWidget,
      this.lastWidget,
      required this.textInputFormat,
      this.isBio})
      : super(key: key);

  TextfieldPageTwo get() => _TextfieldPageTwoState().widget.get();

  @override
  _TextfieldPageTwoState createState() => _TextfieldPageTwoState();
}

class _TextfieldPageTwoState extends State<TextfieldPageTwo> {
  var text_con = TextEditingController();
  int fix = 0;
    static const IconData tik_icon = IconData(0xe156, fontFamily: 'MaterialIcons');

  Future<bool> popscope() async {
    Navigator.pop(context);
    return false;
  }

  @override
  void initState() {
    text_con.text = widget.name;
    var v = (widget.isBio?? false);
     fix =  v ? 15 : 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        // cancle button
        leading: GestureDetector(
            onTap: () {
              popscope();
            },
            child: Icon(Feather.x, color: Colors.black, size: 32)),
        title: Text("Name",
            style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w900,
                letterSpacing: .9)),
        actions: [
          // ok button
          IconButton(
              onPressed: () {
                Navigator.pop(context, text_con.text.trim());
              },
              icon: Icon(tik_icon,
                color: Colors.blue[600],
                size: 30,
              ))
        ],
      ),
      //body
      body: WillPopScope(
        onWillPop: popscope,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: allsize.height ,
          width: allsize.width,
          child: Column(
            children: [
              widget.fierstWidget ?? SizedBox.shrink(),
              // textfield
              widget.isBio != null && fix == 15 ? Expanded(
                flex: fix,
                child: textfieldBuilder(allsize, true)) : 
              Container(
                width: allsize.width - 30,
                height: 40,
                child: textfieldBuilder(allsize, true)
                ),

              // divider
              Container(
                  height: .8,
                  width: double.infinity,
                  color: Colors.lightBlue[900]),

              widget.isBio != null
                  ? Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              width: double.infinity,
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(.6),
                                child: Text(
                                    (150 - text_con.text.length).toString()),
                              ))
                        ],
                      ),
                    )
                  : Expanded(child: widget.lastWidget ?? SizedBox.shrink())
            ],
          ),
        ),
      ),
    );
  }

  Widget textfieldBuilder(allsize, bool auto) => Container(
    height: 30,
        width: allsize.width - 30,
        child: TextField(
          autofocus: auto,
          onTap: (){
            setState(() {
              fix = 15;
            });
          },
          onChanged: (s) {
            setState(() {
             if(s.isNotEmpty){
               fix = 15;
             }
             else
             fix = 1;
            });
          },
          inputFormatters: [widget.textInputFormat],
          controller: text_con,
          minLines: widget.isBio != null ? 1 : null,
          maxLines: widget.isBio != null ? 150 : null,
          cursorColor: Colors.teal,
          cursorWidth: 2,
          cursorHeight: 20,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
          ),
        ),
      );
}
