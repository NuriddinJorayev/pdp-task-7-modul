import 'package:flutter/material.dart';
import 'package:flutter_myinsta/pages/signin_page.dart';
import 'package:flutter_myinsta/widgets/outline_button.dart';
import 'package:flutter_myinsta/widgets/sign_text.dart';
import 'package:flutter_myinsta/widgets/textfields.dart';

class SignUpPage extends StatefulWidget {
  final String id = "sign_up_Page";
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
   var e_control = TextEditingController();
  var p_control = TextEditingController();
  var f_control = TextEditingController();
  var c_control = TextEditingController();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text("Instagram", style: TextStyle(fontSize: 45, color: Colors.white, fontFamily: 'Billbong_family')),
                SizedBox(height: 20.0),
                MyTextFields(text: "Fullname", control: f_control,),
                SizedBox(height: 10.0),
                MyTextFields(text: "Email", control: e_control,),
                SizedBox(height: 10.0),
                MyTextFields(text: "Password", control: p_control,),
                SizedBox(height: 10.0),
                MyTextFields(text: "Confirm Password", control: c_control,),
                SizedBox(height: 10.0),
                MyOutLineButoon(onPressed: (){}, textname: "Sign Up")
                  ],
                ),
              ),
              MySignText(firstText: "Allready have an account?", lastText: "Sing in", onpressed: _signTextPress,),
              SizedBox(height: 20.0)            
      
            ],
          ),
        ),
      ),
    );
  }
  _signTextPress(){
    Navigator.pushNamed(context, SignInPage().id);
  }
}