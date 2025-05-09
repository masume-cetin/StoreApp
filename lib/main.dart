import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:store_app/providers/category_provider.dart';
import 'package:store_app/screens/splash.dart';
import 'package:store_app/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // auto-generated
import 'package:generic_services_package/generic_services_package.dart';
import 'generated/app_localizations.dart';
import 'models/authModels/user_model.dart';
import 'models/categoryModels/category_model.dart';
import 'models/resourceModels/resource_item_model.dart';
import 'providers/resource_bundle_provider.dart'; // You'll need to create this file if not yet

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: "assets/.env");
  final resourceProvider = ResourceBundleProvider();
  final categoryProvider = CategoryProvider();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => resourceProvider),
        ChangeNotifierProvider(create: (_) => categoryProvider),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ApiCubit<ApiResponse<ResourceItem>>>(
            create: (_) => ApiCubit<ApiResponse<ResourceItem>>(),
          ),
          BlocProvider<ApiCubit<ApiListResponseWrapper<Category>>>(
            create: (_) => ApiCubit<ApiListResponseWrapper<Category>>(),
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
