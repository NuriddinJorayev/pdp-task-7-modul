import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';

class TextfieldPageOne extends StatefulWidget {
  final Widget? fierstWidget ;
  final Widget? lastWidget ;
  final String name;
  const TextfieldPageOne({Key? key, required this.name,  this.fierstWidget,  this.lastWidget}) : super(key: key);

  @override
  _TextfieldPageOneState createState() => _TextfieldPageOneState();
}

class _TextfieldPageOneState extends State<TextfieldPageOne> {
  var text_con = TextEditingController();
    static const IconData tik_icon = IconData(0xe156, fontFamily: 'MaterialIcons');

  Future<bool> popscope()async{
    Navigator.pop(context);
    return false;
  }
  @override
  void initState() {
   text_con.text = widget.name;
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
          onTap: (){
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
          height: allsize.height,
          width: allsize.width,
          child: SingleChildScrollView(
            child: Column(
              children: [    
                widget.fierstWidget?? SizedBox.shrink(),         
                // textfield
                Container(
                  height: 50,
                  width: allsize.width - 30,
                  child: TextField(                                     
                    controller: text_con,
                    autofocus: true,
                    cursorColor: Colors.teal,
                    cursorWidth: 2,
                    cursorHeight: 26,              
                    
                    style: TextStyle(                          
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      label: Text("Name",
                    style: TextStyle(
                        color: Colors.black.withAlpha(160),
                        fontWeight: FontWeight.w600,
                        fontSize: 19)),                     
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      
                      ),
                  ),
                ),
                // divider
                Container(
                  margin: EdgeInsets.symmetric(vertical: 2),
                  height: .8,
                  width: double.infinity,
                  color: Colors.grey),
                  widget.lastWidget ?? SizedBox.shrink()
                
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
