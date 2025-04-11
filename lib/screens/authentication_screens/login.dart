import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/models/generic/resultModel.dart';
import 'package:store_app/screens/authentication_screens/register.dart';
import 'package:store_app/screens/mainScreen.dart';
import 'package:store_app/screens/widgets/baseContainerWidget.dart';
import 'package:store_app/utils/theme.dart';

import '../../controllers/authControllers.dart';
import '../../cubits/genericCubit.dart';
import '../../cubits/states/genericStates.dart';
import '../../generated/app_localizations.dart';
import '../../models/authModels/userModel.dart';
import '../../models/generic/apiResponseWrapper.dart';
import '../../utils/basePage.dart';
import '../../utils/globalVariables.dart';
import '../../utils/validations.dart';
import '../widgets/gradientButton.dart';
import '../widgets/textFields.dart';

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

  Future<ApiResponse<User>> signInRequest() async {
    final requestBody = User(
      email: _emailController.text,
      password: _passwordController.text,
    ).toJson();

    final response = await service.sendRequest(signIn, method: 'POST', body: requestBody);

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
    return Scaffold(
      body: PageWrapper(
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
                  MaterialPageRoute(builder: (context) => const MainScreen()),
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
      ),
    );
  }
}
