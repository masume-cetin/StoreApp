
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/providers/category_provider.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
    backgroundColor: Colors.white,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const DrawerHeader(child: Text("Fate")),
  ..._buildCategories(context)
],
),
);
  }
  List<ListTile> _buildCategories(BuildContext context){
    List<ListTile> menu = [];
    final provider = context.read<CategoryProvider>();
    for (var element in provider.category) {
      menu.add(ListTile(
          title: Text(element.name),
          onTap: (){
           // context.read<NavigationCubit>().selectTab(element.index);
          }));
    }
    return menu;
  }

}
