import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/home_paga.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/widgets/sign_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _initiNotification();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, Home().id);
    });
  }

  _initiNotification() {
    messaging.requestPermission(sound: true, alert: true, badge: true);
    messaging.getToken().then((token) {
      assert(token != null);
      print("my token = $token");
      Prefs.SaveFCM(token!);
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
              Color.fromARGB(255, 252, 175, 69), //#fcaf45
              Color.fromARGB(255, 245, 96, 63), //#f5603f
            ])),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                child: Text("Instagram",
                    style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontFamily: 'Billbong_family')),
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
