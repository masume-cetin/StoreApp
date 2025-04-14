import 'dart:async';

import 'package:flutter/foundation.dart';
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
            colors: [secondaryColor, primaryColor], // Gradient colors
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
              Container(
                width: kIsWeb ? 400 : 200,
                height: kIsWeb ? 400 : 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:  Image.asset(
                      'assets/images/brandLogo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
