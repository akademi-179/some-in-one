import 'package:flutter/material.dart';
import 'package:some_in_one/screens/five.dart';
import 'package:some_in_one/screens/four.dart';
import 'package:some_in_one/screens/one.dart';
import 'package:some_in_one/screens/three.dart';
import 'package:some_in_one/screens/two.dart';

class Routes{
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/one': (context) => const One(),
    '/two': (context) => const Two(),
    '/three': (context) => const Three(),
    '/four': (context) => const Four(),
    '/five': (context) => const Five(),
  };
}