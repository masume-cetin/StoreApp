import 'dart:io' as platform;

import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:store_app/models/authModels/user_model.dart';
import 'package:store_app/utils/theme.dart';
import 'package:generic_services_package/generic_services_package.dart';
import '../../generated/app_localizations.dart';
import '../../providers/resource_bundle_provider.dart';
import '../../utils/base_page.dart';
import '../../utils/global_variables.dart';
import '../../utils/validations.dart';
import '../widgets/page_wrapper_widget.dart';
import '../widgets/gradient_button.dart';
import '../widgets/text_fields.dart';
import 'login_page.dart';

class Register extends BasePage {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends BaseState<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final ApiService service = ApiService();
  final userCubit = ApiCubit<ApiResponse<User>>();
  late Uint8List? bytes;

  @override
  initState(){
    final provider = context.read<ResourceBundleProvider>();
    final item = provider.getItemByName("authPageIllustration");
    bytes = item?.decodedImage;
    super.initState();
  }
  @override
  void dispose() {
    // Dispose of the controller when the widget is removed
    _passwordController.dispose();
    _emailController.dispose();
    _fullNameController.dispose();
    super.dispose();
  }
  Future<ApiResponse<User>> signUpRequest() async {
    final requestBody = User(
      email: _emailController.text,
      password: _passwordController.text,
      fullName: _fullNameController.text,
    ).toJson();

    final response = await service.sendRequest(uri,signUp, method: 'POST', body: requestBody);
    debugPrint("📦 Raw signup response: $response");

    try {
      final apiResponse = ApiResponse<User>.fromJson(
        response,
            (json) => User.fromJson(json),
      );

      if (apiResponse.data != null) {
        debugPrint("✅ User parsed: ${apiResponse.data}");
      } else {
        debugPrint("❌ No user data returned.");
      }

      return apiResponse;
    } catch (e) {
      debugPrint("❌ Failed to parse User: $e");
      rethrow;
    }
  }
  Future<ApiResponse<User>> registerWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn(
        clientId: kIsWeb
            ? dotenv.env['FIREBASE_WEB_API_KEY']  // ← use the correct one here
            : platform.Platform.isIOS? dotenv.env['FIREBASE_IOS_API_KEY']:
        dotenv.env['FIREBASE_ANDROID_API_KEY'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return ApiResponse<User>(
          result: Result(isSuccess: false, errorMessage: "Google sign-in cancelled",status: 500),
          data: null,
        );
      }

      final googleAuth = await googleUser.authentication;
      final credential = fb_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCred = await fb_auth.FirebaseAuth.instance.signInWithCredential(credential);
      final idToken = await userCred.user?.getIdToken();

      if (idToken != null) {
        final response = await service.sendRequest(
          uri,
          "/api/google-auth",
          method: 'POST',
          body: {
            "firebaseIdToken": idToken,
          },
        );

        final apiResponse = ApiResponse<User>.fromJson(
          response,
              (json) => User.fromJson(json),
        );

        return apiResponse;
      } else {
        return ApiResponse<User>(
          result: Result(isSuccess: false, errorMessage: "Firebase token was null", status: 500),
          data: null,
        );
      }
    } catch (e) {
      return ApiResponse<User>(
        result: Result(isSuccess: false, errorMessage: e.toString(),status: 500),
        data: null,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApiCubit<ApiResponse<User>>>.value(
      value: userCubit,
      child: PageWrapper(
        showAppBarActions: false,
        showSearchBar: false,
        showAppBarMenu: false,
        showSideImage: true,
        showBottomNavigationBar: false,
        sideImageBytes: bytes,
          centerContent: true,
          footer: const Text(
            "© 2025 My App",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          child: BlocBuilder<ApiCubit<ApiResponse<User>>, ApiState<ApiResponse<User>>>(
            builder: (context, state) {
              if (state is ApiLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ApiSuccess<ApiResponse<User>>) {
                var response = state.data.result;
                  if (handleResponse(response)) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    });
                  }
              } else if (state is ApiError) {
                return Center(child: Text("Error: ${state.toString()}"));
              }

              // Default form UI when not loading or error
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: kIsWeb ? width / 2 : width,
                      child: Column(
                        children: [
                          Padding(
                            padding: loginCompanyTitlePadding,
                            child: Text(
                              "Company",
                              style: headlineTextStyle.copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: height / 15),
                          // Full Name
                          Padding(
                            padding: loginFormFieldTitlePadding,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                AppLocalizations.of(context)!.fullName,
                                style: outlinedFormTitleTextStyle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: loginFormFieldPadding,
                            child: GenericTextField(
                              controller: _fullNameController,
                              textInputType: TextInputType.text,
                              validation: nameValidation,
                              labelText: "john doe",
                              icon: const Icon(Icons.account_circle),
                            ),
                          ),
                          // Email
                          Padding(
                            padding: loginFormFieldTitlePadding,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                AppLocalizations.of(context)!.mail,
                                style: outlinedFormTitleTextStyle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: loginFormFieldPadding,
                            child: GenericTextField(
                              controller: _emailController,
                              textInputType: TextInputType.emailAddress,
                              validation: mailValidation,
                              labelText: "xxxxxxx@abc.com",
                              icon: const Icon(Icons.email),
                            ),
                          ),
                          // Password
                          Padding(
                            padding: loginFormFieldTitlePadding,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                AppLocalizations.of(context)!.password,
                                style: outlinedFormTitleTextStyle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: loginFormFieldPadding,
                            child: GenericTextField(
                              controller: _passwordController,
                              textInputType: TextInputType.visiblePassword,
                              validation: passwordValidation,
                              labelText: "********",
                              isObscureText: true,
                              icon: const Icon(Icons.lock),
                            ),
                          ),
                          // Register Button
                          Padding(
                            padding: loginButtonPadding,
                            child: GradientButton(
                              text: AppLocalizations.of(context)!.registerButton,
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  context.read<ApiCubit<ApiResponse<User>>>().request(
                                        () => signUpRequest(),
                                  );
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: loginButtonPadding,
                            child: GradientButton(
                              text: "Register With Google Account",
                              onPressed: () {
                                  context.read<ApiCubit<ApiResponse<User>>>().request(
                                        () => registerWithGoogle(),
                                  );
                              },
                            ),
                          ),
                          // Login hint
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: loginFormFieldPadding.copyWith(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.loginHint,
                                    style: bodyTextStyle,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const Login()),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.login,
                                      style: outlinedFormTitleTextStyle.copyWith(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
    );
  }
}
