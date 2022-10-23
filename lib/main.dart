import 'package:flutter/material.dart';
import 'package:flutter_email/views/sendmail.dart';

void main(){
  runApp(const MyEmail());
}

class MyEmail extends StatelessWidget{
  const MyEmail({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      // initialRoute: '/',
      // routes: {
      //   '/':(context) => Sendmail(),
      // }
      home: Sendmail(),
    );
  }
}

