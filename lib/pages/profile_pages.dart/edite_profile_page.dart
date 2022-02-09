
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/functions/page_opener_push.dart';
import 'package:flutter_myinsta/models/temp_local_data.dart';
import 'package:flutter_myinsta/pages/profile_pages.dart/change_profile_photo_page.dart';
import 'package:flutter_myinsta/widgets/dialog/loading.dart';
import 'package:flutter_myinsta/widgets/sheets/edit_profile_sheet.dart';

class EditeProfilePage extends StatefulWidget {
  final cam;
   EditeProfilePage({ Key? key, this.cam }) : super(key: key);

  @override
  State<EditeProfilePage> createState() => _EditeProfilePageState();
}

class _EditeProfilePageState extends State<EditeProfilePage> {
  
  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){exit(context);}, icon: Icon(Feather.x, color: Colors.black, size: 30,)),
        title: Text("Edit Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: .8),),
        actions: [
           IconButton(
                onPressed: () { changedSave(context); },
                icon: Icon(IconData(0xe156, fontFamily: 'MaterialIcons'),
                  color: Colors.blue[700],
                ))
        ],
        elevation: 0,
       ),
      body: Container(
        height: allsize.height,
        width: allsize.width,
        child: Column(
          children: [
            SizedBox(height: 10),
            GestureDetector(
              onTap: ()=> _open_changePhotoPage(context),
              child: _user_image(context, TempLocatData.image_url)),
            SizedBox(height: 10),
            GestureDetector(
              onTap: ()=> _open_changePhotoPage(context),
              child: Text("Change profile photo", style: TextStyle(color: Colors.blue[700], fontSize: 22, height: 1.5))),
            SizedBox(height: allsize.height / 30),
            _textfield_view(context, "Name", "Nuriddin Jorayev"),
            SizedBox(height: allsize.height / 30),
            _textfield_view(context, "Username", "NuriddinJorayev19"),
            SizedBox(height: allsize.height / 30),
            _empty_textfield_view(context, "Pronouns"),
            SizedBox(height: allsize.height / 30),
            _empty_textfield_view(context, "Website"),
            SizedBox(height: allsize.height / 30),
            _textfield_view(context, "Bio", "The day is the best day"),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    SizedBox(height: 20),
                    Divider(color: Colors.grey, thickness: 1,),
                     Padding(
                       padding: const EdgeInsets.only(left: 15),
                       child: Text("Switch to Professional account", style: TextStyle(color: Colors.blue[700], fontSize: 19, height: 1.5)),
                     ),
                    Divider(color: Colors.grey, thickness: 1,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Divider(color: Colors.grey, thickness: 1,),
                         Container(
                           margin: EdgeInsets.all(5),
                           padding: EdgeInsets.only(left: 10),
                           child: Text("Personal information settings", style: TextStyle(color: Colors.blue[700], fontSize: 20, height: 1.5)),
                         ),
                    Divider(color: Colors.grey, thickness: 1,),
                      ],
                    ),
                   

                  ],
                ),
              ),
            )
            
          ],
        ),
              
      ),
    );
  }

  Widget myDivider(BuildContext con)=>Container(
    width: MediaQuery.of(con).size.width,
    height: 1,
    color: Colors.grey,
  );

    // circle image builder
  Widget _user_image(BuildContext con, String url)=>ClipRRect(
    borderRadius: BorderRadius.circular(MediaQuery.of(con).size.width / 4),
    child:url != null ? Image(
    height: MediaQuery.of(con).size.width / 4,
    width: MediaQuery.of(con).size.width / 4,
    fit: BoxFit.fill,
    image:  FileImage(File(url)),

  ) : Container(
     height: MediaQuery.of(con).size.width / 4,
    width: MediaQuery.of(con).size.width / 4,
    color: Colors.grey[300],
    child: Icon(Feather.user),
  )

  );

  // textfield view builder
  Widget _textfield_view(BuildContext con,text1, text2)=>Container(
    margin: EdgeInsets.symmetric(horizontal: 15),
    width: MediaQuery.of(con).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text1, style: TextStyle(color: Colors.black.withAlpha(160), fontWeight: FontWeight.w400, fontSize: 15)), 
        SizedBox(height: 5),
        Text(text2, style: TextStyle(fontSize: 19)), 
        SizedBox(height: 8),
        myDivider(con)   
      ],
    ),
  );

  Widget _empty_textfield_view(BuildContext con,text1)=>Container(
    margin: EdgeInsets.symmetric(horizontal: 15),
    width: MediaQuery.of(con).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text1, style: TextStyle(color: Colors.black.withAlpha(160), fontWeight: FontWeight.w400, fontSize: 20)), 
        SizedBox(height: 18),
        myDivider(con)   
      ],
    ),
  );

  _open_changePhotoPage(BuildContext con)async{
     Navigator.push(context, MaterialPageRoute(builder: (_)=>ChangeProfilePhoto(cameras: widget.cam))).then((value){
       setState(() {
         
       });
     });
   
      // Edit_prfile_sheet.Show(context);
      // Loading_dialog.show(context);
  }

  changedSave(BuildContext con){
    // write anything else
    Navigator.of(con).pop("yes");
    // exit(con);
  }
  exit(BuildContext con){
    Navigator.of(con).pop("yes");
  }
}