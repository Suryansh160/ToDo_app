import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: screenHeight * 0.16),
          Center(
            child: Image.asset(
              'assets/image1.png',
              height: screenHeight * 0.4,
              width: screenWidth * 0.9,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            'Effortlessly',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: screenHeight * 0.042,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Organise Your Day',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: screenHeight * 0.042,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            'Your productivity, simplified.',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Colors.grey,
              fontSize: screenHeight * 0.024,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 0,
            runSpacing: 0,
            children: List.generate(
              4,
              (index) => Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.065),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/todo');
            },

            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.35,
                vertical: screenHeight * 0.02,
              ),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Next',
              style: TextStyle(fontSize: screenHeight * 0.02),
            ),
          ),
        ],
      ),
    );
  }
}
