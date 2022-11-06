import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email/services/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:uni_links/uni_links.dart';

class Sendmail extends StatefulWidget {
  const Sendmail({Key? key}) : super(key: key);

  @override
  State<Sendmail> createState() => _SendmailState();
}

class _SendmailState extends State<Sendmail> {
  @override
  void initState() {
    super.initState();
    // _handleIncomingLinks();
    // _handleInitialUri();
  }

  final _loginKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  String _message = '';

  @override
  void dispose(){
    ctrlEmail.dispose();
    // _sub?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Email")
      ),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  labelText: "Email Receiver", prefixIcon: const Icon(Icons.email)
                ),
                controller: ctrlEmail,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return !EmailValidator.validate(value.toString())
                      ? 'Email tidak valid'
                      : null;
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          if(_loginKey.currentState!.validate()){
            await SendMailService.sendEmail(ctrlEmail.text.toString()).then((value){
            var result = json.decode(value.body);
            print(result);
            _message = result['message'].toString();
          }
          );
          Fluttertoast.showToast(msg: _message);

          }else{
            Text("Please fill the box!");
          }
          
        },
        tooltip: 'Send Email',
        child: const Icon(Icons.send),
      ),
    );
  }
}