import 'dart:io';
import 'dart:async';
// import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email/views/congrats.dart';
import 'package:flutter_email/views/sendmail.dart';
// import 'package:flutter_email/services/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:email_validator/email_validator.dart';
import 'package:uni_links/uni_links.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyEmail());
}
class MyEmail extends StatefulWidget {
  MyEmail({super.key});

  @override
  State<MyEmail> createState() => _MyEmailState();
}
  
class _MyEmailState extends State<MyEmail>{
  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
}
  

Uri? _initialUri;
Uri? _latestUri;
Object? _err;
StreamSubscription? _sub;
final _scaffoldKey = GlobalKey();
bool _initialUriIsHandled = false;

  void _handleIncomingLinks(){
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        print('got uri: $uri');
        setState(() {
          _latestUri = uri;
          _err = null;
        });
      }, 
      onError: (Object err) {
        print('got err: $err');
        setState(() {
          _latestUri = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
          Navigator.pushAndRemoveUntil<dynamic>(context, MaterialPageRoute<dynamic>(builder: (context) =>Congrats()),
          (route) => false);
        }
        setState(() => _initialUri = uri);
      } on PlatformException {
        print('failed to get initial uri');
      } on FormatException catch (err) {
        print('malformed initial uri' + err.toString());
        setState(() => _err = err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Sendmail(),
      routes: {
        Congrats.routeName: (context) => const Congrats(),
      },
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

