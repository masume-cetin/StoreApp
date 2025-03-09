import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get loginTitle => 'Hesabına Giriş Yap';

  @override
  String get loginSubTitle => 'seçkin kataloglarda gezinmek için';

  @override
  String get mail => 'mail';

  @override
  String get password => 'şifre';

  @override
  String get login => 'giriş';

  @override
  String get mailValidation => 'geçersiz email';

  @override
  String get passwordValidation => 'geçersiz şifre';

  @override
  String get register => 'Hesabınız yok mu ? ';

  @override
  String get registerButton => 'Kayıt Ol';

  @override
  String get loginHint => 'Zaten bir hesabınız var mı ? ';

  @override
  String get fullName => 'İsim Soyisim';

  @override
  String get registerTitle => 'Kayıt Ol';

  @override
  String get registerSubTitle => 'seçkin kataloglarda gezinmek için';
}
