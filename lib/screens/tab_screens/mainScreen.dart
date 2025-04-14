import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/screens/widgets/tabShellWidget.dart';

import '../../cubits/navigationBarCubit.dart';
import '../../cubits/searchBarCubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return BlocBuilder<SearchCubit, String>(
      builder: (context, searchQuery) {
       /* final filteredItems = allItems
            .where((item) => item.name.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();

        return ListView(
          children: filteredItems.map((item) => ListTile(title: Text(item.name))).toList(),
        );*/
        return const Center(child : Text("main page"));
      },

    );

  }
}
