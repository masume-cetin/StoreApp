import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/models/authModels/userModel.dart';
import 'package:store_app/utils/theme.dart';

import '../../controllers/authControllers.dart';
import '../../cubits/genericCubit.dart';
import '../../cubits/states/genericStates.dart';
import '../../generated/app_localizations.dart';
import '../../models/generic/ApiResponseWrapper.dart';
import '../../models/generic/resultModel.dart';
import '../../utils/basePage.dart';
import '../../utils/globalVariables.dart';
import '../../utils/validations.dart';
import '../tab_screens/mainScreen.dart';
import '../widgets/pageWrapperWidget.dart';
import '../widgets/gradientButton.dart';
import '../widgets/textFields.dart';
import 'login.dart';

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

  Future<ApiResponse<User>> signUpRequest() async {
    var requestBody = User(
      email: _emailController.text,
      password: _passwordController.text,
      fullName: _fullNameController.text,
    ).toJson();

    var response =
    await service.sendRequest(signUp, method: 'POST', body: requestBody);
    if (response['token'] != null) {
      print("📦 Raw signup response: $response");

      try {
        final user = User.fromJson(response);
        print("✅ User parsed: $user");

        final result = Result.fromJson(response['result'] ?? {});
        return ApiResponse(data: user, result: result);
      } catch (e) {
        print("❌ Failed to parse User: $e");
        rethrow;
      }
    }
    final result = Result.fromJson(response);
    return ApiResponse(data: null, result: result);
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
                print(state);
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
