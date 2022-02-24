import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/services/auth_service.dart';
import 'package:flutter_myinsta/services/hive_db.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';

class LogoutDialog {
  static show(BuildContext context) {
    showDialog(
        context: context,
        builder: (con) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              insetPadding: EdgeInsets.symmetric(horizontal: 80),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                height: 200,
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 30),
                    _text_builder("Log out of"),
                    SizedBox(height: 5),
                    _text_builder("Instagram?"),
                    SizedBox(height: 30),
                    _myDivider(),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: ()async{
                            AuthService.AuthSignOut();
                            Prefs.Delete();
                            var id  = await Prefs.Load();
                            Hive_db.Delete(id);
                              Navigator.pop(con);
                        Navigator.of(context).pushReplacementNamed(SignInPage().id);
                        
                        

                          },
                          child: _colorly_text_builder("Log out", Colors.blue)),
                      ),
                    ),
                    
                    _myDivider(),
                    Expanded(
                      child: Material(                        
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),                            
                            ),
                          onTap: (){
                            Navigator.pop(con);
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Cancel",
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ),
                
                   
                  ],
                ),
              ),
            ));
  }

  static Widget _myDivider() => Container(
        height: 1,
        width: double.infinity,
        color: Colors.grey,
      );
  static Widget _text_builder(s) => Container(
        alignment: Alignment.center,
        child: Text(
          s,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: .9),
        ),
      );
  static Widget _colorly_text_builder(s, [xcolor]) => Container(
        alignment: Alignment.center,
        child: Text(
          s,
          style: TextStyle(
              color: xcolor != null ? xcolor : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: .9),
        ),
      );
}
