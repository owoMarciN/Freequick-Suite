// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get time_just_now => 'Właśnie';

  @override
  String time_minutes(int n) {
    return '${n}m temu';
  }

  @override
  String time_hours(int n) {
    return '${n}godz. temu';
  }

  @override
  String get ok => 'OK';

  @override
  String get password_does_not_meet_requirements => 'Hasło nie spełnia wymagań';

  @override
  String get password_is_required => 'Wymagane jest hasło';

  @override
  String get snackbar_dismiss => 'ODRZUCAĆ';

  @override
  String get field_error_required => 'To pole jest wymagane';

  @override
  String get field_error_invalid_format => 'Nieprawidłowy format';

  @override
  String get field_email_message => 'Podaj prawidłowy adres e-mail';

  @override
  String get field_nip_message => 'NIP musi składać się dokładnie z 10 cyfr';

  @override
  String get field_regon_message => 'REGON musi mieć 9 lub 14 cyfr';

  @override
  String get field_postal_code_message =>
      'Wprowadź prawidłowy kod pocztowy (XX-XXX)';

  @override
  String get field_hint_prefix => 'Wchodzić ';
}
