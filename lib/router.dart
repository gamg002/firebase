import 'package:flutter/material.dart';
import 'package:flutter_application_2/home.dart';
import 'package:flutter_application_2/login.dart';
import 'package:flutter_application_2/register.dart';

final Map<String, WidgetBuilder> routes = {
  '/register': (BuildContext context) => register(),
  '/login': (BuildContext context) => login(),
  '/home': (BuildContext context) => home(),
};
