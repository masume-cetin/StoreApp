import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/screens/splash.dart';
import 'package:store_app/utils/theme.dart';

import 'cubits/genericCubit.dart';
import 'generated/app_localizations.dart';
import 'models/authModels/userModel.dart';
import 'models/generic/apiResponseWrapper.dart';

void main() {
  runApp(
      BlocProvider<ApiCubit<ApiResponse<User>>>( // ✅ this is correct
        create: (_) => ApiCubit<ApiResponse<User>>(),
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: buildAppTheme(),
      home: const GradientSplashScreen(),
    );
  }
}
