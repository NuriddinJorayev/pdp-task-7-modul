
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/home_paga.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/services/auth_service.dart';
import 'package:flutter_myinsta/utils/flutter_toast.dart';
import 'package:flutter_myinsta/widgets/outline_button.dart';
import 'package:flutter_myinsta/widgets/sign_text.dart';
import 'package:flutter_myinsta/widgets/textfields.dart';

class SignUpPage extends StatefulWidget {
  final String id = "sign_up_Page";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var e_control = TextEditingController();
  var p_control = TextEditingController();
  var f_control = TextEditingController();
  var c_control = TextEditingController();
  bool isLoading  = false;
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
          child:Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Instagram",
                            style: TextStyle(
                                fontSize: 45,
                                color: Colors.white,
                                fontFamily: 'Billbong_family')),
                        SizedBox(height: 20.0),
                        MyTextFields(
                          text: "Fullname",
                          control: f_control,
                        ),
                        SizedBox(height: 10.0),
                        MyTextFields(
                          text: "Email",
                          control: e_control,
                        ),
                        SizedBox(height: 10.0),
                        MyTextFields(
                          text: "Password",
                          control: p_control,
                        ),
                        SizedBox(height: 10.0),
                        MyTextFields(
                          text: "Confirm Password",
                          control: c_control,
                        ),
                        SizedBox(height: 10.0),
                        MyOutLineButoon(
                            onPressed: () {
                             if(e_control.text.trim().isNotEmpty && p_control.text.trim().isNotEmpty &&
                              f_control.text.trim().isNotEmpty && c_control.text.trim().isNotEmpty ) {
                                if(p_control.text.trim().compareTo(c_control.text.trim())== 0){
                                  // do sing up function
                                  if(p_control.text.trim().length >=8){
                                    _doSignUp(e_control.text.trim(), p_control.text.trim());
                                  }else{
                                    FlutterToastWidget.build(context, "You must enter at least 8 characters", 4);
                                  }
                                }
                                //password with confirm password is not equal
                                else{
                                  FlutterToastWidget.build(context, "Confirm Password isn't equal Password", 4);
                                }
                              }
                              // same fileds is empty
                              else{
                                FlutterToastWidget.build(context, 
                                f_control.text.trim().isEmpty ? "Fullname is empty" : 
                                e_control.text.trim().isEmpty ? "Email is empty" : 
                                p_control.text.trim().isEmpty ? "Password is empty" : 
                                c_control.text.trim().isEmpty ? "Confirm Pasword is empty" : ""
                                , 4);
                              }
                            },
                            textname: "Sign Up")
                      ],
                    ),
                  ),
                  MySignText(
                    firstText: "Allready have an account?",
                    lastText: "Sing in",
                    onpressed: _signTextPress,
                  ),
                  SizedBox(height: 20.0)
                ],
              ),
              isLoading? Center(child: CircularProgressIndicator(),) : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  _doSignUp(String email, String password) async{
    var email_vaidation = RegExp(r"^[A-z0-9.A-z0-9.!$%&'*+-/=?^_`{|}~]+@(g|e|G|E)mail+\.[A-z]+").hasMatch(email);
    var password_vaidation = RegExp(r"^(?=.*[0-9])(?=.*[A-Z])(?=.*[.!#$@%&'*+/=?^_`{|}~-]).{8,}$").hasMatch(password);
    // ignore: unused_local_variable
    var userid = await FirebaseAuth.instance.currentUser;
        if(email_vaidation && password_vaidation){
          setState(() {
            isLoading = true;
          });

          AuthService.AuthSignUp(email, password).then((value) {
            value.compareTo("The password provided is too weak")==0 ? {
              FlutterToastWidget.build(context, "The password provided is too weak", 4)
            } : 
            value.compareTo("email-already-in-use")==0 ? {
              FlutterToastWidget.build(context, "email-already-in-use", 4)
            } : 
             value.isNotEmpty? {
              FlutterToastWidget.build(context, "Successfully registered", 4),
              Navigator.of(context).pushReplacementNamed(Home().id)
               
             } : {
              FlutterToastWidget.build(context, "something error", 4)
             };
            setState(() {
            isLoading = false;
          });

          });
        }else{
          FlutterToastWidget.build(context, 
          !email_vaidation ? "Check your Email, something get wrong" : 
           "Check your Email password, samething get wrong", 4);
        
        }

      
  }

  _signTextPress() {
    Navigator.pushNamed(context, SignInPage().id);
  }
}
