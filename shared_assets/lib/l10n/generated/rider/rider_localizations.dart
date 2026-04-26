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

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @welcomeBackTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBackTitle;

  /// No description provided for @signInToContinueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue delivering'**
  String get signInToContinueSubtitle;

  /// No description provided for @emailAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get emailAddressHint;

  /// No description provided for @emailRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequiredError;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @phoneForOtpLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone number for OTP verification'**
  String get phoneForOtpLabel;

  /// No description provided for @loginErrorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account found for this email.'**
  String get loginErrorUserNotFound;

  /// No description provided for @loginErrorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get loginErrorWrongPassword;

  /// No description provided for @loginErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get loginErrorInvalidEmail;

  /// No description provided for @loginErrorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get loginErrorUserDisabled;

  /// No description provided for @loginErrorDefault.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Try again.'**
  String get loginErrorDefault;

  /// No description provided for @loginErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Try again.'**
  String get loginErrorGeneric;

  /// No description provided for @defaultRiderName.
  ///
  /// In en, this message translates to:
  /// **'Rider'**
  String get defaultRiderName;

  /// No description provided for @statusReadyToReceive.
  ///
  /// In en, this message translates to:
  /// **'Ready to receive orders'**
  String get statusReadyToReceive;

  /// No description provided for @statusGoOnlineToReceive.
  ///
  /// In en, this message translates to:
  /// **'Go online to receive orders'**
  String get statusGoOnlineToReceive;

  /// No description provided for @statRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get statRating;

  /// No description provided for @statVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get statVehicle;

  /// No description provided for @statStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statStatus;

  /// No description provided for @recentActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivityTitle;

  /// No description provided for @recentActivityEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No recent deliveries'**
  String get recentActivityEmptyTitle;

  /// No description provided for @recentActivityEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Go online to start receiving jobs'**
  String get recentActivityEmptySubtitle;

  /// No description provided for @statDeliveries.
  ///
  /// In en, this message translates to:
  /// **'Deliveries'**
  String get statDeliveries;

  /// No description provided for @performanceSummary.
  ///
  /// In en, this message translates to:
  /// **'Performance Summary'**
  String get performanceSummary;

  /// No description provided for @timeToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get timeToday;

  /// No description provided for @timeThisWeek.
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get timeThisWeek;

  /// No description provided for @timeThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get timeThisMonth;

  /// No description provided for @avgPerTrip.
  ///
  /// In en, this message translates to:
  /// **'Avg. per trip'**
  String get avgPerTrip;

  /// No description provided for @ordersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} orders'**
  String ordersCount(int count);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsNotifications;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get settingsPrivacy;

  /// No description provided for @settingsHelp.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get settingsHelp;

  /// No description provided for @settingsAppVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get settingsAppVersion;

  /// No description provided for @settingsDarkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get settingsDarkMode;

  /// No description provided for @mapMarkerRestaurant.
  ///
  /// In en, this message translates to:
  /// **'🏪 Restaurant'**
  String get mapMarkerRestaurant;

  /// No description provided for @mapMarkerPickupSnippet.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get mapMarkerPickupSnippet;

  /// No description provided for @mapMarkerCustomer.
  ///
  /// In en, this message translates to:
  /// **'🏠 Customer'**
  String get mapMarkerCustomer;

  /// No description provided for @mapMarkerDropoffSnippet.
  ///
  /// In en, this message translates to:
  /// **'Drop-off location'**
  String get mapMarkerDropoffSnippet;

  /// No description provided for @stepHeadingToStore.
  ///
  /// In en, this message translates to:
  /// **'Heading\nto Store'**
  String get stepHeadingToStore;

  /// No description provided for @stepPickedUp.
  ///
  /// In en, this message translates to:
  /// **'Picked\nUp'**
  String get stepPickedUp;

  /// No description provided for @stepDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get stepDelivered;

  /// No description provided for @actionHeadToRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Head to Restaurant'**
  String get actionHeadToRestaurant;

  /// No description provided for @actionNavToPickup.
  ///
  /// In en, this message translates to:
  /// **'Navigate to pick up the order'**
  String get actionNavToPickup;

  /// No description provided for @actionBtnPickedUp.
  ///
  /// In en, this message translates to:
  /// **'Picked Up'**
  String get actionBtnPickedUp;

  /// No description provided for @actionDelivering.
  ///
  /// In en, this message translates to:
  /// **'Delivering'**
  String get actionDelivering;

  /// No description provided for @actionNavToCustomer.
  ///
  /// In en, this message translates to:
  /// **'Head to the customer location'**
  String get actionNavToCustomer;

  /// No description provided for @actionBtnDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered ✓'**
  String get actionBtnDelivered;

  /// No description provided for @actionOrderDeliveredTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Delivered'**
  String get actionOrderDeliveredTitle;

  /// No description provided for @actionOrderDeliveredSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Great work!'**
  String get actionOrderDeliveredSubtitle;

  /// No description provided for @actionProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get actionProcessing;

  /// No description provided for @actionPleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get actionPleaseWait;

  /// No description provided for @dialogConfirmDelivery.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delivery'**
  String get dialogConfirmDelivery;

  /// No description provided for @dialogHandedToCustomer.
  ///
  /// In en, this message translates to:
  /// **'Did you hand the order to the customer?'**
  String get dialogHandedToCustomer;

  /// No description provided for @dialogYesDelivered.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delivered'**
  String get dialogYesDelivered;

  /// No description provided for @defaultRestaurantName.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get defaultRestaurantName;

  /// No description provided for @addressNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Address not available'**
  String get addressNotAvailable;

  /// No description provided for @orderDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetailsTitle;

  /// No description provided for @paymentCash.
  ///
  /// In en, this message translates to:
  /// **'Cash: {total}'**
  String paymentCash(String total);

  /// No description provided for @paymentCard.
  ///
  /// In en, this message translates to:
  /// **'Card Paid'**
  String get paymentCard;

  /// No description provided for @orderTypePickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup order'**
  String get orderTypePickup;

  /// No description provided for @orderTypeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery order'**
  String get orderTypeDelivery;

  /// No description provided for @labelDeliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get labelDeliveryAddress;

  /// No description provided for @labelPickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get labelPickup;

  /// No description provided for @subtitleCustomerCollects.
  ///
  /// In en, this message translates to:
  /// **'Customer collects from store'**
  String get subtitleCustomerCollects;

  /// No description provided for @orderTotal.
  ///
  /// In en, this message translates to:
  /// **'Order Total'**
  String get orderTotal;

  /// No description provided for @navToRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Navigate to Restaurant'**
  String get navToRestaurant;

  /// No description provided for @navToCustomer.
  ///
  /// In en, this message translates to:
  /// **'Navigate to Customer'**
  String get navToCustomer;

  /// No description provided for @errorApplication.
  ///
  /// In en, this message translates to:
  /// **'Application Error: {error}'**
  String errorApplication(String error);

  /// No description provided for @jobNewJob.
  ///
  /// In en, this message translates to:
  /// **'New Job'**
  String get jobNewJob;

  /// No description provided for @jobAutorejecting.
  ///
  /// In en, this message translates to:
  /// **'Autorejecting in {seconds} s'**
  String jobAutorejecting(int seconds);

  /// No description provided for @jobExpiresIn.
  ///
  /// In en, this message translates to:
  /// **'Expires in {seconds} s'**
  String jobExpiresIn(int seconds);

  /// No description provided for @jobPickupFrom.
  ///
  /// In en, this message translates to:
  /// **'Pickup from'**
  String get jobPickupFrom;

  /// No description provided for @jobShipTo.
  ///
  /// In en, this message translates to:
  /// **'Ship to'**
  String get jobShipTo;

  /// No description provided for @jobDefaultCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get jobDefaultCustomer;

  /// No description provided for @jobPaymentCash.
  ///
  /// In en, this message translates to:
  /// **'Cash · {total}'**
  String jobPaymentCash(String total);

  /// No description provided for @jobPaymentStripe.
  ///
  /// In en, this message translates to:
  /// **'Paid (Stripe)'**
  String get jobPaymentStripe;

  /// No description provided for @jobProductsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} products'**
  String jobProductsCount(int count);

  /// No description provided for @jobGetPayment.
  ///
  /// In en, this message translates to:
  /// **'Get {total} of payment'**
  String jobGetPayment(String total);

  /// No description provided for @jobActionReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get jobActionReject;

  /// No description provided for @jobActionAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get jobActionAccept;

  /// No description provided for @jobActionHideProducts.
  ///
  /// In en, this message translates to:
  /// **'Hide products'**
  String get jobActionHideProducts;

  /// No description provided for @jobActionShowProducts.
  ///
  /// In en, this message translates to:
  /// **'Show products'**
  String get jobActionShowProducts;

  /// No description provided for @otpErrorSend.
  ///
  /// In en, this message translates to:
  /// **'Failed to send OTP.'**
  String get otpErrorSend;

  /// No description provided for @otpErrorIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect code. Check the SMS and try again.'**
  String get otpErrorIncorrect;

  /// No description provided for @otpErrorExpired.
  ///
  /// In en, this message translates to:
  /// **'The code expired. Tap Resend to get a new one.'**
  String get otpErrorExpired;

  /// No description provided for @otpErrorDefault.
  ///
  /// In en, this message translates to:
  /// **'Verification failed. Try again.'**
  String get otpErrorDefault;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify\nYour Number'**
  String get otpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to\n{phone}'**
  String otpSubtitle(String phone);

  /// No description provided for @otpBtnVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get otpBtnVerify;

  /// No description provided for @otpResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {seconds} s'**
  String otpResendIn(int seconds);

  /// No description provided for @otpBtnResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get otpBtnResend;

  /// No description provided for @setupTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete\nYour Profile'**
  String get setupTitle;

  /// No description provided for @setupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us a bit about yourself'**
  String get setupSubtitle;

  /// No description provided for @setupNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get setupNameLabel;

  /// No description provided for @setupVehicleLabel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get setupVehicleLabel;

  /// No description provided for @setupBtnStart.
  ///
  /// In en, this message translates to:
  /// **'Start Delivering'**
  String get setupBtnStart;

  /// No description provided for @setupErrorName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get setupErrorName;

  /// No description provided for @setupErrorSave.
  ///
  /// In en, this message translates to:
  /// **'Failed to save profile. Try again.'**
  String get setupErrorSave;

  /// No description provided for @vehicleBicycle.
  ///
  /// In en, this message translates to:
  /// **'Bicycle'**
  String get vehicleBicycle;

  /// No description provided for @vehicleScooter.
  ///
  /// In en, this message translates to:
  /// **'Scooter'**
  String get vehicleScooter;

  /// No description provided for @vehicleCar.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get vehicleCar;

  /// No description provided for @statsTodayEarnings.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Earnings'**
  String get statsTodayEarnings;

  /// No description provided for @notificationChannelDispatch.
  ///
  /// In en, this message translates to:
  /// **'Dispatch Requests'**
  String get notificationChannelDispatch;

  /// No description provided for @notificationChannelDispatchDesc.
  ///
  /// In en, this message translates to:
  /// **'Incoming delivery job requests'**
  String get notificationChannelDispatchDesc;

  /// No description provided for @dayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get daySat;

  /// No description provided for @daySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get daySun;

  /// No description provided for @discountOff.
  ///
  /// In en, this message translates to:
  /// **'{discount}% OFF'**
  String discountOff(int discount);

  /// No description provided for @errorJobNotExist.
  ///
  /// In en, this message translates to:
  /// **'Job does not exist'**
  String get errorJobNotExist;

  /// No description provided for @errorJobTaken.
  ///
  /// In en, this message translates to:
  /// **'Job already taken'**
  String get errorJobTaken;

  /// No description provided for @errorSyncingPermissions.
  ///
  /// In en, this message translates to:
  /// **'Syncing security permissions... please wait.'**
  String get errorSyncingPermissions;

  /// No description provided for @errorUpdateStatus.
  ///
  /// In en, this message translates to:
  /// **'Could not update status'**
  String get errorUpdateStatus;

  /// No description provided for @errorAcceptJob.
  ///
  /// In en, this message translates to:
  /// **'Failed to accept job: {error}'**
  String errorAcceptJob(String error);

  /// No description provided for @errorUpdateOrder.
  ///
  /// In en, this message translates to:
  /// **'Failed to update order: {error}'**
  String errorUpdateOrder(String error);

  /// No description provided for @errorFailedToSendOtp.
  ///
  /// In en, this message translates to:
  /// **'Failed to send OTP'**
  String get errorFailedToSendOtp;

  /// No description provided for @errorInvalidCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid code'**
  String get errorInvalidCode;

  /// No description provided for @errorSessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Session expired'**
  String get errorSessionExpired;

  /// No description provided for @errorVerificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification failed'**
  String get errorVerificationFailed;

  /// No description provided for @actionVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get actionVerify;

  /// No description provided for @otpResendButton.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get otpResendButton;

  /// No description provided for @jobPaymentCard.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get jobPaymentCard;

  /// No description provided for @jobHideProducts.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get jobHideProducts;

  /// No description provided for @jobShowProducts.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get jobShowProducts;

  /// No description provided for @jobItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String jobItemsCount(int count);

  /// No description provided for @jobCollectPaymentWarning.
  ///
  /// In en, this message translates to:
  /// **'Collect {amount}'**
  String jobCollectPaymentWarning(Object amount);
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
