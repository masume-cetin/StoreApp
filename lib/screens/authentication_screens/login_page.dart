import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/models/generic/result_model.dart';
import 'package:store_app/screens/authentication_screens/register_page.dart';
import 'package:store_app/screens/widgets/page_wrapper_widget.dart';
import 'package:store_app/utils/theme.dart';
import '../../controllers/api_service.dart';
import '../../cubits/generic_cubit.dart';
import '../../cubits/states/generic_states.dart';
import '../../generated/app_localizations.dart';
import '../../models/authModels/user_model.dart';
import '../../models/generic/api_response_wrapper.dart';
import '../../utils/base_page.dart';
import '../../utils/global_variables.dart';
import '../../utils/validations.dart';
import '../tab_screens/tab_nav_shell_page.dart';
import '../widgets/gradient_button.dart';
import '../widgets/text_fields.dart';

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
      debugPrint("📦 Raw signup response: $response");

      try {
        final user = User.fromJson(response);
        debugPrint("✅ User parsed: $user");

        final result = Result.fromJson(response['result'] ?? {});
        return ApiResponse(data: user, result: result);
      } catch (e) {
        debugPrint("❌ Failed to parse User: $e");
        rethrow;
      }
    }
    final result = Result.fromJson(response);
    return ApiResponse(data: null, result: result);
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      showAppBarActions: false,
      showSearchBar: false,
      showAppBarMenu: false,
      showSideImage: true,
      showBottomNavigationBar: false,
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
