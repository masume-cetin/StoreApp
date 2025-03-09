import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/theme.dart';
import 'authentication_screens/login.dart';

class GradientSplashScreen extends StatefulWidget {
  const GradientSplashScreen({super.key});

  @override
  State<GradientSplashScreen> createState() => _GradientSplashScreenState();
}

class _GradientSplashScreenState extends State<GradientSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 3 seconds (you can change the duration)
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Set the gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber, Colors.amberAccent], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO : maybe a logo here
              // Optional Text under the logo
              Text(
                'Company',
                style: headlineTextStyle.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
