import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './screens/ToDoScreen.dart';
import './screens/homeScreen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/todo':
        return MaterialPageRoute(builder: (_) => ToDoScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
