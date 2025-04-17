
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
    backgroundColor: Colors.white,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
DrawerHeader(child: Text("Fate")),
ListTile(title: Text("Home")),
ListTile(title: Text("Shop")),
ListTile(title: Text("About")),
],
),
);
  }
}
