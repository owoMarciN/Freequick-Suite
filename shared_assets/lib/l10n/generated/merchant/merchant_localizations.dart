import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'merchant_localizations_de.dart';
import 'merchant_localizations_en.dart';
import 'merchant_localizations_ko.dart';
import 'merchant_localizations_pl.dart';
import 'merchant_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of MerchantLocalizations
/// returned by `MerchantLocalizations.of(context)`.
///
/// Applications need to include `MerchantLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'merchant/merchant_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: MerchantLocalizations.localizationsDelegates,
///   supportedLocales: MerchantLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the MerchantLocalizations.supportedLocales
/// property.
abstract class MerchantLocalizations {
  MerchantLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static MerchantLocalizations? of(BuildContext context) {
    return Localizations.of<MerchantLocalizations>(
        context, MerchantLocalizations);
  }

  static const LocalizationsDelegate<MerchantLocalizations> delegate =
      _MerchantLocalizationsDelegate();

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

  /// No description provided for @admin_panel.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel'**
  String get admin_panel;

  /// No description provided for @join_requests.
  ///
  /// In en, this message translates to:
  /// **'Join Requests'**
  String get join_requests;

  /// No description provided for @edit_sheet_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Sheet'**
  String get edit_sheet_title;

  /// No description provided for @admin_notifications_tab_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get admin_notifications_tab_send;

  /// No description provided for @admin_notifications_tab_history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get admin_notifications_tab_history;

  /// No description provided for @admin_notifications_target_audience.
  ///
  /// In en, this message translates to:
  /// **'Target Audience'**
  String get admin_notifications_target_audience;

  /// No description provided for @admin_notifications_audience_all.
  ///
  /// In en, this message translates to:
  /// **'All Users'**
  String get admin_notifications_audience_all;

  /// No description provided for @admin_notifications_audience_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get admin_notifications_audience_restaurants;

  /// No description provided for @admin_notifications_audience_specific.
  ///
  /// In en, this message translates to:
  /// **'Specific Users'**
  String get admin_notifications_audience_specific;

  /// No description provided for @admin_notifications_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search users by name or email...'**
  String get admin_notifications_search_hint;

  /// No description provided for @admin_notifications_search_hint_more.
  ///
  /// In en, this message translates to:
  /// **'Add another user...'**
  String get admin_notifications_search_hint_more;

  /// No description provided for @admin_notifications_title_label.
  ///
  /// In en, this message translates to:
  /// **'Notification Title'**
  String get admin_notifications_title_label;

  /// No description provided for @admin_notifications_title_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter title'**
  String get admin_notifications_title_hint;

  /// No description provided for @admin_notifications_body_label.
  ///
  /// In en, this message translates to:
  /// **'Message Body'**
  String get admin_notifications_body_label;

  /// No description provided for @admin_notifications_body_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter message'**
  String get admin_notifications_body_hint;

  /// No description provided for @admin_notifications_required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get admin_notifications_required;

  /// No description provided for @admin_notifications_sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get admin_notifications_sending;

  /// No description provided for @admin_notifications_send_button.
  ///
  /// In en, this message translates to:
  /// **'Send Notification'**
  String get admin_notifications_send_button;

  /// No description provided for @admin_notifications_select_user.
  ///
  /// In en, this message translates to:
  /// **'Please select at least one user'**
  String get admin_notifications_select_user;

  /// No description provided for @admin_notifications_sent_one.
  ///
  /// In en, this message translates to:
  /// **'Notification sent successfully'**
  String get admin_notifications_sent_one;

  /// No description provided for @admin_notifications_sent_many.
  ///
  /// In en, this message translates to:
  /// **'Notifications sent to {count} users'**
  String admin_notifications_sent_many(int count);

  /// No description provided for @admin_notifications_history_empty.
  ///
  /// In en, this message translates to:
  /// **'No notification history yet'**
  String get admin_notifications_history_empty;

  /// No description provided for @admin_notifications_history_sent_badge.
  ///
  /// In en, this message translates to:
  /// **'SENT'**
  String get admin_notifications_history_sent_badge;

  /// No description provided for @admin_notifications_history_sent_count.
  ///
  /// In en, this message translates to:
  /// **'{count} sent'**
  String admin_notifications_history_sent_count(int count);

  /// No description provided for @admin_overview_platform_glance.
  ///
  /// In en, this message translates to:
  /// **'Platform at a Glance'**
  String get admin_overview_platform_glance;

  /// No description provided for @admin_overview_revenue_30d.
  ///
  /// In en, this message translates to:
  /// **'Revenue (Last 30 Days)'**
  String get admin_overview_revenue_30d;

  /// No description provided for @admin_overview_pending_requests.
  ///
  /// In en, this message translates to:
  /// **'Pending Join Requests'**
  String get admin_overview_pending_requests;

  /// No description provided for @admin_overview_view_all.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get admin_overview_view_all;

  /// No description provided for @admin_overview_order_status.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get admin_overview_order_status;

  /// No description provided for @admin_overview_top_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Top Restaurants'**
  String get admin_overview_top_restaurants;

  /// No description provided for @admin_overview_stat_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Total Restaurants'**
  String get admin_overview_stat_restaurants;

  /// No description provided for @admin_overview_stat_restaurants_sub.
  ///
  /// In en, this message translates to:
  /// **'{active} active'**
  String admin_overview_stat_restaurants_sub(int active);

  /// No description provided for @admin_overview_stat_orders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get admin_overview_stat_orders;

  /// No description provided for @admin_overview_stat_orders_sub.
  ///
  /// In en, this message translates to:
  /// **'{today} today'**
  String admin_overview_stat_orders_sub(int today);

  /// No description provided for @admin_overview_stat_revenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get admin_overview_stat_revenue;

  /// No description provided for @admin_overview_stat_revenue_sub.
  ///
  /// In en, this message translates to:
  /// **'{last7d} PLN last 7d'**
  String admin_overview_stat_revenue_sub(String last7d);

  /// No description provided for @admin_overview_stat_avg.
  ///
  /// In en, this message translates to:
  /// **'Avg Order Value'**
  String get admin_overview_stat_avg;

  /// No description provided for @admin_overview_stat_avg_sub.
  ///
  /// In en, this message translates to:
  /// **'{menus} menus • {items} items'**
  String admin_overview_stat_avg_sub(int menus, int items);

  /// No description provided for @admin_overview_revenue_no_data.
  ///
  /// In en, this message translates to:
  /// **'No revenue data available.'**
  String get admin_overview_revenue_no_data;

  /// No description provided for @admin_overview_no_pending.
  ///
  /// In en, this message translates to:
  /// **'No pending join requests.'**
  String get admin_overview_no_pending;

  /// No description provided for @admin_overview_pending_nip.
  ///
  /// In en, this message translates to:
  /// **'NIP: {nip} • {date}'**
  String admin_overview_pending_nip(String nip, String date);

  /// No description provided for @admin_overview_no_orders.
  ///
  /// In en, this message translates to:
  /// **'No orders yet.'**
  String get admin_overview_no_orders;

  /// No description provided for @admin_overview_no_order_data.
  ///
  /// In en, this message translates to:
  /// **'No order data available.'**
  String get admin_overview_no_order_data;

  /// No description provided for @admin_overview_orders_count.
  ///
  /// In en, this message translates to:
  /// **'{count} orders'**
  String admin_overview_orders_count(int count);

  /// No description provided for @requests_tab_registrations.
  ///
  /// In en, this message translates to:
  /// **'Registrations'**
  String get requests_tab_registrations;

  /// No description provided for @requests_tab_go_live.
  ///
  /// In en, this message translates to:
  /// **'Go Live'**
  String get requests_tab_go_live;

  /// No description provided for @requests_filter_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get requests_filter_pending;

  /// No description provided for @requests_filter_approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get requests_filter_approved;

  /// No description provided for @requests_filter_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get requests_filter_active;

  /// No description provided for @requests_filter_rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get requests_filter_rejected;

  /// No description provided for @requests_filter_suspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get requests_filter_suspended;

  /// No description provided for @requests_filter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get requests_filter_all;

  /// No description provided for @requests_empty_filtered.
  ///
  /// In en, this message translates to:
  /// **'No {status} requests found.'**
  String requests_empty_filtered(String status);

  /// No description provided for @requests_empty_all.
  ///
  /// In en, this message translates to:
  /// **'No registration requests found.'**
  String get requests_empty_all;

  /// No description provided for @requests_go_live_empty.
  ///
  /// In en, this message translates to:
  /// **'No Go Live requests found.'**
  String get requests_go_live_empty;

  /// No description provided for @requests_go_live_section_pending.
  ///
  /// In en, this message translates to:
  /// **'PENDING REVIEW'**
  String get requests_go_live_section_pending;

  /// No description provided for @requests_go_live_section_reviewed.
  ///
  /// In en, this message translates to:
  /// **'REVIEWED'**
  String get requests_go_live_section_reviewed;

  /// No description provided for @requests_go_live_requested.
  ///
  /// In en, this message translates to:
  /// **'Requested {timeAgo} ({date})'**
  String requests_go_live_requested(String timeAgo, String date);

  /// No description provided for @requests_badge_activated.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get requests_badge_activated;

  /// No description provided for @requests_badge_declined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get requests_badge_declined;

  /// No description provided for @requests_badge_pending_review.
  ///
  /// In en, this message translates to:
  /// **'Pending Review'**
  String get requests_badge_pending_review;

  /// No description provided for @requests_go_live_activated_on.
  ///
  /// In en, this message translates to:
  /// **'Activated on {date}'**
  String requests_go_live_activated_on(String date);

  /// No description provided for @requests_go_live_declined_on.
  ///
  /// In en, this message translates to:
  /// **'Declined on {date}'**
  String requests_go_live_declined_on(String date);

  /// No description provided for @requests_check_logo.
  ///
  /// In en, this message translates to:
  /// **'Logo'**
  String get requests_check_logo;

  /// No description provided for @requests_check_banner.
  ///
  /// In en, this message translates to:
  /// **'Banner'**
  String get requests_check_banner;

  /// No description provided for @requests_check_address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get requests_check_address;

  /// No description provided for @requests_check_iban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get requests_check_iban;

  /// No description provided for @requests_check_photo.
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get requests_check_photo;

  /// No description provided for @requests_check_menu.
  ///
  /// In en, this message translates to:
  /// **'Menu Items'**
  String get requests_check_menu;

  /// No description provided for @requests_setup_progress.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} Setup Tasks'**
  String requests_setup_progress(int completed, int total);

  /// No description provided for @requests_submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted {date}'**
  String requests_submitted(String date);

  /// No description provided for @requests_copied.
  ///
  /// In en, this message translates to:
  /// **'ID copied: {id}'**
  String requests_copied(String id);

  /// No description provided for @requests_confirm_approve_title.
  ///
  /// In en, this message translates to:
  /// **'Approve Restaurant?'**
  String get requests_confirm_approve_title;

  /// No description provided for @requests_confirm_approve_body.
  ///
  /// In en, this message translates to:
  /// **'This will allow the merchant to start setting up their menus and profile.'**
  String get requests_confirm_approve_body;

  /// No description provided for @requests_confirm_reject_title.
  ///
  /// In en, this message translates to:
  /// **'Reject Application?'**
  String get requests_confirm_reject_title;

  /// No description provided for @requests_confirm_reject_body.
  ///
  /// In en, this message translates to:
  /// **'This will prevent the merchant from accessing the dashboard.'**
  String get requests_confirm_reject_body;

  /// No description provided for @requests_confirm_suspend_title.
  ///
  /// In en, this message translates to:
  /// **'Suspend Restaurant?'**
  String get requests_confirm_suspend_title;

  /// No description provided for @requests_confirm_suspend_body.
  ///
  /// In en, this message translates to:
  /// **'This will hide the restaurant and all its items from the platform immediately.'**
  String get requests_confirm_suspend_body;

  /// No description provided for @requests_confirm_reinstate_title.
  ///
  /// In en, this message translates to:
  /// **'Reinstate Restaurant?'**
  String get requests_confirm_reinstate_title;

  /// No description provided for @requests_confirm_reinstate_body.
  ///
  /// In en, this message translates to:
  /// **'This will restore the restaurant to Active status and make it visible to customers again.'**
  String get requests_confirm_reinstate_body;

  /// No description provided for @requests_action_copy_id.
  ///
  /// In en, this message translates to:
  /// **'Copy Restaurant ID'**
  String get requests_action_copy_id;

  /// No description provided for @requests_error_failed.
  ///
  /// In en, this message translates to:
  /// **'Operation failed: {error}'**
  String requests_error_failed(String error);

  /// No description provided for @users_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or email...'**
  String get users_search_hint;

  /// No description provided for @users_empty_filtered.
  ///
  /// In en, this message translates to:
  /// **'No users match your filters.'**
  String get users_empty_filtered;

  /// No description provided for @users_empty_all.
  ///
  /// In en, this message translates to:
  /// **'No users found in the system.'**
  String get users_empty_all;

  /// No description provided for @users_joined.
  ///
  /// In en, this message translates to:
  /// **'Joined {date}'**
  String users_joined(String date);

  /// No description provided for @users_detail_title.
  ///
  /// In en, this message translates to:
  /// **'User Details'**
  String get users_detail_title;

  /// No description provided for @users_detail_id.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get users_detail_id;

  /// No description provided for @users_detail_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get users_detail_phone;

  /// No description provided for @users_detail_joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get users_detail_joined;

  /// No description provided for @users_detail_role.
  ///
  /// In en, this message translates to:
  /// **'Role'**
  String get users_detail_role;

  /// No description provided for @users_ban_body.
  ///
  /// In en, this message translates to:
  /// **'This user will be immediately logged out and prevented from accessing their account.'**
  String get users_ban_body;

  /// No description provided for @users_unban_body.
  ///
  /// In en, this message translates to:
  /// **'This will restore the user\'s access to the platform.'**
  String get users_unban_body;

  /// No description provided for @users_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete User Permanently?'**
  String get users_delete_title;

  /// No description provided for @users_delete_body.
  ///
  /// In en, this message translates to:
  /// **'All user profile data will be permanently removed from the database.'**
  String get users_delete_body;

  /// No description provided for @users_snack_banned.
  ///
  /// In en, this message translates to:
  /// **'User has been banned from the platform.'**
  String get users_snack_banned;

  /// No description provided for @users_snack_unbanned.
  ///
  /// In en, this message translates to:
  /// **'User access has been restored.'**
  String get users_snack_unbanned;

  /// No description provided for @users_snack_deleted.
  ///
  /// In en, this message translates to:
  /// **'User account has been permanently deleted.'**
  String get users_snack_deleted;

  /// No description provided for @users_filter_all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get users_filter_all;

  /// No description provided for @users_filter_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get users_filter_restaurant;

  /// No description provided for @users_filter_admin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get users_filter_admin;

  /// No description provided for @users_filter_customer.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get users_filter_customer;

  /// No description provided for @shell_nav_overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get shell_nav_overview;

  /// No description provided for @shell_nav_orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get shell_nav_orders;

  /// No description provided for @shell_nav_menus.
  ///
  /// In en, this message translates to:
  /// **'Menus'**
  String get shell_nav_menus;

  /// No description provided for @shell_nav_promotions.
  ///
  /// In en, this message translates to:
  /// **'Promotions'**
  String get shell_nav_promotions;

  /// No description provided for @shell_nav_analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get shell_nav_analytics;

  /// No description provided for @shell_nav_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get shell_nav_settings;

  /// No description provided for @shell_restaurant_not_found.
  ///
  /// In en, this message translates to:
  /// **'Restaurant data not found.'**
  String get shell_restaurant_not_found;

  /// No description provided for @shell_finish_setup.
  ///
  /// In en, this message translates to:
  /// **'Finish Setup'**
  String get shell_finish_setup;

  /// No description provided for @shell_my_account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get shell_my_account;

  /// No description provided for @shell_menu_support.
  ///
  /// In en, this message translates to:
  /// **'Support Center'**
  String get shell_menu_support;

  /// No description provided for @shell_menu_sales.
  ///
  /// In en, this message translates to:
  /// **'Sales Contact'**
  String get shell_menu_sales;

  /// No description provided for @shell_menu_cookies.
  ///
  /// In en, this message translates to:
  /// **'Cookie Policy'**
  String get shell_menu_cookies;

  /// No description provided for @shell_menu_settings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get shell_menu_settings;

  /// No description provided for @shell_menu_logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get shell_menu_logout;

  /// No description provided for @shell_already_pending.
  ///
  /// In en, this message translates to:
  /// **'You already have a pending go-live request.'**
  String get shell_already_pending;

  /// No description provided for @shell_go_live_submitted.
  ///
  /// In en, this message translates to:
  /// **'Your go-live request has been submitted for review.'**
  String get shell_go_live_submitted;

  /// No description provided for @shell_error.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String shell_error(String error);

  /// No description provided for @shell_go_offline_title.
  ///
  /// In en, this message translates to:
  /// **'Go Offline?'**
  String get shell_go_offline_title;

  /// No description provided for @shell_go_offline_body.
  ///
  /// In en, this message translates to:
  /// **'Your restaurant will no longer be visible to customers on the platform.'**
  String get shell_go_offline_body;

  /// No description provided for @shell_go_offline_confirm.
  ///
  /// In en, this message translates to:
  /// **'Yes, Go Offline'**
  String get shell_go_offline_confirm;

  /// No description provided for @shell_live_go_offline.
  ///
  /// In en, this message translates to:
  /// **'Live / Go Offline'**
  String get shell_live_go_offline;

  /// No description provided for @shell_go_live_pending.
  ///
  /// In en, this message translates to:
  /// **'Reviewing Request'**
  String get shell_go_live_pending;

  /// No description provided for @shell_go_live_declined.
  ///
  /// In en, this message translates to:
  /// **'Declined - Try Again'**
  String get shell_go_live_declined;

  /// No description provided for @shell_request_go_live.
  ///
  /// In en, this message translates to:
  /// **'Request to Go Live'**
  String get shell_request_go_live;

  /// No description provided for @gate_pending_title.
  ///
  /// In en, this message translates to:
  /// **'Under Review'**
  String get gate_pending_title;

  /// No description provided for @gate_pending_message.
  ///
  /// In en, this message translates to:
  /// **'Our team is currently reviewing your restaurant profile. We will notify you once approved.'**
  String get gate_pending_message;

  /// No description provided for @gate_rejected_title.
  ///
  /// In en, this message translates to:
  /// **'Application Rejected'**
  String get gate_rejected_title;

  /// No description provided for @gate_rejected_message.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, your application was not approved. Please contact support for details.'**
  String get gate_rejected_message;

  /// No description provided for @gate_suspended_title.
  ///
  /// In en, this message translates to:
  /// **'Account Suspended'**
  String get gate_suspended_title;

  /// No description provided for @gate_suspended_message.
  ///
  /// In en, this message translates to:
  /// **'Your account has been suspended due to a policy violation.'**
  String get gate_suspended_message;

  /// No description provided for @gate_default_title.
  ///
  /// In en, this message translates to:
  /// **'Restricted Access'**
  String get gate_default_title;

  /// No description provided for @gate_default_message.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission to access this dashboard yet.'**
  String get gate_default_message;

  /// No description provided for @analytics_section_glance.
  ///
  /// In en, this message translates to:
  /// **'AT A GLANCE'**
  String get analytics_section_glance;

  /// No description provided for @analytics_stat_revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue ({days}d)'**
  String analytics_stat_revenue(int days);

  /// No description provided for @analytics_stat_orders.
  ///
  /// In en, this message translates to:
  /// **'Orders ({days}d)'**
  String analytics_stat_orders(int days);

  /// No description provided for @analytics_stat_today.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Sales'**
  String get analytics_stat_today;

  /// No description provided for @analytics_stat_avg.
  ///
  /// In en, this message translates to:
  /// **'Avg. Order Value'**
  String get analytics_stat_avg;

  /// No description provided for @analytics_section_revenue.
  ///
  /// In en, this message translates to:
  /// **'REVENUE TREND'**
  String get analytics_section_revenue;

  /// No description provided for @analytics_no_revenue.
  ///
  /// In en, this message translates to:
  /// **'No revenue data for this period.'**
  String get analytics_no_revenue;

  /// No description provided for @analytics_section_status.
  ///
  /// In en, this message translates to:
  /// **'ORDER STATUS BREAKDOWN'**
  String get analytics_section_status;

  /// No description provided for @analytics_no_orders.
  ///
  /// In en, this message translates to:
  /// **'No orders found for this period.'**
  String get analytics_no_orders;

  /// No description provided for @analytics_section_popular.
  ///
  /// In en, this message translates to:
  /// **'MOST POPULAR ITEMS'**
  String get analytics_section_popular;

  /// No description provided for @analytics_no_items.
  ///
  /// In en, this message translates to:
  /// **'No item data available.'**
  String get analytics_no_items;

  /// No description provided for @analytics_orders_count.
  ///
  /// In en, this message translates to:
  /// **'{count} orders'**
  String analytics_orders_count(int count);

  /// No description provided for @menus_error.
  ///
  /// In en, this message translates to:
  /// **'Could not load menus: {error}'**
  String menus_error(String error);

  /// No description provided for @menus_empty_title.
  ///
  /// In en, this message translates to:
  /// **'Your menu is empty'**
  String get menus_empty_title;

  /// No description provided for @menus_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create categories like \'Main Courses\' or \'Drinks\' to start organising your kitchen.'**
  String get menus_empty_subtitle;

  /// No description provided for @menus_field_title_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Italian Pizzas'**
  String get menus_field_title_hint;

  /// No description provided for @menus_field_desc_hint.
  ///
  /// In en, this message translates to:
  /// **'Briefly describe what\'s in this section...'**
  String get menus_field_desc_hint;

  /// No description provided for @menus_image_browse.
  ///
  /// In en, this message translates to:
  /// **'JPG or PNG, recommended 16:9'**
  String get menus_image_browse;

  /// No description provided for @menus_created.
  ///
  /// In en, this message translates to:
  /// **'Menu category has been created.'**
  String get menus_created;

  /// No description provided for @menus_updated.
  ///
  /// In en, this message translates to:
  /// **'Menu category has been updated.'**
  String get menus_updated;

  /// No description provided for @menus_deleted.
  ///
  /// In en, this message translates to:
  /// **'Menu category has been removed.'**
  String get menus_deleted;

  /// No description provided for @menus_image_cleanup_error.
  ///
  /// In en, this message translates to:
  /// **'Menu saved, but the old banner could not be removed from storage.'**
  String get menus_image_cleanup_error;

  /// No description provided for @menus_error_missing_ids.
  ///
  /// In en, this message translates to:
  /// **'Required IDs are missing. Cannot delete.'**
  String get menus_error_missing_ids;

  /// No description provided for @items_error.
  ///
  /// In en, this message translates to:
  /// **'Error loading items: {error}'**
  String items_error(String error);

  /// No description provided for @items_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No items here yet'**
  String get items_empty_title;

  /// No description provided for @items_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Start by adding your first dish to this menu.'**
  String get items_empty_subtitle;

  /// No description provided for @items_field_title_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Classic Cheeseburger'**
  String get items_field_title_hint;

  /// No description provided for @items_field_info_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 200g Beef, Cheddar, Pickles'**
  String get items_field_info_hint;

  /// No description provided for @items_field_desc_hint.
  ///
  /// In en, this message translates to:
  /// **'Describe the ingredients and preparation...'**
  String get items_field_desc_hint;

  /// No description provided for @items_field_price_hint.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get items_field_price_hint;

  /// No description provided for @items_field_tags_hint.
  ///
  /// In en, this message translates to:
  /// **'Vegan, Spicy, GlutenFree...'**
  String get items_field_tags_hint;

  /// No description provided for @items_tag_hint.
  ///
  /// In en, this message translates to:
  /// **'Add tags (e.g. Popular)'**
  String get items_tag_hint;

  /// No description provided for @items_added.
  ///
  /// In en, this message translates to:
  /// **'Item has been added to your menu.'**
  String get items_added;

  /// No description provided for @items_updated.
  ///
  /// In en, this message translates to:
  /// **'Item details have been saved.'**
  String get items_updated;

  /// No description provided for @items_deleted.
  ///
  /// In en, this message translates to:
  /// **'Item has been removed from your menu.'**
  String get items_deleted;

  /// No description provided for @items_error_no_image.
  ///
  /// In en, this message translates to:
  /// **'Please upload an image first.'**
  String get items_error_no_image;

  /// No description provided for @items_tag_error_empty.
  ///
  /// In en, this message translates to:
  /// **'Tag cannot be empty.'**
  String get items_tag_error_empty;

  /// No description provided for @items_tag_error_capitalize.
  ///
  /// In en, this message translates to:
  /// **'Tag must start with a capital letter.'**
  String get items_tag_error_capitalize;

  /// No description provided for @items_tag_error_letters.
  ///
  /// In en, this message translates to:
  /// **'Only letters are allowed in tags.'**
  String get items_tag_error_letters;

  /// No description provided for @items_tag_error_duplicate.
  ///
  /// In en, this message translates to:
  /// **'This tag already exists.'**
  String get items_tag_error_duplicate;

  /// No description provided for @items_discount_info.
  ///
  /// In en, this message translates to:
  /// **'e.g. 500g, spicy, vegan'**
  String get items_discount_info;

  /// No description provided for @image_cleanup_error.
  ///
  /// In en, this message translates to:
  /// **'The new image is saved, but the old image could not be removed from storage.'**
  String get image_cleanup_error;

  /// No description provided for @overview_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String overview_welcome(String name);

  /// No description provided for @overview_chef_fallback.
  ///
  /// In en, this message translates to:
  /// **'Chef'**
  String get overview_chef_fallback;

  /// No description provided for @overview_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Here is what is happening with your restaurant today.'**
  String get overview_subtitle;

  /// No description provided for @overview_setup_title.
  ///
  /// In en, this message translates to:
  /// **'Finish your setup'**
  String get overview_setup_title;

  /// No description provided for @overview_setup_progress.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} steps completed'**
  String overview_setup_progress(int completed, int total);

  /// No description provided for @overview_task_logo_title.
  ///
  /// In en, this message translates to:
  /// **'Upload Logo'**
  String get overview_task_logo_title;

  /// No description provided for @overview_task_logo_desc.
  ///
  /// In en, this message translates to:
  /// **'Your brand identity on the customer app.'**
  String get overview_task_logo_desc;

  /// No description provided for @overview_task_banner_title.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Banner'**
  String get overview_task_banner_title;

  /// No description provided for @overview_task_banner_desc.
  ///
  /// In en, this message translates to:
  /// **'A high-quality photo of your best dish.'**
  String get overview_task_banner_desc;

  /// No description provided for @overview_task_address_title.
  ///
  /// In en, this message translates to:
  /// **'Business Address'**
  String get overview_task_address_title;

  /// No description provided for @overview_task_address_desc.
  ///
  /// In en, this message translates to:
  /// **'So customers know where to find you.'**
  String get overview_task_address_desc;

  /// No description provided for @overview_task_photo_title.
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get overview_task_photo_title;

  /// No description provided for @overview_task_photo_desc.
  ///
  /// In en, this message translates to:
  /// **'Add a personal touch to your account.'**
  String get overview_task_photo_desc;

  /// No description provided for @overview_task_menu_title.
  ///
  /// In en, this message translates to:
  /// **'Create Menus'**
  String get overview_task_menu_title;

  /// No description provided for @overview_task_menu_desc.
  ///
  /// In en, this message translates to:
  /// **'Add at least one menu category and one item.'**
  String get overview_task_menu_desc;

  /// No description provided for @overview_task_iban_title.
  ///
  /// In en, this message translates to:
  /// **'Payout Details'**
  String get overview_task_iban_title;

  /// No description provided for @overview_task_iban_desc.
  ///
  /// In en, this message translates to:
  /// **'Enter your IBAN to receive weekly earnings.'**
  String get overview_task_iban_desc;

  /// No description provided for @overview_stat_total_orders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get overview_stat_total_orders;

  /// No description provided for @overview_stat_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get overview_stat_pending;

  /// No description provided for @overview_stat_completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get overview_stat_completed;

  /// No description provided for @overview_stat_revenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get overview_stat_revenue;

  /// No description provided for @promo_empty_title.
  ///
  /// In en, this message translates to:
  /// **'No active promotions'**
  String get promo_empty_title;

  /// No description provided for @promo_empty_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your first campaign to boost your restaurant\'s visibility.'**
  String get promo_empty_subtitle;

  /// No description provided for @promo_field_title_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Summer Burger Fest'**
  String get promo_field_title_hint;

  /// No description provided for @promo_field_desc_hint.
  ///
  /// In en, this message translates to:
  /// **'Explain the offer to your customers...'**
  String get promo_field_desc_hint;

  /// No description provided for @promo_items_linked.
  ///
  /// In en, this message translates to:
  /// **'{count} Item linked'**
  String promo_items_linked(int count);

  /// No description provided for @promo_items_linked_plural.
  ///
  /// In en, this message translates to:
  /// **'{count} Items linked'**
  String promo_items_linked_plural(int count);

  /// No description provided for @promo_date_order_error.
  ///
  /// In en, this message translates to:
  /// **'End date must be after start date.'**
  String get promo_date_order_error;

  /// No description provided for @promo_no_dates.
  ///
  /// In en, this message translates to:
  /// **'Please select both start and end dates.'**
  String get promo_no_dates;

  /// No description provided for @promo_created.
  ///
  /// In en, this message translates to:
  /// **'Promotion is now live.'**
  String get promo_created;

  /// No description provided for @promo_updated.
  ///
  /// In en, this message translates to:
  /// **'Promotion details have been updated.'**
  String get promo_updated;

  /// No description provided for @promo_deleted.
  ///
  /// In en, this message translates to:
  /// **'Promotion has been removed.'**
  String get promo_deleted;

  /// No description provided for @promo_banner_cleanup_error.
  ///
  /// In en, this message translates to:
  /// **'Promotion saved, but the old banner could not be removed from storage.'**
  String get promo_banner_cleanup_error;

  /// No description provided for @promo_error_no_image.
  ///
  /// In en, this message translates to:
  /// **'A banner image is required for new promotions.'**
  String get promo_error_no_image;

  /// No description provided for @promo_link_no_items.
  ///
  /// In en, this message translates to:
  /// **'No items found in your menus.'**
  String get promo_link_no_items;

  /// No description provided for @promo_image_recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended ratio 16:9'**
  String get promo_image_recommended;

  /// No description provided for @settings_error.
  ///
  /// In en, this message translates to:
  /// **'Could not load settings. Please try again.'**
  String get settings_error;

  /// No description provided for @settings_logo_recommended.
  ///
  /// In en, this message translates to:
  /// **'Square PNG or JPG (min. 512x512px)'**
  String get settings_logo_recommended;

  /// No description provided for @settings_logo_uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get settings_logo_uploading;

  /// No description provided for @settings_logo_updated.
  ///
  /// In en, this message translates to:
  /// **'Restaurant logo has been updated.'**
  String get settings_logo_updated;

  /// No description provided for @settings_banner_recommended.
  ///
  /// In en, this message translates to:
  /// **'Wide 16:9 aspect ratio recommended'**
  String get settings_banner_recommended;

  /// No description provided for @settings_banner_updated.
  ///
  /// In en, this message translates to:
  /// **'Cover banner has been updated.'**
  String get settings_banner_updated;

  /// No description provided for @settings_business_updated.
  ///
  /// In en, this message translates to:
  /// **'Business information has been saved.'**
  String get settings_business_updated;

  /// No description provided for @settings_profile_updated.
  ///
  /// In en, this message translates to:
  /// **'Profile changes have been saved.'**
  String get settings_profile_updated;

  /// No description provided for @settings_password_reset_sent.
  ///
  /// In en, this message translates to:
  /// **'A password reset link has been sent to your email.'**
  String get settings_password_reset_sent;

  /// No description provided for @settings_delete_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Are you absolutely sure?'**
  String get settings_delete_dialog_title;

  /// No description provided for @settings_delete_dialog_body.
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible. All your menus, promotions, and history will be wiped.'**
  String get settings_delete_dialog_body;

  /// No description provided for @settings_address_set.
  ///
  /// In en, this message translates to:
  /// **'No address pinned yet'**
  String get settings_address_set;

  /// No description provided for @settings_map_no_pick.
  ///
  /// In en, this message translates to:
  /// **'Please pick a location on the map first.'**
  String get settings_map_no_pick;

  /// No description provided for @settings_profile_name_hint.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get settings_profile_name_hint;

  /// No description provided for @build_user_experience.
  ///
  /// In en, this message translates to:
  /// **'Build the next generation of dining experiences.'**
  String get build_user_experience;

  /// No description provided for @join_thousands.
  ///
  /// In en, this message translates to:
  /// **'Join thousands of restaurants growing their business with our platform.'**
  String get join_thousands;

  /// No description provided for @sign_in_to_dashboard.
  ///
  /// In en, this message translates to:
  /// **'Sign in to Dashboard'**
  String get sign_in_to_dashboard;

  /// No description provided for @create_your_account.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get create_your_account;

  /// No description provided for @new_to_the_platform.
  ///
  /// In en, this message translates to:
  /// **'New to the platform?'**
  String get new_to_the_platform;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_an_account;

  /// No description provided for @with_google.
  ///
  /// In en, this message translates to:
  /// **'with Google'**
  String get with_google;

  /// No description provided for @terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our Terms of Service and Privacy Policy.'**
  String get terms_of_service;

  /// No description provided for @errorNoUserRecord.
  ///
  /// In en, this message translates to:
  /// **'No user profile found. Please contact support.'**
  String get errorNoUserRecord;

  /// No description provided for @errorRestaurantAccountOnly.
  ///
  /// In en, this message translates to:
  /// **'This portal is for restaurant and admin accounts only.'**
  String get errorRestaurantAccountOnly;

  /// No description provided for @errorNoRestaurantRecord.
  ///
  /// In en, this message translates to:
  /// **'No restaurant business profile found for this account.'**
  String get errorNoRestaurantRecord;

  /// No description provided for @hintEmail.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get hintEmail;

  /// No description provided for @hintPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get hintPassword;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @business_name.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get business_name;

  /// No description provided for @business_phone.
  ///
  /// In en, this message translates to:
  /// **'Business Phone'**
  String get business_phone;

  /// No description provided for @owner_full_name.
  ///
  /// In en, this message translates to:
  /// **'Owner Full Name'**
  String get owner_full_name;

  /// No description provided for @owner_phone.
  ///
  /// In en, this message translates to:
  /// **'Owner Phone'**
  String get owner_phone;

  /// No description provided for @creating_partner_account.
  ///
  /// In en, this message translates to:
  /// **'Creating partner account...'**
  String get creating_partner_account;

  /// No description provided for @account_is_pending_approval.
  ///
  /// In en, this message translates to:
  /// **'Registration successful! Your account is now pending approval.'**
  String get account_is_pending_approval;

  /// No description provided for @now_live_in.
  ///
  /// In en, this message translates to:
  /// **'Now live in Kraków & Warsaw'**
  String get now_live_in;

  /// No description provided for @put_your_restaurant_on.
  ///
  /// In en, this message translates to:
  /// **'Put your restaurant on the digital map.'**
  String get put_your_restaurant_on;

  /// No description provided for @manage_your_menu.
  ///
  /// In en, this message translates to:
  /// **'Manage your menu, track live sales, and grow your customer base with our all-in-one merchant dashboard.'**
  String get manage_your_menu;

  /// No description provided for @register_your_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Register Your Restaurant'**
  String get register_your_restaurant;

  /// No description provided for @see_how_it_works.
  ///
  /// In en, this message translates to:
  /// **'See How it Works'**
  String get see_how_it_works;

  /// No description provided for @live_platform_stats.
  ///
  /// In en, this message translates to:
  /// **'LIVE PLATFORM STATS'**
  String get live_platform_stats;

  /// No description provided for @restaurants_on_platform.
  ///
  /// In en, this message translates to:
  /// **'Restaurants on platform'**
  String get restaurants_on_platform;

  /// No description provided for @orders_placed.
  ///
  /// In en, this message translates to:
  /// **'Orders placed'**
  String get orders_placed;

  /// No description provided for @menus_published.
  ///
  /// In en, this message translates to:
  /// **'Menus published'**
  String get menus_published;

  /// No description provided for @items_available.
  ///
  /// In en, this message translates to:
  /// **'Items available'**
  String get items_available;

  /// No description provided for @trusted_by_restaurants.
  ///
  /// In en, this message translates to:
  /// **'TRUSTED BY 200+ LOCAL RESTAURANTS'**
  String get trusted_by_restaurants;

  /// No description provided for @digital_menu.
  ///
  /// In en, this message translates to:
  /// **'Digital Menu'**
  String get digital_menu;

  /// No description provided for @your_menu_goes_live_instantly.
  ///
  /// In en, this message translates to:
  /// **'Your menu goes live instantly on our customer platform.'**
  String get your_menu_goes_live_instantly;

  /// No description provided for @custom_banners.
  ///
  /// In en, this message translates to:
  /// **'Custom Banners'**
  String get custom_banners;

  /// No description provided for @full_creative_control.
  ///
  /// In en, this message translates to:
  /// **'Full creative control over your store\'s visual identity.'**
  String get full_creative_control;

  /// No description provided for @sales_analytics.
  ///
  /// In en, this message translates to:
  /// **'Sales Analytics'**
  String get sales_analytics;

  /// No description provided for @track_peak_hours.
  ///
  /// In en, this message translates to:
  /// **'Track peak hours and top-selling items in real-time.'**
  String get track_peak_hours;

  /// No description provided for @ready_to_grow.
  ///
  /// In en, this message translates to:
  /// **'Ready to grow your revenue?'**
  String get ready_to_grow;

  /// No description provided for @join_restaurants.
  ///
  /// In en, this message translates to:
  /// **'Join the restaurants already thriving on our platform.'**
  String get join_restaurants;

  /// No description provided for @hiw_title.
  ///
  /// In en, this message translates to:
  /// **'How It Works'**
  String get hiw_title;

  /// No description provided for @hiw_hero_badge.
  ///
  /// In en, this message translates to:
  /// **'Simple Onboarding'**
  String get hiw_hero_badge;

  /// No description provided for @hiw_hero_title.
  ///
  /// In en, this message translates to:
  /// **'Getting your kitchen online has never been easier.'**
  String get hiw_hero_title;

  /// No description provided for @hiw_hero_subtitle.
  ///
  /// In en, this message translates to:
  /// **'From registration to your first order, we\'ve streamlined every step.'**
  String get hiw_hero_subtitle;

  /// No description provided for @hiw_step1_title.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get hiw_step1_title;

  /// No description provided for @hiw_step1_desc.
  ///
  /// In en, this message translates to:
  /// **'Sign up with your business details (NIP/REGON) and owner information.'**
  String get hiw_step1_desc;

  /// No description provided for @hiw_step2_title.
  ///
  /// In en, this message translates to:
  /// **'Admin Verification'**
  String get hiw_step2_title;

  /// No description provided for @hiw_step2_desc.
  ///
  /// In en, this message translates to:
  /// **'Our team reviews your application to ensure platform safety and quality standards.'**
  String get hiw_step2_desc;

  /// No description provided for @hiw_step3_title.
  ///
  /// In en, this message translates to:
  /// **'Setup Your Store'**
  String get hiw_step3_title;

  /// No description provided for @hiw_step3_desc.
  ///
  /// In en, this message translates to:
  /// **'Upload your logo, set your operating hours, and define your delivery zones.'**
  String get hiw_step3_desc;

  /// No description provided for @hiw_step4_title.
  ///
  /// In en, this message translates to:
  /// **'Build Your Menu'**
  String get hiw_step4_title;

  /// No description provided for @hiw_step4_desc.
  ///
  /// In en, this message translates to:
  /// **'Add categories, items, and modifiers. Use our AI tools for high-quality descriptions.'**
  String get hiw_step4_desc;

  /// No description provided for @hiw_step5_title.
  ///
  /// In en, this message translates to:
  /// **'Go Live'**
  String get hiw_step5_title;

  /// No description provided for @hiw_step5_desc.
  ///
  /// In en, this message translates to:
  /// **'Switch your status to active and start receiving orders from local customers.'**
  String get hiw_step5_desc;

  /// No description provided for @hiw_feature1_title.
  ///
  /// In en, this message translates to:
  /// **'Real-time Sync'**
  String get hiw_feature1_title;

  /// No description provided for @hiw_feature1_desc.
  ///
  /// In en, this message translates to:
  /// **'Menu updates reflect instantly on the customer app with zero delay.'**
  String get hiw_feature1_desc;

  /// No description provided for @hiw_feature2_title.
  ///
  /// In en, this message translates to:
  /// **'Detailed Analytics'**
  String get hiw_feature2_title;

  /// No description provided for @hiw_feature2_desc.
  ///
  /// In en, this message translates to:
  /// **'Track your best sellers and peak hours to optimize your staff and inventory.'**
  String get hiw_feature2_desc;

  /// No description provided for @hiw_feature3_title.
  ///
  /// In en, this message translates to:
  /// **'Image Management'**
  String get hiw_feature3_title;

  /// No description provided for @hiw_feature3_desc.
  ///
  /// In en, this message translates to:
  /// **'Integrated cloud storage for all your high-resolution food photography.'**
  String get hiw_feature3_desc;

  /// No description provided for @hiw_feature4_title.
  ///
  /// In en, this message translates to:
  /// **'Role-based Access'**
  String get hiw_feature4_title;

  /// No description provided for @hiw_feature4_desc.
  ///
  /// In en, this message translates to:
  /// **'Securely manage permissions for owners, managers, and kitchen staff.'**
  String get hiw_feature4_desc;

  /// No description provided for @hiw_feature5_title.
  ///
  /// In en, this message translates to:
  /// **'Multi-device'**
  String get hiw_feature5_title;

  /// No description provided for @hiw_feature5_desc.
  ///
  /// In en, this message translates to:
  /// **'Manage your restaurant from a desktop, tablet, or mobile phone seamlessly.'**
  String get hiw_feature5_desc;

  /// No description provided for @hiw_feature6_title.
  ///
  /// In en, this message translates to:
  /// **'24/7 Support'**
  String get hiw_feature6_title;

  /// No description provided for @hiw_feature6_desc.
  ///
  /// In en, this message translates to:
  /// **'Our merchant success team is always available to help you grow.'**
  String get hiw_feature6_desc;

  /// No description provided for @hiw_cta_title.
  ///
  /// In en, this message translates to:
  /// **'Ready to grow your revenue?'**
  String get hiw_cta_title;

  /// No description provided for @hiw_cta_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Join our community of successful restaurants today.'**
  String get hiw_cta_subtitle;

  /// No description provided for @hiw_cta_primary.
  ///
  /// In en, this message translates to:
  /// **'Start for Free'**
  String get hiw_cta_primary;

  /// No description provided for @hiw_cta_secondary.
  ///
  /// In en, this message translates to:
  /// **'View Pricing'**
  String get hiw_cta_secondary;

  /// No description provided for @pricing_title.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing_title;

  /// No description provided for @pricing_hero_badge.
  ///
  /// In en, this message translates to:
  /// **'Transparent Fees'**
  String get pricing_hero_badge;

  /// No description provided for @pricing_hero_title.
  ///
  /// In en, this message translates to:
  /// **'Grow your business without the fixed costs.'**
  String get pricing_hero_title;

  /// No description provided for @pricing_hero_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We only succeed when you do. No setup fees, no monthly subscriptions.'**
  String get pricing_hero_subtitle;

  /// No description provided for @pricing_step1_title.
  ///
  /// In en, this message translates to:
  /// **'Customer Orders'**
  String get pricing_step1_title;

  /// No description provided for @pricing_step1_desc.
  ///
  /// In en, this message translates to:
  /// **'Orders are placed through our secure customer platform.'**
  String get pricing_step1_desc;

  /// No description provided for @pricing_step2_title.
  ///
  /// In en, this message translates to:
  /// **'You Prepare'**
  String get pricing_step2_title;

  /// No description provided for @pricing_step2_desc.
  ///
  /// In en, this message translates to:
  /// **'Manage the kitchen and keep 100% of the tips.'**
  String get pricing_step2_desc;

  /// No description provided for @pricing_step3_title.
  ///
  /// In en, this message translates to:
  /// **'Weekly Payouts'**
  String get pricing_step3_title;

  /// No description provided for @pricing_step3_desc.
  ///
  /// In en, this message translates to:
  /// **'Funds are deposited minus our small commission fee.'**
  String get pricing_step3_desc;

  /// No description provided for @pricing_calculator_title.
  ///
  /// In en, this message translates to:
  /// **'Estimate your earnings.'**
  String get pricing_calculator_title;

  /// No description provided for @pricing_slider_orders_label.
  ///
  /// In en, this message translates to:
  /// **'Orders per day'**
  String get pricing_slider_orders_label;

  /// No description provided for @pricing_slider_orders_value.
  ///
  /// In en, this message translates to:
  /// **'{count} orders ({monthly} / month)'**
  String pricing_slider_orders_value(int count, int monthly);

  /// No description provided for @pricing_slider_avg_label.
  ///
  /// In en, this message translates to:
  /// **'Average order value'**
  String get pricing_slider_avg_label;

  /// No description provided for @pricing_tier_badge.
  ///
  /// In en, this message translates to:
  /// **'{name} Tier ({pct})'**
  String pricing_tier_badge(String name, String pct);

  /// No description provided for @pricing_tier_monthly.
  ///
  /// In en, this message translates to:
  /// **'{count} monthly orders'**
  String pricing_tier_monthly(int count);

  /// No description provided for @pricing_calc_revenue_label.
  ///
  /// In en, this message translates to:
  /// **'Daily Revenue'**
  String get pricing_calc_revenue_label;

  /// No description provided for @pricing_calc_revenue_sub.
  ///
  /// In en, this message translates to:
  /// **'Gross sales'**
  String get pricing_calc_revenue_sub;

  /// No description provided for @pricing_calc_fee_label.
  ///
  /// In en, this message translates to:
  /// **'Platform Fee ({pct})'**
  String pricing_calc_fee_label(String pct);

  /// No description provided for @pricing_tier_starter_range.
  ///
  /// In en, this message translates to:
  /// **'0-300 orders/month'**
  String get pricing_tier_starter_range;

  /// No description provided for @pricing_tier_growing_range.
  ///
  /// In en, this message translates to:
  /// **'301-1500 orders/month'**
  String get pricing_tier_growing_range;

  /// No description provided for @pricing_tier_established_range.
  ///
  /// In en, this message translates to:
  /// **'1501-4500 orders/month'**
  String get pricing_tier_established_range;

  /// No description provided for @pricing_tier_partner_range.
  ///
  /// In en, this message translates to:
  /// **'4500+ orders/month'**
  String get pricing_tier_partner_range;

  /// No description provided for @pricing_calc_fee_sub.
  ///
  /// In en, this message translates to:
  /// **'Our commission'**
  String get pricing_calc_fee_sub;

  /// No description provided for @pricing_calc_keep_label.
  ///
  /// In en, this message translates to:
  /// **'You Keep'**
  String get pricing_calc_keep_label;

  /// No description provided for @pricing_calc_disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Estimates based on current tier rates. Excludes payment processing fees.'**
  String get pricing_calc_disclaimer;

  /// No description provided for @pricing_tiers_title.
  ///
  /// In en, this message translates to:
  /// **'The more you sell, the less you pay.'**
  String get pricing_tiers_title;

  /// No description provided for @pricing_tiers_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Commission rates are automatically adjusted based on your previous 30-day order volume.'**
  String get pricing_tiers_subtitle;

  /// No description provided for @pricing_tier_starter_label.
  ///
  /// In en, this message translates to:
  /// **'Starter'**
  String get pricing_tier_starter_label;

  /// No description provided for @pricing_tier_starter_desc.
  ///
  /// In en, this message translates to:
  /// **'Perfect for new restaurants and pop-up kitchens.'**
  String get pricing_tier_starter_desc;

  /// No description provided for @pricing_tier_growing_label.
  ///
  /// In en, this message translates to:
  /// **'Growing'**
  String get pricing_tier_growing_label;

  /// No description provided for @pricing_tier_growing_desc.
  ///
  /// In en, this message translates to:
  /// **'For local favorites starting to scale their delivery.'**
  String get pricing_tier_growing_desc;

  /// No description provided for @pricing_tier_established_label.
  ///
  /// In en, this message translates to:
  /// **'Established'**
  String get pricing_tier_established_label;

  /// No description provided for @pricing_tier_established_desc.
  ///
  /// In en, this message translates to:
  /// **'High-volume establishments with a loyal following.'**
  String get pricing_tier_established_desc;

  /// No description provided for @pricing_tier_partner_label.
  ///
  /// In en, this message translates to:
  /// **'Partner'**
  String get pricing_tier_partner_label;

  /// No description provided for @pricing_tier_partner_desc.
  ///
  /// In en, this message translates to:
  /// **'Deep integration for city-wide restaurant groups.'**
  String get pricing_tier_partner_desc;

  /// No description provided for @pricing_faq1_q.
  ///
  /// In en, this message translates to:
  /// **'Are there any hidden monthly fees?'**
  String get pricing_faq1_q;

  /// No description provided for @pricing_faq1_a.
  ///
  /// In en, this message translates to:
  /// **'No. There are no monthly maintenance or subscription fees. You only pay commission on completed orders.'**
  String get pricing_faq1_a;

  /// No description provided for @pricing_faq2_q.
  ///
  /// In en, this message translates to:
  /// **'How often do I get paid?'**
  String get pricing_faq2_q;

  /// No description provided for @pricing_faq2_a.
  ///
  /// In en, this message translates to:
  /// **'Payouts are processed weekly every Tuesday for all orders completed in the previous week.'**
  String get pricing_faq2_a;

  /// No description provided for @pricing_faq3_q.
  ///
  /// In en, this message translates to:
  /// **'Do I pay commission on canceled orders?'**
  String get pricing_faq3_q;

  /// No description provided for @pricing_faq3_a.
  ///
  /// In en, this message translates to:
  /// **'No. If an order is canceled and the customer is refunded, no commission is charged.'**
  String get pricing_faq3_a;

  /// No description provided for @pricing_faq4_q.
  ///
  /// In en, this message translates to:
  /// **'Who handles the delivery?'**
  String get pricing_faq4_q;

  /// No description provided for @pricing_faq4_a.
  ///
  /// In en, this message translates to:
  /// **'This plan assumes you provide your own delivery staff. We provide the digital infrastructure to manage them.'**
  String get pricing_faq4_a;

  /// No description provided for @pricing_faq5_q.
  ///
  /// In en, this message translates to:
  /// **'Can I cancel at any time?'**
  String get pricing_faq5_q;

  /// No description provided for @pricing_faq5_a.
  ///
  /// In en, this message translates to:
  /// **'Yes. There are no long-term contracts. You can set your store to Inactive at any time.'**
  String get pricing_faq5_a;

  /// No description provided for @pricing_cta_title.
  ///
  /// In en, this message translates to:
  /// **'No risk, all reward.'**
  String get pricing_cta_title;

  /// No description provided for @pricing_cta_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Start receiving orders today and only pay for results.'**
  String get pricing_cta_subtitle;

  /// No description provided for @pricing_cta_primary.
  ///
  /// In en, this message translates to:
  /// **'Join as a Partner'**
  String get pricing_cta_primary;

  /// No description provided for @admin_overview_review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get admin_overview_review;

  /// No description provided for @admin_overview_status_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get admin_overview_status_pending;

  /// No description provided for @admin_overview_status_processing.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get admin_overview_status_processing;

  /// No description provided for @admin_overview_status_delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get admin_overview_status_delivered;

  /// No description provided for @admin_overview_status_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get admin_overview_status_cancelled;

  /// No description provided for @requests_action_activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get requests_action_activate;

  /// No description provided for @requests_action_decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get requests_action_decline;

  /// No description provided for @requests_action_approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get requests_action_approve;

  /// No description provided for @requests_action_reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get requests_action_reject;

  /// No description provided for @requests_action_suspend.
  ///
  /// In en, this message translates to:
  /// **'Suspend'**
  String get requests_action_suspend;

  /// No description provided for @requests_action_reinstate.
  ///
  /// In en, this message translates to:
  /// **'Reinstate'**
  String get requests_action_reinstate;

  /// No description provided for @requests_status_approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get requests_status_approved;

  /// No description provided for @requests_status_active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get requests_status_active;

  /// No description provided for @requests_status_rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get requests_status_rejected;

  /// No description provided for @requests_status_suspended.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get requests_status_suspended;

  /// No description provided for @requests_status_pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get requests_status_pending;

  /// No description provided for @users_banned_badge.
  ///
  /// In en, this message translates to:
  /// **'BANNED'**
  String get users_banned_badge;

  /// No description provided for @users_action_ban.
  ///
  /// In en, this message translates to:
  /// **'Ban User'**
  String get users_action_ban;

  /// No description provided for @users_action_unban.
  ///
  /// In en, this message translates to:
  /// **'Unban User'**
  String get users_action_unban;

  /// No description provided for @users_action_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete User'**
  String get users_action_delete;

  /// No description provided for @users_confirm_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get users_confirm_cancel;

  /// No description provided for @users_role_admin.
  ///
  /// In en, this message translates to:
  /// **'Platform Admin'**
  String get users_role_admin;

  /// No description provided for @users_role_restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Owner'**
  String get users_role_restaurant;

  /// No description provided for @users_role_customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get users_role_customer;

  /// No description provided for @users_copied.
  ///
  /// In en, this message translates to:
  /// **'Value copied to clipboard'**
  String get users_copied;

  /// No description provided for @shell_confirm_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get shell_confirm_cancel;

  /// No description provided for @analytics_status_normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get analytics_status_normal;

  /// No description provided for @analytics_status_processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get analytics_status_processing;

  /// No description provided for @analytics_status_delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get analytics_status_delivered;

  /// No description provided for @analytics_status_cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get analytics_status_cancelled;

  /// No description provided for @menus_fab.
  ///
  /// In en, this message translates to:
  /// **'Create Menu'**
  String get menus_fab;

  /// No description provided for @menus_sheet_title.
  ///
  /// In en, this message translates to:
  /// **'New Menu Category'**
  String get menus_sheet_title;

  /// No description provided for @menus_image_upload_label.
  ///
  /// In en, this message translates to:
  /// **'Category Banner'**
  String get menus_image_upload_label;

  /// No description provided for @menus_field_title_label.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get menus_field_title_label;

  /// No description provided for @menus_field_title_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get menus_field_title_required;

  /// No description provided for @menus_field_desc_label.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get menus_field_desc_label;

  /// No description provided for @menus_field_desc_required.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get menus_field_desc_required;

  /// No description provided for @menus_no_image.
  ///
  /// In en, this message translates to:
  /// **'Please select a banner image'**
  String get menus_no_image;

  /// No description provided for @menus_submit.
  ///
  /// In en, this message translates to:
  /// **'Add Category'**
  String get menus_submit;

  /// No description provided for @menus_design_view_items.
  ///
  /// In en, this message translates to:
  /// **'View items'**
  String get menus_design_view_items;

  /// No description provided for @menus_design_edit_button.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get menus_design_edit_button;

  /// No description provided for @menus_design_edit_sheet_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Menu'**
  String get menus_design_edit_sheet_title;

  /// No description provided for @menus_design_delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get menus_design_delete_button;

  /// No description provided for @menus_design_change_image_hint.
  ///
  /// In en, this message translates to:
  /// **'Tap to change banner image'**
  String get menus_design_change_image_hint;

  /// No description provided for @menus_design_field_title_label.
  ///
  /// In en, this message translates to:
  /// **'Menu Title'**
  String get menus_design_field_title_label;

  /// No description provided for @menus_design_field_title_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get menus_design_field_title_required;

  /// No description provided for @menus_design_field_desc_label.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get menus_design_field_desc_label;

  /// No description provided for @menus_design_field_desc_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter a description'**
  String get menus_design_field_desc_required;

  /// No description provided for @menus_design_save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get menus_design_save_changes;

  /// No description provided for @menus_design_saved.
  ///
  /// In en, this message translates to:
  /// **'Menu updated successfully'**
  String get menus_design_saved;

  /// No description provided for @menus_design_banner_cleanup_error.
  ///
  /// In en, this message translates to:
  /// **'Note: Menu updated, but the old image could not be removed.'**
  String get menus_design_banner_cleanup_error;

  /// No description provided for @menus_design_delete_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Menu?'**
  String get menus_design_delete_dialog_title;

  /// No description provided for @menus_design_delete_dialog_body.
  ///
  /// In en, this message translates to:
  /// **'Are you sure? This will permanently remove this menu and all its associated data.'**
  String get menus_design_delete_dialog_body;

  /// No description provided for @menus_design_delete_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get menus_design_delete_cancel;

  /// No description provided for @menus_design_delete_confirm.
  ///
  /// In en, this message translates to:
  /// **'Delete Permanently'**
  String get menus_design_delete_confirm;

  /// No description provided for @menus_design_delete_missing_id.
  ///
  /// In en, this message translates to:
  /// **'Error: Missing IDs. Cannot delete.'**
  String get menus_design_delete_missing_id;

  /// No description provided for @menus_design_deleted.
  ///
  /// In en, this message translates to:
  /// **'Menu deleted'**
  String get menus_design_deleted;

  /// No description provided for @items_app_bar_fallback.
  ///
  /// In en, this message translates to:
  /// **'Menu Items'**
  String get items_app_bar_fallback;

  /// No description provided for @items_fab.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get items_fab;

  /// No description provided for @items_sheet_title.
  ///
  /// In en, this message translates to:
  /// **'Add New Item'**
  String get items_sheet_title;

  /// No description provided for @items_image_upload_label.
  ///
  /// In en, this message translates to:
  /// **'Item Photo'**
  String get items_image_upload_label;

  /// No description provided for @items_image_browse.
  ///
  /// In en, this message translates to:
  /// **'Tap to browse images'**
  String get items_image_browse;

  /// No description provided for @items_field_title_label.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get items_field_title_label;

  /// No description provided for @items_field_info_label.
  ///
  /// In en, this message translates to:
  /// **'Short Info'**
  String get items_field_info_label;

  /// No description provided for @items_field_desc_label.
  ///
  /// In en, this message translates to:
  /// **'Full Description'**
  String get items_field_desc_label;

  /// No description provided for @items_field_price_label.
  ///
  /// In en, this message translates to:
  /// **'Base Price'**
  String get items_field_price_label;

  /// No description provided for @items_field_price_required.
  ///
  /// In en, this message translates to:
  /// **'Price is required'**
  String get items_field_price_required;

  /// No description provided for @items_field_price_invalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid price'**
  String get items_field_price_invalid;

  /// No description provided for @items_field_tags_label.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get items_field_tags_label;

  /// No description provided for @items_discount_label.
  ///
  /// In en, this message translates to:
  /// **'Discount Percentage'**
  String get items_discount_label;

  /// No description provided for @items_discount_required.
  ///
  /// In en, this message translates to:
  /// **'Enter discount amount'**
  String get items_discount_required;

  /// No description provided for @items_discount_invalid.
  ///
  /// In en, this message translates to:
  /// **'Enter 1-100'**
  String get items_discount_invalid;

  /// No description provided for @items_no_image.
  ///
  /// In en, this message translates to:
  /// **'Please upload an image first'**
  String get items_no_image;

  /// No description provided for @items_submit.
  ///
  /// In en, this message translates to:
  /// **'Create Item'**
  String get items_submit;

  /// No description provided for @items_design_edit_button.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get items_design_edit_button;

  /// No description provided for @items_design_image_cleanup_error.
  ///
  /// In en, this message translates to:
  /// **'Item updated, but the previous image could not be deleted from storage.'**
  String get items_design_image_cleanup_error;

  /// No description provided for @items_design_saved.
  ///
  /// In en, this message translates to:
  /// **'Item updated successfully'**
  String get items_design_saved;

  /// No description provided for @items_design_deleted.
  ///
  /// In en, this message translates to:
  /// **'Item has been removed'**
  String get items_design_deleted;

  /// No description provided for @items_design_delete_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Item?'**
  String get items_design_delete_dialog_title;

  /// No description provided for @items_design_delete_dialog_body.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this item? This action cannot be undone.'**
  String get items_design_delete_dialog_body;

  /// No description provided for @items_design_delete_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get items_design_delete_cancel;

  /// No description provided for @items_design_delete_confirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get items_design_delete_confirm;

  /// No description provided for @items_design_edit_sheet_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get items_design_edit_sheet_title;

  /// No description provided for @items_design_delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get items_design_delete_button;

  /// No description provided for @items_design_change_image_hint.
  ///
  /// In en, this message translates to:
  /// **'Tap the image to change it'**
  String get items_design_change_image_hint;

  /// No description provided for @items_design_field_title_label.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get items_design_field_title_label;

  /// No description provided for @items_field_title_required.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get items_field_title_required;

  /// No description provided for @items_design_field_info_label.
  ///
  /// In en, this message translates to:
  /// **'Short Info'**
  String get items_design_field_info_label;

  /// No description provided for @items_design_field_info_hint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 500g, spicy, vegan'**
  String get items_design_field_info_hint;

  /// No description provided for @items_field_info_required.
  ///
  /// In en, this message translates to:
  /// **'Short info is required'**
  String get items_field_info_required;

  /// No description provided for @items_design_field_desc_label.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get items_design_field_desc_label;

  /// No description provided for @items_field_desc_required.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get items_field_desc_required;

  /// No description provided for @items_design_field_price_label.
  ///
  /// In en, this message translates to:
  /// **'Base Price'**
  String get items_design_field_price_label;

  /// No description provided for @items_design_field_price_required.
  ///
  /// In en, this message translates to:
  /// **'Price is required'**
  String get items_design_field_price_required;

  /// No description provided for @items_design_field_price_invalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid price'**
  String get items_design_field_price_invalid;

  /// No description provided for @items_design_field_tags_label.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get items_design_field_tags_label;

  /// No description provided for @items_design_field_tags_hint.
  ///
  /// In en, this message translates to:
  /// **'Add tags (e.g. Popular)'**
  String get items_design_field_tags_hint;

  /// No description provided for @items_discount_toggle.
  ///
  /// In en, this message translates to:
  /// **'Offer a discount'**
  String get items_discount_toggle;

  /// No description provided for @items_design_discount_label.
  ///
  /// In en, this message translates to:
  /// **'Discount Percentage'**
  String get items_design_discount_label;

  /// No description provided for @items_design_discount_required.
  ///
  /// In en, this message translates to:
  /// **'Discount value is required'**
  String get items_design_discount_required;

  /// No description provided for @items_design_discount_invalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a value between 1 and 100'**
  String get items_design_discount_invalid;

  /// No description provided for @overview_section_glance.
  ///
  /// In en, this message translates to:
  /// **'AT A GLANCE'**
  String get overview_section_glance;

  /// No description provided for @overview_section_orders.
  ///
  /// In en, this message translates to:
  /// **'RECENT ORDERS'**
  String get overview_section_orders;

  /// No description provided for @overview_task_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get overview_task_done;

  /// No description provided for @overview_task_setup.
  ///
  /// In en, this message translates to:
  /// **'Setup'**
  String get overview_task_setup;

  /// No description provided for @promo_fab.
  ///
  /// In en, this message translates to:
  /// **'Create Promotion'**
  String get promo_fab;

  /// No description provided for @promo_badge_live.
  ///
  /// In en, this message translates to:
  /// **'LIVE'**
  String get promo_badge_live;

  /// No description provided for @promo_badge_inactive.
  ///
  /// In en, this message translates to:
  /// **'INACTIVE'**
  String get promo_badge_inactive;

  /// No description provided for @promo_edit_button.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get promo_edit_button;

  /// No description provided for @promo_sheet_add_title.
  ///
  /// In en, this message translates to:
  /// **'New Promotion'**
  String get promo_sheet_add_title;

  /// No description provided for @promo_sheet_edit_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Promotion'**
  String get promo_sheet_edit_title;

  /// No description provided for @promo_field_title_label.
  ///
  /// In en, this message translates to:
  /// **'Campaign Title'**
  String get promo_field_title_label;

  /// No description provided for @promo_field_title_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get promo_field_title_required;

  /// No description provided for @promo_field_desc_label.
  ///
  /// In en, this message translates to:
  /// **'Short Description'**
  String get promo_field_desc_label;

  /// No description provided for @promo_field_desc_required.
  ///
  /// In en, this message translates to:
  /// **'Description is required'**
  String get promo_field_desc_required;

  /// No description provided for @promo_date_start.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get promo_date_start;

  /// No description provided for @promo_date_end.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get promo_date_end;

  /// No description provided for @promo_date_pick.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get promo_date_pick;

  /// No description provided for @promo_active_toggle.
  ///
  /// In en, this message translates to:
  /// **'Show promotion to customers'**
  String get promo_active_toggle;

  /// No description provided for @promo_image_upload_hint.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload a campaign banner'**
  String get promo_image_upload_hint;

  /// No description provided for @promo_image_change_hint.
  ///
  /// In en, this message translates to:
  /// **'Tap to change banner'**
  String get promo_image_change_hint;

  /// No description provided for @promo_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Promotion?'**
  String get promo_delete_title;

  /// No description provided for @promo_delete_body.
  ///
  /// In en, this message translates to:
  /// **'This will permanently remove the campaign and its banner. This action cannot be undone.'**
  String get promo_delete_body;

  /// No description provided for @promo_delete_cancel.
  ///
  /// In en, this message translates to:
  /// **'Keep it'**
  String get promo_delete_cancel;

  /// No description provided for @promo_delete_confirm.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get promo_delete_confirm;

  /// No description provided for @promo_no_image.
  ///
  /// In en, this message translates to:
  /// **'A banner image is required for new promotions'**
  String get promo_no_image;

  /// No description provided for @promo_link_section_label.
  ///
  /// In en, this message translates to:
  /// **'Link Items'**
  String get promo_link_section_label;

  /// No description provided for @promo_link_section_hint.
  ///
  /// In en, this message translates to:
  /// **'Select which items belong to this promotion.'**
  String get promo_link_section_hint;

  /// No description provided for @promo_image_upload_label.
  ///
  /// In en, this message translates to:
  /// **'Promotion Image'**
  String get promo_image_upload_label;

  /// No description provided for @promo_save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get promo_save_changes;

  /// No description provided for @promo_create.
  ///
  /// In en, this message translates to:
  /// **'Launch Promotion'**
  String get promo_create;

  /// No description provided for @settings_section_business.
  ///
  /// In en, this message translates to:
  /// **'Business Details'**
  String get settings_section_business;

  /// No description provided for @settings_section_business_sub.
  ///
  /// In en, this message translates to:
  /// **'Manage your restaurant\'s public identity.'**
  String get settings_section_business_sub;

  /// No description provided for @settings_section_profile.
  ///
  /// In en, this message translates to:
  /// **'Account Profile'**
  String get settings_section_profile;

  /// No description provided for @settings_section_profile_sub.
  ///
  /// In en, this message translates to:
  /// **'Your personal contact information.'**
  String get settings_section_profile_sub;

  /// No description provided for @settings_section_danger.
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get settings_section_danger;

  /// No description provided for @settings_section_danger_sub.
  ///
  /// In en, this message translates to:
  /// **'Irreversible account actions.'**
  String get settings_section_danger_sub;

  /// No description provided for @settings_logo_title.
  ///
  /// In en, this message translates to:
  /// **'Restaurant Logo'**
  String get settings_logo_title;

  /// No description provided for @settings_logo_status_staged.
  ///
  /// In en, this message translates to:
  /// **'New logo selected'**
  String get settings_logo_status_staged;

  /// No description provided for @settings_logo_status_exists.
  ///
  /// In en, this message translates to:
  /// **'Logo uploaded'**
  String get settings_logo_status_exists;

  /// No description provided for @settings_logo_status_none.
  ///
  /// In en, this message translates to:
  /// **'No logo set'**
  String get settings_logo_status_none;

  /// No description provided for @settings_logo_choose.
  ///
  /// In en, this message translates to:
  /// **'Choose Image'**
  String get settings_logo_choose;

  /// No description provided for @settings_logo_upload.
  ///
  /// In en, this message translates to:
  /// **'Save Logo'**
  String get settings_logo_upload;

  /// No description provided for @settings_logo_success.
  ///
  /// In en, this message translates to:
  /// **'Logo updated successfully!'**
  String get settings_logo_success;

  /// No description provided for @settings_banner_title.
  ///
  /// In en, this message translates to:
  /// **'Cover Banner'**
  String get settings_banner_title;

  /// No description provided for @settings_banner_choose.
  ///
  /// In en, this message translates to:
  /// **'Tap to choose a cover photo'**
  String get settings_banner_choose;

  /// No description provided for @settings_banner_upload.
  ///
  /// In en, this message translates to:
  /// **'Save Banner'**
  String get settings_banner_upload;

  /// No description provided for @settings_banner_success.
  ///
  /// In en, this message translates to:
  /// **'Banner updated successfully!'**
  String get settings_banner_success;

  /// No description provided for @settings_business_title.
  ///
  /// In en, this message translates to:
  /// **'Store Information'**
  String get settings_business_title;

  /// No description provided for @settings_address_pick.
  ///
  /// In en, this message translates to:
  /// **'Pin on Map'**
  String get settings_address_pick;

  /// No description provided for @settings_address_change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get settings_address_change;

  /// No description provided for @settings_business_saved.
  ///
  /// In en, this message translates to:
  /// **'Business information updated!'**
  String get settings_business_saved;

  /// No description provided for @settings_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Account Owner'**
  String get settings_profile_title;

  /// No description provided for @settings_profile_photo_ready.
  ///
  /// In en, this message translates to:
  /// **'New photo ready to save'**
  String get settings_profile_photo_ready;

  /// No description provided for @settings_profile_phone_label.
  ///
  /// In en, this message translates to:
  /// **'Contact Phone'**
  String get settings_profile_phone_label;

  /// No description provided for @settings_save_changes.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get settings_save_changes;

  /// No description provided for @settings_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get settings_cancel;

  /// No description provided for @settings_danger_reset_title.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get settings_danger_reset_title;

  /// No description provided for @settings_danger_reset_sub.
  ///
  /// In en, this message translates to:
  /// **'Send a password reset link to your email.'**
  String get settings_danger_reset_sub;

  /// No description provided for @settings_danger_reset_button.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get settings_danger_reset_button;

  /// No description provided for @settings_danger_reset_sent.
  ///
  /// In en, this message translates to:
  /// **'Reset email sent! Please check your inbox.'**
  String get settings_danger_reset_sent;

  /// No description provided for @settings_danger_delete_title.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settings_danger_delete_title;

  /// No description provided for @settings_danger_delete_sub.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove your restaurant and all data.'**
  String get settings_danger_delete_sub;

  /// No description provided for @settings_danger_delete_button.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get settings_danger_delete_button;

  /// No description provided for @settings_danger_delete_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Are you absolutely sure?'**
  String get settings_danger_delete_dialog_title;

  /// No description provided for @settings_danger_delete_dialog_body.
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible. All your menus, promotions, and history will be wiped.'**
  String get settings_danger_delete_dialog_body;

  /// No description provided for @settings_map_dialog_title.
  ///
  /// In en, this message translates to:
  /// **'Select Location'**
  String get settings_map_dialog_title;

  /// No description provided for @settings_map_no_location.
  ///
  /// In en, this message translates to:
  /// **'No location selected yet.'**
  String get settings_map_no_location;

  /// No description provided for @settings_map_open.
  ///
  /// In en, this message translates to:
  /// **'Open Map'**
  String get settings_map_open;

  /// No description provided for @settings_map_change.
  ///
  /// In en, this message translates to:
  /// **'Change Location'**
  String get settings_map_change;

  /// No description provided for @settings_map_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm Location'**
  String get settings_map_confirm;

  /// No description provided for @settings_profile_saved.
  ///
  /// In en, this message translates to:
  /// **'The changes has been saved'**
  String get settings_profile_saved;

  /// No description provided for @how_it_works.
  ///
  /// In en, this message translates to:
  /// **'How It Works'**
  String get how_it_works;

  /// No description provided for @pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @tapToUploadImage.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload Image'**
  String get tapToUploadImage;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get sign_up;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get log_in;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get sign_in;

  /// No description provided for @errorEnterEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password.'**
  String get errorEnterEmailOrPassword;

  /// No description provided for @errorLoginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your connection or credentials.'**
  String get errorLoginFailed;

  /// No description provided for @error_no_user_record_found.
  ///
  /// In en, this message translates to:
  /// **'No user profile found. Please contact support.'**
  String get error_no_user_record_found;

  /// No description provided for @permission_restaurant_accounts_only.
  ///
  /// In en, this message translates to:
  /// **'This portal is for restaurant and admin accounts only.'**
  String get permission_restaurant_accounts_only;

  /// No description provided for @error_no_restaurant_record_found.
  ///
  /// In en, this message translates to:
  /// **'No restaurant business profile found for this account.'**
  String get error_no_restaurant_record_found;

  /// No description provided for @admin_profile.
  ///
  /// In en, this message translates to:
  /// **'Admin Profile'**
  String get admin_profile;

  /// No description provided for @info_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get info_continue;

  /// No description provided for @hintConfPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get hintConfPassword;

  /// No description provided for @errorNoMatchPasswords.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get errorNoMatchPasswords;

  /// No description provided for @orders_today.
  ///
  /// In en, this message translates to:
  /// **'Orders Today'**
  String get orders_today;

  /// No description provided for @total_orders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get total_orders;

  /// No description provided for @menu_items.
  ///
  /// In en, this message translates to:
  /// **'Menu Items'**
  String get menu_items;

  /// No description provided for @upper_features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get upper_features;

  /// No description provided for @register_now.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get register_now;

  /// No description provided for @hiw_section_process.
  ///
  /// In en, this message translates to:
  /// **'The Process'**
  String get hiw_section_process;

  /// No description provided for @hiw_section_features.
  ///
  /// In en, this message translates to:
  /// **'Everything You Need'**
  String get hiw_section_features;

  /// No description provided for @hiw_features_title.
  ///
  /// In en, this message translates to:
  /// **'Powerful tools for modern kitchens.'**
  String get hiw_features_title;
}

class _MerchantLocalizationsDelegate
    extends LocalizationsDelegate<MerchantLocalizations> {
  const _MerchantLocalizationsDelegate();

  @override
  Future<MerchantLocalizations> load(Locale locale) {
    return SynchronousFuture<MerchantLocalizations>(
        lookupMerchantLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'ko', 'pl', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_MerchantLocalizationsDelegate old) => false;
}

MerchantLocalizations lookupMerchantLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return MerchantLocalizationsDe();
    case 'en':
      return MerchantLocalizationsEn();
    case 'ko':
      return MerchantLocalizationsKo();
    case 'pl':
      return MerchantLocalizationsPl();
    case 'uk':
      return MerchantLocalizationsUk();
  }

  throw FlutterError(
      'MerchantLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
