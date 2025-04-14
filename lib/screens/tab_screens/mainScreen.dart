import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/screens/widgets/tabShellWidget.dart';

import '../../cubits/navigationBarCubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child : Text("main page"));
  }
}
