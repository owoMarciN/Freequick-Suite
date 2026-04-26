// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'rider_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class RiderLocalizationsEn extends RiderLocalizations {
  RiderLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get activeDelivery => 'Active Delivery';

  @override
  String get tapToReturnToMap => 'Tap to return to map & navigation';

  @override
  String get youAreOnline => 'You\'re Online';

  @override
  String get youAreOffline => 'You\'re Offline';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get welcomeBackTitle => 'Welcome Back';

  @override
  String get signInToContinueSubtitle => 'Sign in to continue delivering';

  @override
  String get emailAddressHint => 'Email address';

  @override
  String get emailRequiredError => 'Email is required';

  @override
  String get passwordLabel => 'Password';

  @override
  String get phoneForOtpLabel => 'Phone number for OTP verification';

  @override
  String get loginErrorUserNotFound => 'No account found for this email.';

  @override
  String get loginErrorWrongPassword => 'Incorrect password.';

  @override
  String get loginErrorInvalidEmail => 'Please enter a valid email address.';

  @override
  String get loginErrorUserDisabled => 'This account has been disabled.';

  @override
  String get loginErrorDefault => 'Login failed. Try again.';

  @override
  String get loginErrorGeneric => 'Something went wrong. Try again.';

  @override
  String get defaultRiderName => 'Rider';

  @override
  String get statusReadyToReceive => 'Ready to receive orders';

  @override
  String get statusGoOnlineToReceive => 'Go online to receive orders';

  @override
  String get statRating => 'Rating';

  @override
  String get statVehicle => 'Vehicle';

  @override
  String get statStatus => 'Status';

  @override
  String get recentActivityTitle => 'Recent Activity';

  @override
  String get recentActivityEmptyTitle => 'No recent deliveries';

  @override
  String get recentActivityEmptySubtitle => 'Go online to start receiving jobs';

  @override
  String get statDeliveries => 'Deliveries';

  @override
  String get performanceSummary => 'Performance Summary';

  @override
  String get timeToday => 'Today';

  @override
  String get timeThisWeek => 'This Week';

  @override
  String get timeThisMonth => 'This Month';

  @override
  String get avgPerTrip => 'Avg. per trip';

  @override
  String ordersCount(int count) {
    return '$count orders';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsPrivacy => 'Privacy & Security';

  @override
  String get settingsHelp => 'Help Center';

  @override
  String get settingsAppVersion => 'App Version';

  @override
  String get settingsDarkMode => 'Dark Mode';

  @override
  String get mapMarkerRestaurant => '🏪 Restaurant';

  @override
  String get mapMarkerPickupSnippet => 'Pickup';

  @override
  String get mapMarkerCustomer => '🏠 Customer';

  @override
  String get mapMarkerDropoffSnippet => 'Drop-off location';

  @override
  String get stepHeadingToStore => 'Heading\nto Store';

  @override
  String get stepPickedUp => 'Picked\nUp';

  @override
  String get stepDelivered => 'Delivered';

  @override
  String get actionHeadToRestaurant => 'Head to Restaurant';

  @override
  String get actionNavToPickup => 'Navigate to pick up the order';

  @override
  String get actionBtnPickedUp => 'Picked Up';

  @override
  String get actionDelivering => 'Delivering';

  @override
  String get actionNavToCustomer => 'Head to the customer location';

  @override
  String get actionBtnDelivered => 'Delivered ✓';

  @override
  String get actionOrderDeliveredTitle => 'Order Delivered';

  @override
  String get actionOrderDeliveredSubtitle => 'Great work!';

  @override
  String get actionProcessing => 'Processing';

  @override
  String get actionPleaseWait => 'Please wait...';

  @override
  String get dialogConfirmDelivery => 'Confirm Delivery';

  @override
  String get dialogHandedToCustomer =>
      'Did you hand the order to the customer?';

  @override
  String get dialogYesDelivered => 'Yes, Delivered';

  @override
  String get defaultRestaurantName => 'Restaurant';

  @override
  String get addressNotAvailable => 'Address not available';

  @override
  String get orderDetailsTitle => 'Order Details';

  @override
  String paymentCash(String total) {
    return 'Cash: $total';
  }

  @override
  String get paymentCard => 'Card Paid';

  @override
  String get orderTypePickup => 'Pickup order';

  @override
  String get orderTypeDelivery => 'Delivery order';

  @override
  String get labelDeliveryAddress => 'Delivery Address';

  @override
  String get labelPickup => 'Pickup';

  @override
  String get subtitleCustomerCollects => 'Customer collects from store';

  @override
  String get orderTotal => 'Order Total';

  @override
  String get navToRestaurant => 'Navigate to Restaurant';

  @override
  String get navToCustomer => 'Navigate to Customer';

  @override
  String errorApplication(String error) {
    return 'Application Error: $error';
  }

  @override
  String get jobNewJob => 'New Job';

  @override
  String jobAutorejecting(int seconds) {
    return 'Autorejecting in $seconds s';
  }

  @override
  String jobExpiresIn(int seconds) {
    return 'Expires in $seconds s';
  }

  @override
  String get jobPickupFrom => 'Pickup from';

  @override
  String get jobShipTo => 'Ship to';

  @override
  String get jobDefaultCustomer => 'Customer';

  @override
  String jobPaymentCash(String total) {
    return 'Cash · $total';
  }

  @override
  String get jobPaymentStripe => 'Paid (Stripe)';

  @override
  String jobProductsCount(int count) {
    return '$count products';
  }

  @override
  String jobGetPayment(String total) {
    return 'Get $total of payment';
  }

  @override
  String get jobActionReject => 'Reject';

  @override
  String get jobActionAccept => 'Accept';

  @override
  String get jobActionHideProducts => 'Hide products';

  @override
  String get jobActionShowProducts => 'Show products';

  @override
  String get otpErrorSend => 'Failed to send OTP.';

  @override
  String get otpErrorIncorrect =>
      'Incorrect code. Check the SMS and try again.';

  @override
  String get otpErrorExpired =>
      'The code expired. Tap Resend to get a new one.';

  @override
  String get otpErrorDefault => 'Verification failed. Try again.';

  @override
  String get otpTitle => 'Verify\nYour Number';

  @override
  String otpSubtitle(String phone) {
    return 'Enter the 6-digit code sent to\n$phone';
  }

  @override
  String get otpBtnVerify => 'Verify';

  @override
  String otpResendIn(int seconds) {
    return 'Resend code in $seconds s';
  }

  @override
  String get otpBtnResend => 'Resend code';

  @override
  String get setupTitle => 'Complete\nYour Profile';

  @override
  String get setupSubtitle => 'Tell us a bit about yourself';

  @override
  String get setupNameLabel => 'Full Name';

  @override
  String get setupVehicleLabel => 'Vehicle Type';

  @override
  String get setupBtnStart => 'Start Delivering';

  @override
  String get setupErrorName => 'Please enter your name';

  @override
  String get setupErrorSave => 'Failed to save profile. Try again.';

  @override
  String get vehicleBicycle => 'Bicycle';

  @override
  String get vehicleScooter => 'Scooter';

  @override
  String get vehicleCar => 'Car';

  @override
  String get statsTodayEarnings => 'Today\'s Earnings';

  @override
  String get notificationChannelDispatch => 'Dispatch Requests';

  @override
  String get notificationChannelDispatchDesc =>
      'Incoming delivery job requests';

  @override
  String get dayMon => 'Mon';

  @override
  String get dayTue => 'Tue';

  @override
  String get dayWed => 'Wed';

  @override
  String get dayThu => 'Thu';

  @override
  String get dayFri => 'Fri';

  @override
  String get daySat => 'Sat';

  @override
  String get daySun => 'Sun';

  @override
  String discountOff(int discount) {
    return '$discount% OFF';
  }

  @override
  String get errorJobNotExist => 'Job does not exist';

  @override
  String get errorJobTaken => 'Job already taken';

  @override
  String get errorSyncingPermissions =>
      'Syncing security permissions... please wait.';

  @override
  String get errorUpdateStatus => 'Could not update status';

  @override
  String errorAcceptJob(String error) {
    return 'Failed to accept job: $error';
  }

  @override
  String errorUpdateOrder(String error) {
    return 'Failed to update order: $error';
  }

  @override
  String get errorFailedToSendOtp => 'Failed to send OTP';

  @override
  String get errorInvalidCode => 'Invalid code';

  @override
  String get errorSessionExpired => 'Session expired';

  @override
  String get errorVerificationFailed => 'Verification failed';

  @override
  String get actionVerify => 'Verify';

  @override
  String get otpResendButton => 'Resend';

  @override
  String get jobPaymentCard => 'Card';

  @override
  String get jobHideProducts => 'Hide';

  @override
  String get jobShowProducts => 'Show';

  @override
  String jobItemsCount(int count) {
    return '$count items';
  }

  @override
  String jobCollectPaymentWarning(Object amount) {
    return 'Collect $amount';
  }
}
