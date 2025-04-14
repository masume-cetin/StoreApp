import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/screens/splash.dart';
import 'package:store_app/utils/theme.dart';

import 'cubits/genericCubit.dart';
import 'cubits/navigationBarCubit.dart';
import 'cubits/searchBarCubit.dart';
import 'generated/app_localizations.dart';
import 'models/authModels/userModel.dart';
import 'models/generic/apiResponseWrapper.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ApiCubit<ApiResponse<User>>>(
          create: (_) => ApiCubit<ApiResponse<User>>(),
        ),
        BlocProvider<NavigationCubit>(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider(create: (_) => SearchCubit()),
      ],
      child: const MyApp(),
    ),
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
