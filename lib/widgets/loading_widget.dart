import 'package:flutter/material.dart';

class MyLoadingWidget extends StatelessWidget {
 final String progres_text; 
  const MyLoadingWidget({ Key? key, required this.progres_text }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox.shrink()),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,                              
          ),
          height: 60,
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.black87,
                  strokeWidth: 2,
                ),
              ),
              SizedBox(width: 20),
              Text(progres_text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: .8),
              ),
            ],
          ),
        ),
        Expanded(child: SizedBox.shrink()),
      ],
    );
  }
}