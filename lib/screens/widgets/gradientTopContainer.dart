import 'package:flutter/material.dart';

class GradientTopContainer extends StatelessWidget {
  const GradientTopContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 0,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          gradient: LinearGradient(
            colors: [
              Colors.amberAccent,
              Colors.amber,
            ], // Gradient colors for the top area
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
