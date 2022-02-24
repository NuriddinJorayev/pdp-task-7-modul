import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Edit_prfile_sheet {
  static Show(BuildContext context, Function() newphoto, Function() remove)async{
   if(await Permission.camera.status.isGranted){
     Permission.camera.request();
   }
    showModalBottomSheet(      
      context: context, 
      backgroundColor: Colors.transparent,
      builder: (con)=>Column(
      children: [
        Expanded(child: SizedBox.shrink()),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),

            color: Colors.white
          ),
          child: Column(
            children: [
                  longButton(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Text("Change profile photo", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: .8),),
                  ),
                  Container( 
                    margin: EdgeInsets.symmetric(vertical: 5),
                    color: Colors.grey, width: double.infinity, height: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                       Textbuild("New Profile Photo", newphoto),
                        SizedBox(height: 20),
                       Textbuild("Import From Facebook", () {}),
                        SizedBox(height: 20),
                       Textbuild("Remove prfile photo", remove, Colors.red),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ));
  }

  static Widget Textbuild(text, Function() press, [color])=>GestureDetector(
    onTap: press,
    child: Container(
      color: Colors.white,
      child: Text(text, style: TextStyle(
        color: color != null? color :  Colors.black, 
        fontSize: 18, 
        fontWeight: FontWeight.w400,
         letterSpacing: .8
      )),
    ),
  );

  static Widget longButton()=>Container(
    height: 5,
    width: 40,
    margin: EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
    color: Colors.grey[800],
      borderRadius: BorderRadius.circular(10)
    ),
  );
}