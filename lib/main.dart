import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        textTheme: TextTheme(
          displayLarge: GoogleFonts.mulish(),
          displayMedium: GoogleFonts.firaSans(),
        ),
      ),
      initialRoute: '/home',
      onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
    );
  }
}
