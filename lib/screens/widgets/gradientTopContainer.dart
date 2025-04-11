import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class GradientTopContainer extends StatelessWidget {
  const GradientTopContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height/17,
        decoration:const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
          ),
          gradient: LinearGradient(
            colors: [
              secondaryColor,
              primaryColor,
            ], // Gradient colors for the top area
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      );
  }
}
