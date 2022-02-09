import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/gallery.dart';
import 'package:flutter_myinsta/pages/home_paga.dart';
import 'package:flutter_myinsta/pages/my_profile_page.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/pages/signup_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      routes: {
        SignInPage().id : (context) => SignInPage(),
        SignUpPage().id : (context) => SignUpPage(),
        GelleryPage().id : (context) => GelleryPage(),
        MyProfilePage(userName: 'Nuriddin',).id : (context) => MyProfilePage(userName: "Nuriddin"),
        Home().id : (context) => Home(),
      },
    );
  }
}