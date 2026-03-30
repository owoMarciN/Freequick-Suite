// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get time_just_now => 'Щойно';

  @override
  String time_minutes(int n) {
    return '$nхв тому';
  }

  @override
  String time_hours(int n) {
    return '$nгод тому';
  }

  @override
  String get ok => 'Гаразд';

  @override
  String get password_does_not_meet_requirements =>
      'Пароль не відповідає вимогам';

  @override
  String get password_is_required => 'Потрібен пароль';

  @override
  String get snackbar_dismiss => 'ВІДХИЛИТИ';

  @override
  String get field_error_required => 'Це поле обов\'язкове';

  @override
  String get field_error_invalid_format => 'Недійсний формат';

  @override
  String get field_email_message => 'Введіть дійсну адресу електронної пошти';

  @override
  String get field_nip_message =>
      'Національний ідентифікаційний номер (NIP) має складатися рівно з 10 цифр';

  @override
  String get field_regon_message => 'REGON має складатися з 9 або 14 цифр';

  @override
  String get field_postal_code_message =>
      'Введіть дійсний поштовий індекс (XX-XXX)';

  @override
  String get field_hint_prefix => 'Введіть';
}
