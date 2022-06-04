import 'package:flutter/material.dart';
import 'package:some_in_one/screens/five.dart';
import 'package:some_in_one/screens/four.dart';
import 'package:some_in_one/screens/pomodoro_screen.dart';
import 'package:some_in_one/screens/expense_tracker.dart';
import 'package:some_in_one/screens/calculator_screen.dart';

class Routes {
  static final Map<String, Widget Function(BuildContext)> routes = {
    '/pomodoro': (context) => PomodoroScreen(),
    '/calculator': (context) => Calculator(),
    '/expense_tracker': (context) => ExpenseTracker(),
    '/four': (context) => const Four(),
    '/five': (context) => const Five(),
  };
}
