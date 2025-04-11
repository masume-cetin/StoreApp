import 'package:flutter/material.dart';
import 'package:store_app/screens/widgets/baseContainerWidget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:PageWrapper(centerContent: false, child: Center(child: Text("Logged In"),))
    );
  }
}
