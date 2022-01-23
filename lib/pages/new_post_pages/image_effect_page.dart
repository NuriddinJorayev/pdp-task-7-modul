import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_myinsta/models/effect_list.dart';
import 'package:flutter_myinsta/pages/new_post_pages/last_post_page.dart';

class Image_effect_page extends StatefulWidget {
  final File image_file; 
  const Image_effect_page({Key? key, required this.image_file}) : super(key: key);

  @override
  _Image_effect_pageState createState() => _Image_effect_pageState();
}

class _Image_effect_pageState extends State<Image_effect_page> {

  List l = ["Normal","Clarendon","Gingham","Moon","Lark","Reyes","juno","Slumber","Crema",
  "Ludwing","Aden","Perpetua","Amora","Rise","Valencia","x-Pro II","Sierra","Willow","Lo_Fi","Inkwell","Nashville"];
  bool isselect = false;
  var _base_colorFilter ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _base_colorFilter = Effect_list.ListColorFilter[0];
  }



  @override
  Widget build(BuildContext context) {
    var allsize = MediaQuery.of(context).size;
    return Scaffold(
      // app bar start 
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              AntDesign.arrowleft,
              color: Colors.black,
              size: 30,
            )),
        centerTitle: true,
        title: Icon(
          FontAwesome.magic,
          color: Colors.black,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Last_post_Page(file_image: widget.image_file,)));
              },
              icon: Icon(
                AntDesign.arrowright,
                color: Colors.blue,
                size: 30,
              )),
        ],
      ),
       // app bar finish
      body: Column(
        children: [
          Container(
            height: (allsize.height / 2),
            child: ColorFiltered(
              colorFilter:  _base_colorFilter,
              child: Image.file(widget.image_file, fit: BoxFit.cover, width: double.infinity,),
            
            ),
          ),
          // effects panel
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                      child: Row(
                        children: l.map((e)=> Effect_items(e, Effect_list.ListColorFilter[l.indexOf(e)])).toList(),
                      ),
                    ),
                  ),
                ),
                ]
            ),
          )
        ],
      ),
    
   
    bottomNavigationBar: Container(
      height: 50,
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(child: GestureDetector(
            onTap: ()=> select_changeer(false),
            child: Container(
              height: 45,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Filter"),
                  SizedBox(height: 5),
                  Container(height: 1, color: isselect? Colors.white : Colors.black),
                ],
              ),
            ),
          )),
          Expanded(child: GestureDetector(
            onTap: ()=> select_changeer(true),
            child: Container(
               height: 45,
              color: Colors.white,
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Edit"),
                  SizedBox(height: 5),
                  Container(height: 1, color: !isselect? Colors.white : Colors.black),
                ],
              ),
            ),
          )),         
        ],
      ),
    ),
    );
  }
  // isselect change
  select_changeer(bool b){   
   
    setState(() {     
        isselect = b;     
    });
  }

  // build effect items 
  Widget Effect_items(String name,  _color){ 
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(name ),
       GestureDetector(
         onTap: (){
           setState(() {
             _base_colorFilter = _color;
           });
         },
         child: Container(
           height: MediaQuery.of(context).size.height / 8,
           width: (MediaQuery.of(context).size.width / 3.5) - 16,
             color: Colors.amber,
             margin: EdgeInsets.all(8),
             child:  ColorFiltered(
                 colorFilter: _color,
                 child: Image.file(widget.image_file, fit: BoxFit.cover, width: double.infinity,), ),
           
         ),
       ),
    ],
  );}

}
