import 'package:flutter/material.dart';
import 'package:store_app/utils/theme.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GradientButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [secondaryColor, primaryColor], // Gradient colors
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: outlinedFormTitleTextStyle,
        ),
      ),
    );
  }
}
