import 'dart:async';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:generic_services_package/generic_services_package.dart';
import '../models/categoryModels/category_model.dart';
import '../models/resourceModels/resource_item_model.dart';
import '../providers/category_provider.dart';
import '../providers/resource_bundle_provider.dart';
import '../utils/global_variables.dart';
import '../utils/base_page.dart';
import '../utils/theme.dart';
import 'authentication_screens/login_page.dart';

class GradientSplashScreen extends BasePage {
  const GradientSplashScreen({super.key});

  @override
  State<GradientSplashScreen> createState() => _GradientSplashScreenState();
}

class _GradientSplashScreenState extends BaseState<GradientSplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool shouldRepeat = false;

  Future<ApiResponse<List<ResourceItem>>> fetchResources() async {
    final response = await ApiService().sendRequest(uri,getResourcesApi, method: 'GET');
    return ApiResponse.fromJson(
      response,
          (data) {
        final resourceList = (data['resources'] as List?) ?? [];
        return resourceList.map((e) => ResourceItem.fromJson(e)).toList();
      },
    );
  }
  Future<ApiListResponseWrapper<Category>> fetchAllCategories() async {
    final response = await ApiService().sendRequest(uri, getCategories, method: 'GET');

    return ApiListResponseWrapper<Category>.fromJson(
      response,
          (json) => Category.fromJson(json),
    );
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_controller);

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (mounted && _controller.status == AnimationStatus.completed) {
        setState(() {
          shouldRepeat = true;
        });
        _controller.repeat(reverse: true);
      }
    });
    context.read<ApiCubit<ApiResponse<List<ResourceItem>>>>().request(fetchResources);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ApiCubit<ApiResponse<List<ResourceItem>>>, ApiState<ApiResponse<List<ResourceItem>>>>(
          listener: (context, state) {
            if (state is ApiSuccess<ApiResponse<List<ResourceItem>>>) {
              final result = state.data.result;
              if (handleResponse(result)) {
                final provider = context.read<ResourceBundleProvider>();
                provider.setResources(state.data.data ?? []);
                context.read<ApiCubit<ApiListResponseWrapper<Category>>>().request(fetchAllCategories);
              }
            } else if (state is ApiError<ApiResponse<ResourceItem>>) {
              showErrorSnackBar(context, (state as ApiError<ApiResponse<ResourceItem>>).message);
            }
          },
        ),
        BlocListener<ApiCubit<ApiListResponseWrapper<Category>>, ApiState<ApiListResponseWrapper<Category>>>(
          listener: (context, state) {
            if (state is ApiSuccess<ApiListResponseWrapper<Category>>) {
              final result = state.data.result;
              if (handleResponse(result)) {
                final provider = context.read<CategoryProvider>();
                provider.setCategory(state.data.data ?? []);
                Future.delayed(const Duration(seconds: 2), () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Login()),
                    );
                  });
                });
              }
            } else if (state is ApiError<ApiListResponseWrapper<Category>>) {
              showErrorSnackBar(context, (state).message);
            }
          },),
      ],

      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [secondaryColor, primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: foundation.kIsWeb ? 400 : 200,
                  height: foundation.kIsWeb ? 400 : 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset('assets/images/brandLogo.png', fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}