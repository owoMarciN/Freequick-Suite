import 'package:flutter/widgets.dart';
import '../l10n/generated/common/common_localizations.dart';
import '../l10n/generated/customer/customer_localizations.dart';
import '../l10n/generated/rider/rider_localizations.dart';
import '../l10n/generated/merchant/merchant_localizations.dart';

extension ContextTranslateExt on BuildContext {
  CommonLocalizations get l10nCommon => CommonLocalizations.of(this)!;
  CustomerLocalizations get l10nCustomer => CustomerLocalizations.of(this)!;
  RiderLocalizations get l10nRider => RiderLocalizations.of(this)!;
  MerchantLocalizations get l10nMerchant => MerchantLocalizations.of(this)!;
}