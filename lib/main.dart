import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/screens/splash.dart';
import 'package:store_app/utils/theme.dart';

import 'cubits/generic_cubit.dart';
import 'cubits/navigation_bar_cubit.dart';
import 'cubits/search_bar_cubit.dart';
import 'generated/app_localizations.dart';
import 'models/authModels/user_model.dart';
import 'models/generic/api_response_wrapper.dart';

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
