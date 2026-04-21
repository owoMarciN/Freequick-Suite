import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'rider_localizations_de.dart';
import 'rider_localizations_en.dart';
import 'rider_localizations_ko.dart';
import 'rider_localizations_pl.dart';
import 'rider_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of RiderLocalizations
/// returned by `RiderLocalizations.of(context)`.
///
/// Applications need to include `RiderLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'rider/rider_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: RiderLocalizations.localizationsDelegates,
///   supportedLocales: RiderLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the RiderLocalizations.supportedLocales
/// property.
abstract class RiderLocalizations {
  RiderLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static RiderLocalizations? of(BuildContext context) {
    return Localizations.of<RiderLocalizations>(context, RiderLocalizations);
  }

  static const LocalizationsDelegate<RiderLocalizations> delegate =
      _RiderLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('ko'),
    Locale('pl'),
    Locale('uk')
  ];

  /// No description provided for @activeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Active Delivery'**
  String get activeDelivery;

  /// No description provided for @tapToReturnToMap.
  ///
  /// In en, this message translates to:
  /// **'Tap to return to map & navigation'**
  String get tapToReturnToMap;

  /// No description provided for @youAreOnline.
  ///
  /// In en, this message translates to:
  /// **'You\'re Online'**
  String get youAreOnline;

  /// No description provided for @youAreOffline.
  ///
  /// In en, this message translates to:
  /// **'You\'re Offline'**
  String get youAreOffline;
}

class _RiderLocalizationsDelegate
    extends LocalizationsDelegate<RiderLocalizations> {
  const _RiderLocalizationsDelegate();

  @override
  Future<RiderLocalizations> load(Locale locale) {
    return SynchronousFuture<RiderLocalizations>(
        lookupRiderLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'ko', 'pl', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_RiderLocalizationsDelegate old) => false;
}

RiderLocalizations lookupRiderLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return RiderLocalizationsDe();
    case 'en':
      return RiderLocalizationsEn();
    case 'ko':
      return RiderLocalizationsKo();
    case 'pl':
      return RiderLocalizationsPl();
    case 'uk':
      return RiderLocalizationsUk();
  }

  throw FlutterError(
      'RiderLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
