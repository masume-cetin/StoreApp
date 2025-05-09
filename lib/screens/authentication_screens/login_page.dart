import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:store_app/screens/authentication_screens/register_page.dart';
import 'package:store_app/screens/widgets/page_wrapper_widget.dart';
import 'package:store_app/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:google_sign_in/google_sign_in.dart';
import '../../generated/app_localizations.dart';
import '../../models/authModels/user_model.dart';
import '../../providers/resource_bundle_provider.dart';
import '../../utils/base_page.dart';
import '../../utils/global_variables.dart';
import 'package:generic_services_package/generic_services_package.dart';
import '../../utils/validations.dart';
import '../tab_screens/tab_nav_shell_page.dart';
import '../widgets/gradient_button.dart';
import '../widgets/text_fields.dart';
import 'dart:io' as platform;

class Login extends BasePage {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends BaseState<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService service = ApiService();
  final userCubit = ApiCubit<User?>();
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<ApiResponse<User>> signInRequest() async {
    final requestBody = User(
      email: _emailController.text,
      password: _passwordController.text,
    ).toJson();

    final response = await service.sendRequest(uri,signIn, method: 'POST', body: requestBody);

    debugPrint("📦 Raw login response: $response");

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

  Future<ApiResponse<User>> loginWithGoogle() async {
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
          result: Result(isSuccess: false, errorMessage: "Google sign-in cancelled", status: 400),
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
        final response = await service.sendRequest(uri,
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
          result: Result(isSuccess: false, errorMessage: "Firebase token was null", status: 400),
          data: null,
        );
      }
    } catch (e) {
      return ApiResponse<User>(
        result: Result(isSuccess: false, errorMessage: e.toString(), status: 500),
        data: null,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      showAppBarActions: false,
      showSearchBar: false,
      showAppBarMenu: false,
      showSideImage: true,
      showBottomNavigationBar: false,
      sideImageBytes: bytes,
        centerContent: true,
        child: BlocBuilder<ApiCubit<ApiResponse<User>>, ApiState<ApiResponse<User>>>(
            builder: (context, state)
        {
          if (state is ApiLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ApiSuccess<ApiResponse<User>>) {
            var response = state.data.result;
            if (handleResponse(response)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const NavigationShell()),
                );
              });
            }
          } else if (state is ApiError) {
            return Center(child: Text("Error: ${state.toString()}"));
          }
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: loginCompanyTitlePadding,
                      child: Text(
                        "Company",
                        style: headlineTextStyle.copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: height / 20),
                    SizedBox(
                      width: kIsWeb ? width / 2 : width,
                      child: Column(
                        children: [
                          // mail title
                          Padding(
                            padding: loginFormFieldTitlePadding,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(AppLocalizations.of(context)!.mail, style: bodyTextStyle),
                            ),
                          ),
                          // mail field
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
                          // password title
                          Padding(
                            padding: loginFormFieldTitlePadding,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(AppLocalizations.of(context)!.password, style: bodyTextStyle),
                            ),
                          ),
                          // password field
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
                          // login button
                          Padding(
                            padding: loginButtonPadding,
                            child: GradientButton(
                              text: 'Login',
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  final cubit = context.read<ApiCubit<ApiResponse<User>>>();
                                  cubit.request(() async => await signInRequest());
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: loginButtonPadding,
                            child: GradientButton(
                              text: 'Login With Google Account',
                              onPressed: () {
                                  final cubit = context.read<ApiCubit<ApiResponse<User>>>();
                                  cubit.request(() async => await loginWithGoogle());
                              },
                            ),
                          ),
                          // register row
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: loginFormFieldPadding.copyWith(top: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(AppLocalizations.of(context)!.register, style: bodyTextStyle),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const Register()),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.registerButton,
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
              ),
            ),
          );
        }),
      );
  }
}
