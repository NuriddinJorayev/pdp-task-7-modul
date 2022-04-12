import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_myinsta/pages/gallery.dart';
import 'package:flutter_myinsta/pages/home_paga.dart';
import 'package:flutter_myinsta/pages/my_profile_page.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/pages/signup_page.dart';
import 'package:flutter_myinsta/pages/splash_page.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/utils/send-notification.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initandroidsetting = AndroidInitializationSettings("@mipmap/ic_launcher");
  var initIossetting = IOSInitializationSettings();
  var initSetting =
      InitializationSettings(android: initandroidsetting, iOS: initIossetting);
  await FlutterLocalNotificationsPlugin().initialize(initSetting);
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox("hive0");

  await SharedPreferences.getInstance();
  await availableCameras();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var con_empty = PageController();

  _initi_notification() {
    FirebaseMessaging.onMessage.listen((event) async {
      await Sendnotification.local_notifivvation(
          event.notification!.title!, event.notification!.body!);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      await Sendnotification.local_notifivvation(
          event.notification!.title!, event.notification!.body!);
    });
  }

  @override
  void initState() {
    super.initState();
    _initi_notification();
  }

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
        SignInPage().id: (context) => SignInPage(),
        SignUpPage().id: (context) => SignUpPage(),
        GelleryPage().id: (context) => GelleryPage(),
        MyProfilePage(settting_control: con_empty).id: (context) =>
            MyProfilePage(settting_control: con_empty),
        Home().id: (context) => Home(),
      },
    );
  }

  Widget isSigned() => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, Snapshot) {
          if (Snapshot.hasData) {
            Prefs.Save(Snapshot.data!.uid);
            return SplashPage();
            // return Feed_Video(
            //   appbar_title: "Reela",
            //   likes: "152",
            //   comments: [2, 1, 2, 3, 7],
            //   user_image: "",
            //   caption: 'caption',
            //   user_name: '9beatz._',
            //   video_url:
            //       'https://cdn.videvo.net/videvo_files/video/free/2015-09/large_watermarked/guitar_on_fingers_stock_preview.mp4',
            // );
          }
          return SignInPage();
        },
      );
}
