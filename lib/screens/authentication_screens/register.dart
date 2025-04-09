import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store_app/models/authModels/userModel.dart';
import 'package:store_app/utils/theme.dart';

import '../../controllers/authControllers.dart';
import '../../generated/app_localizations.dart';
import '../../utils/basePage.dart';
import '../../utils/globalVariables.dart';
import '../../utils/validations.dart';
import '../widgets/gradientButton.dart';
import '../widgets/gradientTopContainer.dart';
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

  Future<void> signUpRequest() async {
    setState(() {
      isLoading = true; // Start loading
    });

    // Example body data
    var requestBody = User(
            email: _emailController.text,
            password: _passwordController.text,
            fullName: _fullNameController.text)
        .toJson();

    // Call the sendRequest function with necessary parameters
    var response =
        await service.sendRequest(signUp, method: 'POST', body: requestBody);
    if (response['user'] != null) {
      User user = User.fromJson(response['user']);
      setState(() {
        if (user.result!.isSuccess) isLoading = false; // Stop loading

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                // CustomPaint widget to draw the upside-down semicircle
                const GradientTopContainer(),
                // Bottom part of the screen (below the semicircle) with its own color
                Positioned.fill(
                  top: kIsWeb
                      ? height / 2 - 150
                      : height / 2 -
                          200, // Position the bottom section after the circle
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                isLoading
                    ? loader()
                    // Your existing content on top of the semicircle
                    : Center(
                        child: Padding(
                          padding: pageContentPadding,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: loginCompanyTitlePadding,
                                  child: Text(
                                    "Company",
                                    style: headlineTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  width: kIsWeb ? width / 2 : width,
                                  child: Column(
                                    children: [
                                      SizedBox(height: height / 15),
                                      Padding(
                                        padding: loginFormFieldTitlePadding,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .fullName,
                                              style: bodyTextStyle),
                                        ),
                                      ),
                                      Padding(
                                          padding: loginFormFieldPadding,
                                          child: GenericTextField(
                                            controller: _fullNameController,
                                            textInputType: TextInputType.text,
                                            validation: nameValidation,
                                            labelText: "john doe",
                                            icon: const Icon(
                                                Icons.account_circle),
                                          )),
                                      Padding(
                                        padding: loginFormFieldTitlePadding,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .mail,
                                              style: bodyTextStyle),
                                        ),
                                      ),
                                      Padding(
                                          padding: loginFormFieldPadding,
                                          child: GenericTextField(
                                            controller: _emailController,
                                            textInputType:
                                                TextInputType.emailAddress,
                                            validation: mailValidation,
                                            labelText: "xxxxxxx@abc.com",
                                            icon: const Icon(Icons.email),
                                          )),
                                      Padding(
                                        padding: loginFormFieldTitlePadding,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .password,
                                              style: bodyTextStyle),
                                        ),
                                      ),
                                      Padding(
                                          padding: loginFormFieldPadding,
                                          child: GenericTextField(
                                            controller: _passwordController,
                                            textInputType:
                                                TextInputType.visiblePassword,
                                            validation: passwordValidation,
                                            labelText: "********",
                                            isObscureText: true,
                                            icon: const Icon(Icons.lock),
                                          )),
                                      Padding(
                                        padding: loginButtonPadding,
                                        child: GradientButton(
                                          text: AppLocalizations.of(context)!
                                              .registerButton,
                                          onPressed: () {
                                            _formKey.currentState?.validate();
                                            signUpRequest();
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: loginFormFieldPadding
                                              .copyWith(top: 20),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .loginHint,
                                                  style: bodyTextStyle),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return const Login();
                                                  }));
                                                },
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .login,
                                                    style:
                                                        bodyTextStyle.copyWith(
                                                            color: Colors.amber,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
