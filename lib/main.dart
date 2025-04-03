import 'package:flutter/material.dart';

import 'routes.dart';
import 'screens/homeScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
      ),
      initialRoute: '/home',
      onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
    );
  }
}
