import 'package:flutter/widgets.dart';

import '../l10n/generated/common/common_localizations.dart';
import '../l10n/generated/customer/customer_localizations.dart';
import '../l10n/generated/rider/rider_localizations.dart';
import '../l10n/generated/merchant/merchant_localizations.dart';

/// Extension providing convenient access to all localization modules
/// from BuildContext.
///
/// Usage depending on the app:
/// 
///   context.l10nCommon.someKey
/// 
///   context.l10nCustomer.someKey
extension ContextTranslateExt on BuildContext {

  /// Common/shared translations across all apps
  CommonLocalizations get l10nCommon =>
      CommonLocalizations.of(this)!;

  /// Customer app translations
  CustomerLocalizations get l10nCustomer =>
      CustomerLocalizations.of(this)!;

  /// Rider app translations
  RiderLocalizations get l10nRider =>
      RiderLocalizations.of(this)!;

  /// Merchant app translations
  MerchantLocalizations get l10nMerchant =>
      MerchantLocalizations.of(this)!;
}