import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/screens/widgets/tabShellWidget.dart';

import '../../cubits/navigationBarCubit.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child : Text("stores page"));
  }
}