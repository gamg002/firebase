import "package:flutter/material.dart";
import 'package:flutter_application_2/login.dart';

import 'package:flutter_application_2/register.dart';
import 'package:flutter_application_2/router.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State {
  @override
  Widget build(BuildContext inContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: login(),
    );
  }
}
