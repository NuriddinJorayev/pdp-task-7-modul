import 'package:flutter/material.dart';

class Test_page extends StatefulWidget {
  const Test_page({Key? key}) : super(key: key);

  @override
  State<Test_page> createState() => _Test_pageState();
}

class _Test_pageState extends State<Test_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          height: 50,
          width: 100,
          child: ElevatedButton(
            onPressed: () {},
            child: Text("data"),
          ),
        ),
      ),
    );
  }
}
