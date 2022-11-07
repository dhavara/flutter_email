import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email/views/sendmail.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyEmail());
}

class MyEmail extends StatefulWidget {
  const MyEmail({super.key});

  @override
  State<MyEmail> createState() => _MyEmailState();
}
class _MyEmailState extends State<MyEmail>{
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Sendmail()
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

