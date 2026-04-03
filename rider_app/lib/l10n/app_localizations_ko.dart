// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get time_just_now => '방금';

  @override
  String time_minutes(int n) {
    return '${n}m 전';
  }

  @override
  String time_hours(int n) {
    return '$n시간 전';
  }

  @override
  String get ok => '좋아요';

  @override
  String get password_does_not_meet_requirements => '비밀번호가 요구 사항을 충족하지 않습니다.';

  @override
  String get password_is_required => '비밀번호가 필요합니다';

  @override
  String get snackbar_dismiss => '해고하다';

  @override
  String get field_error_required => '이 항목은 필수 입력 사항입니다.';

  @override
  String get field_error_invalid_format => '잘못된 형식입니다';

  @override
  String get field_email_message => '유효한 이메일 주소를 입력하세요';

  @override
  String get field_nip_message => 'NIP는 정확히 10자리 숫자여야 합니다.';

  @override
  String get field_regon_message => 'REGON은 9자리 또는 14자리 숫자여야 합니다.';

  @override
  String get field_postal_code_message => '유효한 우편번호(XX-XXX)를 입력하세요.';

  @override
  String get field_hint_prefix => '입력하다 ';
}
