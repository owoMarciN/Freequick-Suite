import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'common_localizations_de.dart';
import 'common_localizations_en.dart';
import 'common_localizations_ko.dart';
import 'common_localizations_pl.dart';
import 'common_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CommonLocalizations
/// returned by `CommonLocalizations.of(context)`.
///
/// Applications need to include `CommonLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'common/common_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CommonLocalizations.localizationsDelegates,
///   supportedLocales: CommonLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the CommonLocalizations.supportedLocales
/// property.
abstract class CommonLocalizations {
  CommonLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CommonLocalizations? of(BuildContext context) {
    return Localizations.of<CommonLocalizations>(context, CommonLocalizations);
  }

  static const LocalizationsDelegate<CommonLocalizations> delegate =
      _CommonLocalizationsDelegate();

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

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending'**
  String get sending;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving'**
  String get saving;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @suspend.
  ///
  /// In en, this message translates to:
  /// **'Suspend'**
  String get suspend;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @reinstate.
  ///
  /// In en, this message translates to:
  /// **'Reinstate'**
  String get reinstate;

  /// No description provided for @ban.
  ///
  /// In en, this message translates to:
  /// **'Ban'**
  String get ban;

  /// No description provided for @unban.
  ///
  /// In en, this message translates to:
  /// **'Unban'**
  String get unban;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @word_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get word_continue;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @stores.
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get stores;

  /// No description provided for @shoppingCart.
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get shoppingCart;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @changeImage.
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get changeImage;

  /// No description provided for @status_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get status_pending;

  /// No description provided for @status_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get status_active;

  /// No description provided for @status_inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get status_inactive;

  /// No description provided for @status_approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get status_approved;

  /// No description provided for @status_rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get status_rejected;

  /// No description provided for @status_suspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get status_suspended;

  /// No description provided for @status_banned.
  ///
  /// In en, this message translates to:
  /// **'Banned'**
  String get status_banned;

  /// No description provided for @status_live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get status_live;

  /// No description provided for @status_offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get status_offline;

  /// No description provided for @status_online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get status_online;

  /// No description provided for @status_delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get status_delivered;

  /// No description provided for @status_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get status_cancelled;

  /// No description provided for @status_processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get status_processing;

  /// No description provided for @status_ready.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get status_ready;

  /// No description provided for @status_sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get status_sent;

  /// No description provided for @status_declined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get status_declined;

  /// No description provided for @status_verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get status_verified;

  /// No description provided for @status_draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get status_draft;

  /// No description provided for @status_in_progress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get status_in_progress;

  /// No description provided for @role_admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get role_admin;

  /// No description provided for @role_administrator.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get role_administrator;

  /// No description provided for @role_customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get role_customer;

  /// No description provided for @role_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get role_restaurant;

  /// No description provided for @role_rider.
  ///
  /// In en, this message translates to:
  /// **'Rider'**
  String get role_rider;

  /// No description provided for @role_platform_admin.
  ///
  /// In en, this message translates to:
  /// **'Platform Admin'**
  String get role_platform_admin;

  /// No description provided for @role_restaurant_owner.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Owner'**
  String get role_restaurant_owner;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confPassword;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @customers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customers;

  /// No description provided for @restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurants;

  /// No description provided for @tapToUploadImage.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload image.'**
  String get tapToUploadImage;

  /// No description provided for @loading_default.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading_default;

  /// No description provided for @loading_status_message.
  ///
  /// In en, this message translates to:
  /// **'{message}... Please wait.'**
  String loading_status_message(String message);

  /// No description provided for @checkingCredentials.
  ///
  /// In en, this message translates to:
  /// **'Checking credentials...'**
  String get checkingCredentials;

  /// No description provided for @registeringAccount.
  ///
  /// In en, this message translates to:
  /// **'Registering account...'**
  String get registeringAccount;

  /// No description provided for @syncingPermissions.
  ///
  /// In en, this message translates to:
  /// **'Syncing security permissions... please wait.'**
  String get syncingPermissions;

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// No description provided for @errorRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get errorRequired;

  /// No description provided for @errorInvalidFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid format'**
  String get errorInvalidFormat;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get errorInvalidEmail;

  /// No description provided for @errorInvalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Password does not meet the requirements'**
  String get errorInvalidPassword;

  /// No description provided for @errorPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get errorPasswordMismatch;

  /// No description provided for @errorNoImageSelected.
  ///
  /// In en, this message translates to:
  /// **'Please select an image first'**
  String get errorNoImageSelected;

  /// No description provided for @errorNetworkUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Network unavailable. Please check your connection.'**
  String get errorNetworkUnavailable;

  /// No description provided for @errorPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to perform this action.'**
  String get errorPermissionDenied;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get errorUnknown;

  /// No description provided for @errorLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials.'**
  String get errorLoginFailed;

  /// No description provided for @errorNoRecordFound.
  ///
  /// In en, this message translates to:
  /// **'No record found.'**
  String get errorNoRecordFound;

  /// No description provided for @errorOperationFailed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed: {error}'**
  String errorOperationFailed(String error);

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred: {error}'**
  String errorOccurred(String error);

  /// No description provided for @errorEnterEmailPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password.'**
  String get errorEnterEmailPassword;

  /// No description provided for @errorNoPhone.
  ///
  /// In en, this message translates to:
  /// **'No phone number provided.'**
  String get errorNoPhone;

  /// No description provided for @errorNipInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 10-digit NIP'**
  String get errorNipInvalid;

  /// No description provided for @errorRegonInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 9 or 14-digit REGON'**
  String get errorRegonInvalid;

  /// No description provided for @errorPostalCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid postal code (XX-XXX)'**
  String get errorPostalCodeInvalid;

  /// No description provided for @errorVerificationFailed.
  ///
  /// In en, this message translates to:
  /// **'Verification failed.'**
  String get errorVerificationFailed;

  /// No description provided for @errorAccountBlocked.
  ///
  /// In en, this message translates to:
  /// **'Your account moight be blocked, please contact support!'**
  String get errorAccountBlocked;

  /// No description provided for @successSaved.
  ///
  /// In en, this message translates to:
  /// **'Changes saved successfully.'**
  String get successSaved;

  /// No description provided for @successCreated.
  ///
  /// In en, this message translates to:
  /// **'Created successfully.'**
  String get successCreated;

  /// No description provided for @successUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated successfully.'**
  String get successUpdated;

  /// No description provided for @successDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted successfully.'**
  String get successDeleted;

  /// No description provided for @successUploaded.
  ///
  /// In en, this message translates to:
  /// **'Uploaded successfully.'**
  String get successUploaded;

  /// No description provided for @successSent.
  ///
  /// In en, this message translates to:
  /// **'Sent successfully.'**
  String get successSent;

  /// No description provided for @successCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard.'**
  String get successCopied;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete?'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get confirmDeleteBody;

  /// No description provided for @confirmCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get confirmCancelButton;

  /// No description provided for @confirmProceedButton.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get confirmProceedButton;

  /// No description provided for @field_error_required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get field_error_required;

  /// No description provided for @field_error_invalid_format.
  ///
  /// In en, this message translates to:
  /// **'Invalid format'**
  String get field_error_invalid_format;

  /// No description provided for @field_error_password_req.
  ///
  /// In en, this message translates to:
  /// **'Password does not meet the requirements'**
  String get field_error_password_req;

  /// No description provided for @field_email_message.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get field_email_message;

  /// No description provided for @field_nip_message.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 10-digit NIP'**
  String get field_nip_message;

  /// No description provided for @field_regon_message.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 9 or 14-digit REGON'**
  String get field_regon_message;

  /// No description provided for @field_postal_code_message.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid postal code (XX-XXX)'**
  String get field_postal_code_message;

  /// No description provided for @searchAddress.
  ///
  /// In en, this message translates to:
  /// **'Search for address...'**
  String get searchAddress;

  /// No description provided for @map_address_not_found.
  ///
  /// In en, this message translates to:
  /// **'Address not found'**
  String get map_address_not_found;

  /// No description provided for @map_fetching_address.
  ///
  /// In en, this message translates to:
  /// **'Fetching address...'**
  String get map_fetching_address;

  /// No description provided for @map_confirm_button.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get map_confirm_button;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @dismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismiss;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @currency_pl.
  ///
  /// In en, this message translates to:
  /// **'{amount} zł'**
  String currency_pl(String amount);

  /// No description provided for @time_just_now.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get time_just_now;

  /// No description provided for @time_minutes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 minute ago} other{{count} minutes ago}}'**
  String time_minutes(int count);

  /// No description provided for @time_hours.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour ago} other{{count} hours ago}}'**
  String time_hours(int count);

  /// No description provided for @time_date_format.
  ///
  /// In en, this message translates to:
  /// **'{day}.{month}'**
  String time_date_format(String day, String month);

  /// No description provided for @payment_cash.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get payment_cash;

  /// No description provided for @payment_stripe.
  ///
  /// In en, this message translates to:
  /// **'Stripe'**
  String get payment_stripe;

  /// No description provided for @otp_verify_title.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get otp_verify_title;

  /// No description provided for @otp_sent_to.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to\n{phone}'**
  String otp_sent_to(String phone);

  /// No description provided for @otp_enter_digits.
  ///
  /// In en, this message translates to:
  /// **'Please enter all {count} digits.'**
  String otp_enter_digits(int count);

  /// No description provided for @otp_not_started.
  ///
  /// In en, this message translates to:
  /// **'Verification not started. Please resend.'**
  String get otp_not_started;

  /// No description provided for @otp_invalid_code.
  ///
  /// In en, this message translates to:
  /// **'Invalid code. Try again.'**
  String get otp_invalid_code;

  /// No description provided for @otp_resend_prompt.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code? '**
  String get otp_resend_prompt;

  /// No description provided for @otp_resend_timer.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String otp_resend_timer(int seconds);

  /// No description provided for @notif_sheet_title.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notif_sheet_title;

  /// No description provided for @notif_unread_count.
  ///
  /// In en, this message translates to:
  /// **'{count} new'**
  String notif_unread_count(int count);

  /// No description provided for @notif_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get notif_empty_title;

  /// No description provided for @notif_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll let you know when something important happens.'**
  String get notif_empty_subtitle;

  /// No description provided for @notif_time_just_now.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get notif_time_just_now;

  /// No description provided for @notif_time_minutes.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String notif_time_minutes(int count);

  /// No description provided for @notif_time_hours.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String notif_time_hours(int count);

  /// No description provided for @notif_time_yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get notif_time_yesterday;

  /// No description provided for @notif_time_days.
  ///
  /// In en, this message translates to:
  /// **'{count}d ago'**
  String notif_time_days(int count);

  /// No description provided for @notifications_all_read.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get notifications_all_read;

  /// No description provided for @addrLabelFallback.
  ///
  /// In en, this message translates to:
  /// **'Home Address'**
  String get addrLabelFallback;

  /// No description provided for @addrTranslating.
  ///
  /// In en, this message translates to:
  /// **'Updating address...'**
  String get addrTranslating;

  /// No description provided for @addrErrorLoading.
  ///
  /// In en, this message translates to:
  /// **'Could not load address detail'**
  String get addrErrorLoading;

  /// No description provided for @addrBuilding.
  ///
  /// In en, this message translates to:
  /// **'Building: {number}'**
  String addrBuilding(String number);

  /// No description provided for @addrFlat.
  ///
  /// In en, this message translates to:
  /// **'Flat: {number}'**
  String addrFlat(String number);

  /// No description provided for @addrSeeInMaps.
  ///
  /// In en, this message translates to:
  /// **'See in Maps'**
  String get addrSeeInMaps;

  /// No description provided for @addrDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Address?'**
  String get addrDeleteTitle;

  /// No description provided for @addrDeleteBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove \'{label}\' from your saved addresses?'**
  String addrDeleteBody(String label);

  /// No description provided for @addrDeleted.
  ///
  /// In en, this message translates to:
  /// **'Address removed successfully'**
  String get addrDeleted;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @viewItems.
  ///
  /// In en, this message translates to:
  /// **'View Items'**
  String get viewItems;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @orderType.
  ///
  /// In en, this message translates to:
  /// **'Order Type'**
  String get orderType;

  /// No description provided for @orderedAt.
  ///
  /// In en, this message translates to:
  /// **'Ordered At'**
  String get orderedAt;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @pickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Pickup Location'**
  String get pickupLocation;

  /// No description provided for @pickupFromStore.
  ///
  /// In en, this message translates to:
  /// **'Pick up from store'**
  String get pickupFromStore;

  /// No description provided for @pickupCounterHint.
  ///
  /// In en, this message translates to:
  /// **'Show this order at the counter'**
  String get pickupCounterHint;

  /// No description provided for @foodDelivery.
  ///
  /// In en, this message translates to:
  /// **'Food Delivery'**
  String get foodDelivery;

  /// No description provided for @pickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get pickup;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get statusInProgress;

  /// No description provided for @statusReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get statusReady;

  /// No description provided for @statusDelivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get statusDelivered;

  /// No description provided for @labelProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get labelProcessing;

  /// No description provided for @sublabelProcessing.
  ///
  /// In en, this message translates to:
  /// **'We received your order'**
  String get sublabelProcessing;

  /// No description provided for @labelAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get labelAccepted;

  /// No description provided for @sublabelAccepted.
  ///
  /// In en, this message translates to:
  /// **'Restaurant confirmed'**
  String get sublabelAccepted;

  /// No description provided for @labelOnWay.
  ///
  /// In en, this message translates to:
  /// **'On the Way'**
  String get labelOnWay;

  /// No description provided for @sublabelOnWay.
  ///
  /// In en, this message translates to:
  /// **'Driver is heading to you'**
  String get sublabelOnWay;

  /// No description provided for @labelEnjoy.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your meal!'**
  String get labelEnjoy;

  /// No description provided for @youRatedOrder.
  ///
  /// In en, this message translates to:
  /// **'You rated this order'**
  String get youRatedOrder;

  /// No description provided for @ratingFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get ratingFood;

  /// No description provided for @ratingDriver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get ratingDriver;

  /// No description provided for @errorAddressNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Address not available'**
  String get errorAddressNotAvailable;

  /// No description provided for @errorAddressNotFound.
  ///
  /// In en, this message translates to:
  /// **'Address not found'**
  String get errorAddressNotFound;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @questionAppExit.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit the app?'**
  String get questionAppExit;

  /// No description provided for @testCloudFunctions.
  ///
  /// In en, this message translates to:
  /// **'Test Cloud Functions'**
  String get testCloudFunctions;
}

class _CommonLocalizationsDelegate
    extends LocalizationsDelegate<CommonLocalizations> {
  const _CommonLocalizationsDelegate();

  @override
  Future<CommonLocalizations> load(Locale locale) {
    return SynchronousFuture<CommonLocalizations>(
        lookupCommonLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'ko', 'pl', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_CommonLocalizationsDelegate old) => false;
}

CommonLocalizations lookupCommonLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return CommonLocalizationsDe();
    case 'en':
      return CommonLocalizationsEn();
    case 'ko':
      return CommonLocalizationsKo();
    case 'pl':
      return CommonLocalizationsPl();
    case 'uk':
      return CommonLocalizationsUk();
  }

  throw FlutterError(
      'CommonLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
