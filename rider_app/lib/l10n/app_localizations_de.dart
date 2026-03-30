// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get time_just_now => 'Soeben';

  @override
  String time_minutes(int n) {
    return '${n}m vor';
  }

  @override
  String time_hours(int n) {
    return '${n}h vor';
  }

  @override
  String get ok => 'OK';

  @override
  String get password_does_not_meet_requirements =>
      'Passwort entspricht nicht der Anforderungen';

  @override
  String get password_is_required => 'Passwort erforderlich';

  @override
  String get snackbar_dismiss => 'ZURÜCKWEISEN';

  @override
  String get field_error_required => 'Dieses Feld ist erforderlich';

  @override
  String get field_error_invalid_format => 'Ungültiges Format';

  @override
  String get field_email_message =>
      'Geben Sie eine gültige E-Mail-Adresse ein.';

  @override
  String get field_nip_message =>
      'Die NIP-Nummer muss genau 10 Ziffern lang sein.';

  @override
  String get field_regon_message => 'REGON muss 9 oder 14 Ziffern lang sein.';

  @override
  String get field_postal_code_message =>
      'Geben Sie eine gültige Postleitzahl ein (XX-XXX).';

  @override
  String get field_hint_prefix => 'Eingeben ';
}
