// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'common_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CommonLocalizationsEn extends CommonLocalizations {
  CommonLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get close => 'Close';

  @override
  String get next => 'Next';

  @override
  String get done => 'Done';

  @override
  String get retry => 'Retry';

  @override
  String get submit => 'Submit';

  @override
  String get search => 'Search';

  @override
  String get loading => 'Loading';

  @override
  String get sending => 'Sending';

  @override
  String get saving => 'Saving';

  @override
  String get or => 'or';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get all => 'All';

  @override
  String get none => 'None';

  @override
  String get required => 'Required';

  @override
  String get optional => 'Optional';

  @override
  String get copied => 'Copied';

  @override
  String get resend => 'Resend';

  @override
  String get verify => 'Verify';

  @override
  String get approve => 'Approve';

  @override
  String get reject => 'Reject';

  @override
  String get suspend => 'Suspend';

  @override
  String get activate => 'Activate';

  @override
  String get decline => 'Decline';

  @override
  String get reinstate => 'Reinstate';

  @override
  String get ban => 'Ban';

  @override
  String get unban => 'Unban';

  @override
  String get review => 'Review';

  @override
  String get manage => 'Manage';

  @override
  String get create => 'Create';

  @override
  String get update => 'Update';

  @override
  String get add => 'Add';

  @override
  String get remove => 'Remove';

  @override
  String get change => 'Change';

  @override
  String get select => 'Select';

  @override
  String get upload => 'Upload';

  @override
  String get logout => 'Logout';

  @override
  String get word_continue => 'Continue';

  @override
  String get skip => 'Skip';

  @override
  String get reset => 'Reset';

  @override
  String get send => 'Send';

  @override
  String get copy => 'Copy';

  @override
  String get apply => 'Apply';

  @override
  String get clear => 'Clear';

  @override
  String get pending => 'Pending';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get food => 'Food';

  @override
  String get stores => 'Stores';

  @override
  String get shoppingCart => 'Shopping Cart';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get changeImage => 'Change Image';

  @override
  String get status_pending => 'Pending';

  @override
  String get status_active => 'Active';

  @override
  String get status_inactive => 'Inactive';

  @override
  String get status_approved => 'Approved';

  @override
  String get status_rejected => 'Rejected';

  @override
  String get status_suspended => 'Suspended';

  @override
  String get status_banned => 'Banned';

  @override
  String get status_live => 'Live';

  @override
  String get status_offline => 'Offline';

  @override
  String get status_online => 'Online';

  @override
  String get status_delivered => 'Delivered';

  @override
  String get status_cancelled => 'Cancelled';

  @override
  String get status_processing => 'Processing';

  @override
  String get status_ready => 'Ready';

  @override
  String get status_sent => 'Sent';

  @override
  String get status_declined => 'Declined';

  @override
  String get status_verified => 'Verified';

  @override
  String get status_draft => 'Draft';

  @override
  String get status_in_progress => 'In Progress';

  @override
  String get role_admin => 'Admin';

  @override
  String get role_administrator => 'Administrator';

  @override
  String get role_customer => 'Customer';

  @override
  String get role_restaurant => 'Restaurant';

  @override
  String get role_rider => 'Rider';

  @override
  String get role_platform_admin => 'Platform Admin';

  @override
  String get role_restaurant_owner => 'Restaurant Owner';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signIn => 'Sign In';

  @override
  String get signOut => 'Sign Out';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confPassword => 'Confirm Password';

  @override
  String get name => 'Full Name';

  @override
  String get phone => 'Phone Number';

  @override
  String get customer => 'Customer';

  @override
  String get customers => 'Customers';

  @override
  String get restaurants => 'Restaurants';

  @override
  String enterField(String name) {
    return 'Enter: $name';
  }

  @override
  String get details => 'details';

  @override
  String get loading_default => 'Loading...';

  @override
  String loading_status_message(String message) {
    return '$message... Please wait.';
  }

  @override
  String get checkingCredentials => 'Checking credentials...';

  @override
  String get registeringAccount => 'Registering account...';

  @override
  String get syncingPermissions =>
      'Syncing security permissions... please wait.';

  @override
  String get uploading => 'Uploading...';

  @override
  String error(Object message) {
    return 'Error: $message';
  }

  @override
  String get errorRequired => 'This field is required';

  @override
  String get errorInvalidFormat => 'Invalid format';

  @override
  String get errorInvalidEmail => 'Please enter a valid email address';

  @override
  String get errorInvalidPassword => 'Password does not meet the requirements';

  @override
  String get errorPasswordMismatch => 'Passwords do not match';

  @override
  String get errorNoImageSelected => 'Please select an image first';

  @override
  String get errorNetworkUnavailable =>
      'Network unavailable. Please check your connection.';

  @override
  String get errorPermissionDenied =>
      'You do not have permission to perform this action.';

  @override
  String get errorUnknown => 'An unexpected error occurred. Please try again.';

  @override
  String get errorLoginFailed => 'Login failed. Please check your credentials.';

  @override
  String get errorNoRecordFound => 'No record found.';

  @override
  String errorOperationFailed(String error) {
    return 'Operation failed: $error';
  }

  @override
  String errorOccurred(String error) {
    return 'An error occurred: $error';
  }

  @override
  String get errorEnterEmailPassword => 'Please enter your email and password.';

  @override
  String get errorNoPhone => 'No phone number provided.';

  @override
  String get errorNipInvalid => 'Please enter a valid 10-digit NIP';

  @override
  String get errorRegonInvalid => 'Please enter a valid 9 or 14-digit REGON';

  @override
  String get errorPostalCodeInvalid =>
      'Please enter a valid postal code (XX-XXX)';

  @override
  String get errorVerificationFailed => 'Verification failed.';

  @override
  String get errorAccountBlocked =>
      'Your account moight be blocked, please contact support!';

  @override
  String get successSaved => 'Changes saved successfully.';

  @override
  String get successCreated => 'Created successfully.';

  @override
  String get successUpdated => 'Updated successfully.';

  @override
  String get successDeleted => 'Deleted successfully.';

  @override
  String get successUploaded => 'Uploaded successfully.';

  @override
  String get successSent => 'Sent successfully.';

  @override
  String get successCopied => 'Copied to clipboard.';

  @override
  String get confirmDeleteTitle => 'Delete?';

  @override
  String get confirmDeleteBody => 'This action cannot be undone.';

  @override
  String get confirmCancelButton => 'Cancel';

  @override
  String get confirmProceedButton => 'Proceed';

  @override
  String get field_error_required => 'This field is required';

  @override
  String get field_error_invalid_format => 'Invalid format';

  @override
  String get field_error_password_req =>
      'Password does not meet the requirements';

  @override
  String get field_email_message => 'Please enter a valid email address';

  @override
  String get field_nip_message => 'Please enter a valid 10-digit NIP';

  @override
  String get field_regon_message => 'Please enter a valid 9 or 14-digit REGON';

  @override
  String get field_postal_code_message =>
      'Please enter a valid postal code (XX-XXX)';

  @override
  String get searchAddress => 'Search for address...';

  @override
  String get map_address_not_found => 'Address not found';

  @override
  String get map_fetching_address => 'Fetching address...';

  @override
  String get map_confirm_button => 'Confirm Location';

  @override
  String get overview => 'Overview';

  @override
  String get notifications => 'Notifications';

  @override
  String get users => 'Users';

  @override
  String get back => 'Back';

  @override
  String get goBack => 'Go Back';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get unknown => 'Unknown';

  @override
  String get getStarted => 'Get Started';

  @override
  String currency_pl(String amount) {
    return '$amount zł';
  }

  @override
  String get time_just_now => 'Just now';

  @override
  String time_minutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '1 minute ago',
    );
    return '$_temp0';
  }

  @override
  String time_hours(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '1 hour ago',
    );
    return '$_temp0';
  }

  @override
  String time_date_format(String day, String month) {
    return '$day.$month';
  }

  @override
  String get payment_cash => 'Cash on Delivery';

  @override
  String get payment_stripe => 'Stripe';

  @override
  String get otp_verify_title => 'Verify your number';

  @override
  String otp_sent_to(String phone) {
    return 'We sent a 6-digit code to\n$phone';
  }

  @override
  String otp_enter_digits(int count) {
    return 'Please enter all $count digits.';
  }

  @override
  String get otp_not_started => 'Verification not started. Please resend.';

  @override
  String get otp_invalid_code => 'Invalid code. Try again.';

  @override
  String get otp_resend_prompt => 'Didn\'t receive the code? ';

  @override
  String otp_resend_timer(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get notif_sheet_title => 'Notifications';

  @override
  String notif_unread_count(int count) {
    return '$count new';
  }

  @override
  String get notif_empty_title => 'No notifications yet';

  @override
  String get notif_empty_subtitle =>
      'We\'ll let you know when something important happens.';

  @override
  String get notif_time_just_now => 'Just now';

  @override
  String notif_time_minutes(int count) {
    return '${count}m ago';
  }

  @override
  String notif_time_hours(int count) {
    return '${count}h ago';
  }

  @override
  String get notif_time_yesterday => 'Yesterday';

  @override
  String notif_time_days(int count) {
    return '${count}d ago';
  }

  @override
  String get notifications_all_read => 'Mark all as read';

  @override
  String get addrLabelFallback => 'Home Address';

  @override
  String get addrTranslating => 'Updating address...';

  @override
  String get addrErrorLoading => 'Could not load address detail';

  @override
  String addrBuilding(String number) {
    return 'Building: $number';
  }

  @override
  String addrFlat(String number) {
    return 'Flat: $number';
  }

  @override
  String get addrSeeInMaps => 'See in Maps';

  @override
  String get addrDeleteTitle => 'Delete Address?';

  @override
  String addrDeleteBody(String label) {
    return 'Are you sure you want to remove \'$label\' from your saved addresses?';
  }

  @override
  String get addrDeleted => 'Address removed successfully';

  @override
  String get addressLabel => 'Address Label';

  @override
  String get locationDetails => 'Location Details';

  @override
  String get house => 'House/Bldg*';

  @override
  String get flat => 'Floor/Flat';

  @override
  String get street => 'Street / Area';

  @override
  String get city => 'City';

  @override
  String get postcode => 'Postcode';

  @override
  String get state => 'State';

  @override
  String get saveAddress => 'Save Address';

  @override
  String get addressSavedSuccess => 'Address saved successfully!';

  @override
  String addressSaveError(Object error) {
    return 'Error: $error';
  }

  @override
  String get aptPrefix => 'Apt';

  @override
  String get work => 'Work';

  @override
  String get other => 'Other';

  @override
  String get orderDetails => 'Order Details';

  @override
  String get viewItems => 'View Items';

  @override
  String get orderStatus => 'Order Status';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String get orderId => 'Order ID';

  @override
  String get orderType => 'Order Type';

  @override
  String get orderedAt => 'Ordered At';

  @override
  String get payment => 'Payment';

  @override
  String get total => 'Total';

  @override
  String get deliveryFee => 'Delivery Fee';

  @override
  String get deliveryAddress => 'Delivery Address';

  @override
  String get pickupLocation => 'Pickup Location';

  @override
  String get pickupFromStore => 'Pick up from store';

  @override
  String get pickupCounterHint => 'Show this order at the counter';

  @override
  String get foodDelivery => 'Food Delivery';

  @override
  String get pickup => 'Pickup';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusInProgress => 'In Progress';

  @override
  String get statusReady => 'Ready';

  @override
  String get statusDelivered => 'Delivered';

  @override
  String get labelProcessing => 'Processing';

  @override
  String get sublabelProcessing => 'We received your order';

  @override
  String get labelAccepted => 'Accepted';

  @override
  String get sublabelAccepted => 'Restaurant confirmed';

  @override
  String get labelOnWay => 'On the Way';

  @override
  String get sublabelOnWay => 'Driver is heading to you';

  @override
  String get labelEnjoy => 'Enjoy your meal!';

  @override
  String get youRatedOrder => 'You rated this order';

  @override
  String get ratingFood => 'Food';

  @override
  String get ratingDriver => 'Driver';

  @override
  String get errorAddressNotAvailable => 'Address not available';

  @override
  String get errorAddressNotFound => 'Address not found';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get orders => 'Orders';

  @override
  String get items => 'Items';

  @override
  String itemsTitle(Object items) {
    return 'Items $items';
  }

  @override
  String menusTitle(Object name) {
    return '$name Menus';
  }

  @override
  String get favorites => 'Favorites';

  @override
  String get questionAppExit => 'Are you sure you want to exit the app?';

  @override
  String get testCloudFunctions => 'Test Cloud Functions';

  @override
  String get tapToUploadImage => 'Tap to upload image.';

  @override
  String get cropPhotoTitle => 'Crop Photo';

  @override
  String get imagePickerChooseFromGallery => 'Choose from Gallery';

  @override
  String get imagePickerChooseFromGallerySubtitle => 'Pick an existing photo';

  @override
  String get imagePickerTakePhoto => 'Take a Photo';

  @override
  String get imagePickerTakePhotoSubtitle => 'Use your camera';
}
