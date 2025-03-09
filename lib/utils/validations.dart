import 'package:flutter/cupertino.dart';

import '../generated/app_localizations.dart';

String? mailValidation(value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email';
  } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
      .hasMatch(value)) {
    return AppLocalizations.of(context)!.mailValidation;
  }
  return null;
}

String? passwordValidation(value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password';
  } else if (value.length < 6) {
    return AppLocalizations.of(context)!.passwordValidation;
  }
  return null;
}

String? nameValidation(value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return 'full name can not be empty';
  }
  return null;
}
