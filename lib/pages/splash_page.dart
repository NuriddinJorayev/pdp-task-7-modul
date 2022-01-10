import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/widgets/sign_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, SignInPage().id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var allSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: allSize.height,
        width: allSize.width,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 252, 175, 69),
              Color.fromARGB(255, 245, 96, 63),
            ])),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                child: Text("Instagram", style: TextStyle(fontSize: 45, color: Colors.white, fontFamily: 'Billbong_family')),
              ),
            ),
            MySignText(firstText: '', lastText: "All rights reserved"),
           SizedBox(height: 20.0)
          ],
        ),
      ),
    );
  }
}
