import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/home_paga.dart';
import 'package:flutter_myinsta/pages/signup_page.dart';
import 'package:flutter_myinsta/services/auth_service.dart';
import 'package:flutter_myinsta/services/share_prefs.dart';
import 'package:flutter_myinsta/utils/flutter_toast.dart';
import 'package:flutter_myinsta/widgets/outline_button.dart';
import 'package:flutter_myinsta/widgets/sign_text.dart';
import 'package:flutter_myinsta/widgets/textfields.dart';

class SignInPage extends StatefulWidget {
  final String id = "sign_in_Page";
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var e_control = TextEditingController();
  var p_control = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print("sign in page");
  }

  @override
  Widget build(BuildContext context) {
    var allSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Instagram",
                          style: TextStyle(
                              fontSize: 45,
                              color: Colors.white,
                              fontFamily: 'Billbong_family'),
                        ),
                        SizedBox(height: 20.0),
                        MyTextFields(text: "Email", control: e_control),
                        SizedBox(height: 10.0),
                        MyTextFields(text: "Password", control: p_control),
                        SizedBox(height: 10.0),
                        MyOutLineButoon(
                            onPressed: () {
                              e_control.text.trim().isEmpty
                                  ? FlutterToastWidget.build(context,
                                      "You must enter your email address", 4)
                                  : p_control.text.trim().isEmpty
                                      ? FlutterToastWidget.build(context,
                                          "You must enter your password", 4)
                                      : _doSignin();
                            },
                            textname: "Sign In")
                      ],
                    ),
                  ),
                  MySignText(
                    firstText: "Don't have an account?",
                    lastText: "Sing Up",
                    onpressed: _signTextPress,
                  ),
                  SizedBox(height: 20.0)
                ],
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  _signTextPress() {
    Navigator.pushNamed(context, SignUpPage().id);
  }

  _doSignin() async {
    setState(() {
      isLoading = true;
    });
    var user = await AuthService.AuthSignIn(e_control.text.trim(), p_control.text.trim());
    if (user != null) {
      Prefs.Save(user.uid);
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(Home().id);
    } else {
      setState(() {
        isLoading = false;
      });
      FlutterToastWidget.build(
          context, "check email or password. something get wrong", 4);
    }
  }
}
