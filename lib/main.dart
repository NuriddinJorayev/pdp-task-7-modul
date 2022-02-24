// ignore_for_file: must_be_immutable

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/gallery.dart';
import 'package:flutter_myinsta/pages/home_paga.dart';
import 'package:flutter_myinsta/pages/my_profile_page.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/pages/signup_page.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox("hive0");
  await SharedPreferences.getInstance();  
  await availableCameras();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  var con_empty = PageController();
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isSigned(),
      routes: {
        SignInPage().id : (context) => SignInPage(),
        SignUpPage().id : (context) => SignUpPage(),
        GelleryPage().id : (context) => GelleryPage(),
        MyProfilePage( settting_control: con_empty).id : (context) => MyProfilePage( settting_control: con_empty),
        Home().id : (context) => Home(),
      },
    );
  }
  
  Widget isSigned()=> StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, Snapshot) {
        if (Snapshot.hasData) {
          Prefs.Save(Snapshot.data!.uid);
          return Home();
        }
        return SignInPage();
      },
    );
  
}