import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Congrats extends StatefulWidget {
  const Congrats({super.key});
  static const String routeName = "/Congrats";

  @override
  State<Congrats> createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CONGRATULATIONS"),
      ),
      body: Container(
        padding: EdgeInsets.all(128),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Your AFL is Congrats!")
          ],
        ),
      ),
    );
  }
}