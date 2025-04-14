import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/cubits/navigationBarCubit.dart';
import 'package:store_app/screens/widgets/tabShellWidget.dart';

class NavigationShell extends StatelessWidget {
  const NavigationShell({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationCubit>(
      create: (_) => NavigationCubit(),
      child: const TabShell(),
    );
  }
}
