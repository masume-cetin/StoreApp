import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

abstract class BaseState<T extends BasePage> extends State<T> {
  double width = 0.0;
  double height = 0.0;

  @override
  void initState() {
    super.initState();
    // Delay access to MediaQuery by using post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateScreenSize();
    });
  }

  void _updateScreenSize() {
    final screenSize = MediaQuery.of(context).size;
    setState(() {
      width = screenSize.width;
      height = screenSize.height;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // You can add logic here for dependencies that may change, if needed
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Abstract method for child widgets to override with their UI content
  //Widget buildPageContent(BuildContext context);

  // Loader or common widgets can be added here if needed
  Widget loader() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 28.0),
      child: SizedBox.square(
        dimension: 40.0,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
