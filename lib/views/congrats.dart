import 'package:flutter/material.dart';

class Congrats extends StatefulWidget {
  const Congrats({super.key});
  // static const String routeName = "/Congrats";

  @override
  State<Congrats> createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CONGRATULATIONS"),
      ),
      body: Container(
        padding: const EdgeInsets.all(128),
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