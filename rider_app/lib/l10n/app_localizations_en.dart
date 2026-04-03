// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get time_just_now => 'Just now';

  @override
  String time_minutes(int n) {
    return '${n}m ago';
  }

  @override
  String time_hours(int n) {
    return '${n}h ago';
  }

  @override
  String get ok => 'OK';

  @override
  String get password_does_not_meet_requirements =>
      'Password does not meet requirements';

  @override
  String get password_is_required => 'Password is required';

  @override
  String get snackbar_dismiss => 'DISMISS';

  @override
  String get field_error_required => 'This field is required';

  @override
  String get field_error_invalid_format => 'Invalid format';

  @override
  String get field_email_message => 'Enter a valid email address';

  @override
  String get field_nip_message => 'NIP must be exactly 10 digits';

  @override
  String get field_regon_message => 'REGON must be 9 or 14 digits';

  @override
  String get field_postal_code_message => 'Enter a valid postal code (XX-XXX)';

  @override
  String get field_hint_prefix => 'Enter ';
}
