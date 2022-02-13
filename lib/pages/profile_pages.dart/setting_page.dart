
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/widgets/dialog/logout.dart';

class SettingPage extends StatefulWidget {
  final PageController settting_control;
  const SettingPage({Key? key, required this.settting_control}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isWrited = false;
  var control_textfield = TextEditingController();

  Future<bool> popscope()async{
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if(widget.settting_control.hasClients){
              widget.settting_control.animateToPage(0, duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
      }
});
 return false;
  }


  @override
  Widget build(BuildContext context) {
    var allSize = MediaQuery.of(context).size;
    return WillPopScope(      
      onWillPop: popscope,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                widget.settting_control.animateToPage(0, duration: Duration(milliseconds: 400), curve: Curves.ease);
              },
              icon: Icon(AntDesign.arrowleft, color: Colors.black)),
          title: Text("Settings",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700)),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 20),
                  height: 50,
                  width: allSize.width,
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.withOpacity(.3),
                    ),
                    // textfield
                    child: TextField(
                      onChanged: (s) {
                        setState(() {
                          isWrited = s.isNotEmpty;
                        });
                      },
                      controller: control_textfield,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .8,
                          height: 1.3),
                      cursorColor: Colors.grey[700],
                      cursorWidth: .8,
                      cursorHeight: 25,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            FlutterIcons.search_fea,
                            color: Colors.black.withAlpha(150),
                            size: 18,
                          ),
                          suffixIcon: isWrited
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      control_textfield.clear();
                                      isWrited = false;
                                    });
                                  },
                                  child: Icon(
                                    Feather.x,
                                    color: Colors.black,
                                    size: 17,
                                  ))
                              : SizedBox.shrink(),
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withAlpha(150),
                              letterSpacing: .8,
                              height: 1.19)),
                    ),
                  ),
                ),
                // items
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Transform(
                        transform: Matrix4.identity()..rotateY(9.6),
                        child: Icon(
                          Feather.user_plus,
                          size: 25,
                        ),
                        alignment: FractionalOffset.center,
                      ),
                      SizedBox(width: 12),
                      Text("Follow and invite friends",
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                base_item(FontAwesome.bell_o, "Notifications"),
                base_item(FlutterIcons.lock_oct, "Privacy"),
                base_item(Feather.shield, "Security"),
                base_item(Entypo.megaphone, "Ads"),
                base_item(Icons.account_circle_outlined, "Account"),
                base_item(Entypo.lifebuoy, "Notifications"),
                base_item(Feather.alert_circle, "Notifications"),
                base_item(Icons.color_lens_outlined, "Notifications"),
                SizedBox(height: 15),
                // meta image
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerLeft,
                  child: Image.asset('assets/images/MetaLogo.png', height: 14.5,
                  width: 80,),
                ),
          
                // blue text
                blueText("Account Centre"),
                // many text
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Control settings for connected experiences across Instagram, the Facebook app and Massenger, including story and post sharing and logging in.", style: TextStyle(fontSize: 15, color: Colors.black.withAlpha(180), letterSpacing: .8, height: 1.5),),
                ),
                SizedBox(height: 35),
                Container(
                  width: allSize.width,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Logins", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: .8),),
                ),
    
                SizedBox(height: 20),
                      // blue text
                      blueText("Add account"),
                SizedBox(height: 10),
                      // blue text
                      GestureDetector(
                        onTap: (){
                          LogoutDialog.show(context);                       
                        },
                        child: blueText("Log out")),
                         SizedBox(height: 12)
              ],
            ),
          ),
        ),
      ),
    );
  }
  // base items
  Widget base_item(icon, text) => Container(
    padding: EdgeInsets.symmetric(vertical: 14.8, horizontal: 15),
    child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           Icon(
                icon,
                size: 25,
              ),
              
            SizedBox(width: 10),
            Text(text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ],
        ),
  );

 Widget blueText(String text)=>Container(
   margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
   alignment: Alignment.centerLeft,
   child: Text(text, style: TextStyle(fontSize: 20, color: Colors.blue[600], fontWeight: FontWeight.w600),),
 );
}
