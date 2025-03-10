import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store_app/screens/authentication_screens/register.dart';
import 'package:store_app/utils/theme.dart';

import '../../generated/app_localizations.dart';
import '../../utils/basePage.dart';
import '../../utils/validations.dart';
import '../widgets/gradientButton.dart';
import '../widgets/gradientTopContainer.dart';
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
                // C
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
                    ), // for the bottom part of the screen
                  ),
                ),

                // Your existing content on top of the semicircle
                Center(
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

                          /* Text(
                        AppLocalizations.of(context)!.loginTitle,
                        style: headlineTextStyle,
                      ),
                      Text(AppLocalizations.of(context)!.loginSubTitle,
                          style: buttonTextStyle),*/
                          // TODO: maybe ımage here
                          SizedBox(height: height / 20),
                          SizedBox(
                            width: kIsWeb ? width / 2 : width,
                            child: Column(
                              children: [
                                Padding(
                                  padding: loginFormFieldTitlePadding,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        AppLocalizations.of(context)!.mail,
                                        style: bodyTextStyle),
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
                                Padding(
                                  padding: loginFormFieldTitlePadding,
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                        AppLocalizations.of(context)!.password,
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
                                  ),
                                ),
                                Padding(
                                  padding: loginButtonPadding,
                                  child: GradientButton(
                                    text: 'Login',
                                    onPressed: () {
                                      // Handle button press (e.g., navigate to another screen)
                                      _formKey.currentState?.validate();
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding:
                                        loginFormFieldPadding.copyWith(top: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!
                                                .register,
                                            style: bodyTextStyle),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return const Register();
                                            }));
                                          },
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .registerButton,
                                              style: bodyTextStyle.copyWith(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.w900)),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
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
