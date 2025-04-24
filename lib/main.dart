import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:store_app/screens/splash.dart';
import 'package:store_app/utils/theme.dart';

import 'cubits/generic_cubit.dart';
import 'cubits/navigation_bar_cubit.dart';
import 'cubits/search_bar_cubit.dart';
import 'generated/app_localizations.dart';
import 'models/authModels/user_model.dart';
import 'models/generic/api_response_wrapper.dart';
import 'models/resourceModels/resource_item_model.dart';
import 'providers/resource_bundle_provider.dart'; // You'll need to create this file if not yet

void main() async {
  final resourceProvider = ResourceBundleProvider();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => resourceProvider),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ApiCubit<ApiResponse<ResourceItem>>>(
            create: (_) => ApiCubit<ApiResponse<ResourceItem>>(),
          ),
          BlocProvider<ApiCubit<ApiResponse<List<ResourceItem>>>>(
            create: (_) => ApiCubit<ApiResponse<List<ResourceItem>>>(),
          ),
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
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
