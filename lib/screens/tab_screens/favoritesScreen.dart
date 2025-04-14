import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/screens/widgets/tabShellWidget.dart';

import '../../cubits/navigationBarCubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child : Text("favorites page"));
  }
}