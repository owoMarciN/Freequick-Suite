// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'merchant_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class MerchantLocalizationsEn extends MerchantLocalizations {
  MerchantLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get admin_panel => 'Admin Panel';

  @override
  String get join_requests => 'Join Requests';

  @override
  String get edit_sheet_title => 'Edit Sheet';

  @override
  String get admin_notifications_tab_send => 'Send';

  @override
  String get admin_notifications_tab_history => 'History';

  @override
  String get admin_notifications_target_audience => 'Target Audience';

  @override
  String get admin_notifications_audience_all => 'All Users';

  @override
  String get admin_notifications_audience_restaurants => 'Restaurants';

  @override
  String get admin_notifications_audience_specific => 'Specific Users';

  @override
  String get admin_notifications_search_hint =>
      'Search users by name or email...';

  @override
  String get admin_notifications_search_hint_more => 'Add another user...';

  @override
  String get admin_notifications_title_label => 'Notification Title';

  @override
  String get admin_notifications_title_hint => 'Enter title';

  @override
  String get admin_notifications_body_label => 'Message Body';

  @override
  String get admin_notifications_body_hint => 'Enter message';

  @override
  String get admin_notifications_required => 'This field is required';

  @override
  String get admin_notifications_sending => 'Sending...';

  @override
  String get admin_notifications_send_button => 'Send Notification';

  @override
  String get admin_notifications_select_user =>
      'Please select at least one user';

  @override
  String get admin_notifications_sent_one => 'Notification sent successfully';

  @override
  String admin_notifications_sent_many(int count) {
    return 'Notifications sent to $count users';
  }

  @override
  String get admin_notifications_history_empty => 'No notification history yet';

  @override
  String get admin_notifications_history_sent_badge => 'SENT';

  @override
  String admin_notifications_history_sent_count(int count) {
    return '$count sent';
  }

  @override
  String get admin_overview_platform_glance => 'Platform at a Glance';

  @override
  String get admin_overview_revenue_30d => 'Revenue (Last 30 Days)';

  @override
  String get admin_overview_pending_requests => 'Pending Join Requests';

  @override
  String get admin_overview_view_all => 'View All';

  @override
  String get admin_overview_order_status => 'Order Status';

  @override
  String get admin_overview_top_restaurants => 'Top Restaurants';

  @override
  String get admin_overview_stat_restaurants => 'Total Restaurants';

  @override
  String admin_overview_stat_restaurants_sub(int active) {
    return '$active active';
  }

  @override
  String get admin_overview_stat_orders => 'Total Orders';

  @override
  String admin_overview_stat_orders_sub(int today) {
    return '$today today';
  }

  @override
  String get admin_overview_stat_revenue => 'Total Revenue';

  @override
  String admin_overview_stat_revenue_sub(String last7d) {
    return '$last7d PLN last 7d';
  }

  @override
  String get admin_overview_stat_avg => 'Avg Order Value';

  @override
  String admin_overview_stat_avg_sub(int menus, int items) {
    return '$menus menus • $items items';
  }

  @override
  String get admin_overview_revenue_no_data => 'No revenue data available.';

  @override
  String get admin_overview_no_pending => 'No pending join requests.';

  @override
  String admin_overview_pending_nip(String nip, String date) {
    return 'NIP: $nip • $date';
  }

  @override
  String get admin_overview_no_orders => 'No orders yet.';

  @override
  String get admin_overview_no_order_data => 'No order data available.';

  @override
  String admin_overview_orders_count(int count) {
    return '$count orders';
  }

  @override
  String get requests_tab_registrations => 'Registrations';

  @override
  String get requests_tab_go_live => 'Go Live';

  @override
  String get requests_filter_pending => 'Pending';

  @override
  String get requests_filter_approved => 'Approved';

  @override
  String get requests_filter_active => 'Active';

  @override
  String get requests_filter_rejected => 'Rejected';

  @override
  String get requests_filter_suspended => 'Suspended';

  @override
  String get requests_filter_all => 'All';

  @override
  String requests_empty_filtered(String status) {
    return 'No $status requests found.';
  }

  @override
  String get requests_empty_all => 'No registration requests found.';

  @override
  String get requests_go_live_empty => 'No Go Live requests found.';

  @override
  String get requests_go_live_section_pending => 'PENDING REVIEW';

  @override
  String get requests_go_live_section_reviewed => 'REVIEWED';

  @override
  String requests_go_live_requested(String timeAgo, String date) {
    return 'Requested $timeAgo ($date)';
  }

  @override
  String get requests_badge_activated => 'Activated';

  @override
  String get requests_badge_declined => 'Declined';

  @override
  String get requests_badge_pending_review => 'Pending Review';

  @override
  String requests_go_live_activated_on(String date) {
    return 'Activated on $date';
  }

  @override
  String requests_go_live_declined_on(String date) {
    return 'Declined on $date';
  }

  @override
  String get requests_check_logo => 'Logo';

  @override
  String get requests_check_banner => 'Banner';

  @override
  String get requests_check_address => 'Address';

  @override
  String get requests_check_iban => 'IBAN';

  @override
  String get requests_check_photo => 'Profile Photo';

  @override
  String get requests_check_menu => 'Menu Items';

  @override
  String requests_setup_progress(int completed, int total) {
    return '$completed/$total Setup Tasks';
  }

  @override
  String requests_submitted(String date) {
    return 'Submitted $date';
  }

  @override
  String requests_copied(String id) {
    return 'ID copied: $id';
  }

  @override
  String get requests_confirm_approve_title => 'Approve Restaurant?';

  @override
  String get requests_confirm_approve_body =>
      'This will allow the merchant to start setting up their menus and profile.';

  @override
  String get requests_confirm_reject_title => 'Reject Application?';

  @override
  String get requests_confirm_reject_body =>
      'This will prevent the merchant from accessing the dashboard.';

  @override
  String get requests_confirm_suspend_title => 'Suspend Restaurant?';

  @override
  String get requests_confirm_suspend_body =>
      'This will hide the restaurant and all its items from the platform immediately.';

  @override
  String get requests_confirm_reinstate_title => 'Reinstate Restaurant?';

  @override
  String get requests_confirm_reinstate_body =>
      'This will restore the restaurant to Active status and make it visible to customers again.';

  @override
  String get requests_action_copy_id => 'Copy Restaurant ID';

  @override
  String requests_error_failed(String error) {
    return 'Operation failed: $error';
  }

  @override
  String get users_search_hint => 'Search by name or email...';

  @override
  String get users_empty_filtered => 'No users match your filters.';

  @override
  String get users_empty_all => 'No users found in the system.';

  @override
  String users_joined(String date) {
    return 'Joined $date';
  }

  @override
  String get users_detail_title => 'User Details';

  @override
  String get users_detail_id => 'User ID';

  @override
  String get users_detail_phone => 'Phone';

  @override
  String get users_detail_joined => 'Joined';

  @override
  String get users_detail_role => 'Role';

  @override
  String get users_ban_body =>
      'This user will be immediately logged out and prevented from accessing their account.';

  @override
  String get users_unban_body =>
      'This will restore the user\'s access to the platform.';

  @override
  String get users_delete_title => 'Delete User Permanently?';

  @override
  String get users_delete_body =>
      'All user profile data will be permanently removed from the database.';

  @override
  String get users_snack_banned => 'User has been banned from the platform.';

  @override
  String get users_snack_unbanned => 'User access has been restored.';

  @override
  String get users_snack_deleted =>
      'User account has been permanently deleted.';

  @override
  String get users_filter_all => 'All';

  @override
  String get users_filter_restaurant => 'Restaurants';

  @override
  String get users_filter_admin => 'Admin';

  @override
  String get users_filter_customer => 'Customers';

  @override
  String get shell_nav_overview => 'Overview';

  @override
  String get shell_nav_orders => 'Orders';

  @override
  String get shell_nav_menus => 'Menus';

  @override
  String get shell_nav_promotions => 'Promotions';

  @override
  String get shell_nav_analytics => 'Analytics';

  @override
  String get shell_nav_settings => 'Settings';

  @override
  String get shell_restaurant_not_found => 'Restaurant data not found.';

  @override
  String get shell_finish_setup => 'Finish Setup';

  @override
  String get shell_my_account => 'My Account';

  @override
  String get shell_menu_support => 'Support Center';

  @override
  String get shell_menu_sales => 'Sales Contact';

  @override
  String get shell_menu_cookies => 'Cookie Policy';

  @override
  String get shell_menu_settings => 'App Settings';

  @override
  String get shell_menu_logout => 'Logout';

  @override
  String get shell_already_pending =>
      'You already have a pending go-live request.';

  @override
  String get shell_go_live_submitted =>
      'Your go-live request has been submitted for review.';

  @override
  String shell_error(String error) {
    return 'Error: $error';
  }

  @override
  String get shell_go_offline_title => 'Go Offline?';

  @override
  String get shell_go_offline_body =>
      'Your restaurant will no longer be visible to customers on the platform.';

  @override
  String get shell_go_offline_confirm => 'Yes, Go Offline';

  @override
  String get shell_live_go_offline => 'Live / Go Offline';

  @override
  String get shell_go_live_pending => 'Reviewing Request';

  @override
  String get shell_go_live_declined => 'Declined - Try Again';

  @override
  String get shell_request_go_live => 'Request to Go Live';

  @override
  String get gate_pending_title => 'Under Review';

  @override
  String get gate_pending_message =>
      'Our team is currently reviewing your restaurant profile. We will notify you once approved.';

  @override
  String get gate_rejected_title => 'Application Rejected';

  @override
  String get gate_rejected_message =>
      'Unfortunately, your application was not approved. Please contact support for details.';

  @override
  String get gate_suspended_title => 'Account Suspended';

  @override
  String get gate_suspended_message =>
      'Your account has been suspended due to a policy violation.';

  @override
  String get gate_default_title => 'Restricted Access';

  @override
  String get gate_default_message =>
      'You do not have permission to access this dashboard yet.';

  @override
  String get analytics_section_glance => 'AT A GLANCE';

  @override
  String analytics_stat_revenue(int days) {
    return 'Revenue (${days}d)';
  }

  @override
  String analytics_stat_orders(int days) {
    return 'Orders (${days}d)';
  }

  @override
  String get analytics_stat_today => 'Today\'s Sales';

  @override
  String get analytics_stat_avg => 'Avg. Order Value';

  @override
  String get analytics_section_revenue => 'REVENUE TREND';

  @override
  String get analytics_no_revenue => 'No revenue data for this period.';

  @override
  String get analytics_section_status => 'ORDER STATUS BREAKDOWN';

  @override
  String get analytics_no_orders => 'No orders found for this period.';

  @override
  String get analytics_section_popular => 'MOST POPULAR ITEMS';

  @override
  String get analytics_no_items => 'No item data available.';

  @override
  String analytics_orders_count(int count) {
    return '$count orders';
  }

  @override
  String menus_error(String error) {
    return 'Could not load menus: $error';
  }

  @override
  String get menus_empty_title => 'Your menu is empty';

  @override
  String get menus_empty_subtitle =>
      'Create categories like \'Main Courses\' or \'Drinks\' to start organising your kitchen.';

  @override
  String get menus_field_title_hint => 'e.g. Italian Pizzas';

  @override
  String get menus_field_desc_hint =>
      'Briefly describe what\'s in this section...';

  @override
  String get menus_image_browse => 'JPG or PNG, recommended 16:9';

  @override
  String get menus_created => 'Menu category has been created.';

  @override
  String get menus_updated => 'Menu category has been updated.';

  @override
  String get menus_deleted => 'Menu category has been removed.';

  @override
  String get menus_image_cleanup_error =>
      'Menu saved, but the old banner could not be removed from storage.';

  @override
  String get menus_error_missing_ids =>
      'Required IDs are missing. Cannot delete.';

  @override
  String items_error(String error) {
    return 'Error loading items: $error';
  }

  @override
  String get items_empty_title => 'No items here yet';

  @override
  String get items_empty_subtitle =>
      'Start by adding your first dish to this menu.';

  @override
  String get items_field_title_hint => 'e.g. Classic Cheeseburger';

  @override
  String get items_field_info_hint => 'e.g. 200g Beef, Cheddar, Pickles';

  @override
  String get items_field_desc_hint =>
      'Describe the ingredients and preparation...';

  @override
  String get items_field_price_hint => '0.00';

  @override
  String get items_field_tags_hint => 'Vegan, Spicy, GlutenFree...';

  @override
  String get items_tag_hint => 'Add tags (e.g. Popular)';

  @override
  String get items_added => 'Item has been added to your menu.';

  @override
  String get items_updated => 'Item details have been saved.';

  @override
  String get items_deleted => 'Item has been removed from your menu.';

  @override
  String get items_error_no_image => 'Please upload an image first.';

  @override
  String get items_tag_error_empty => 'Tag cannot be empty.';

  @override
  String get items_tag_error_capitalize =>
      'Tag must start with a capital letter.';

  @override
  String get items_tag_error_letters => 'Only letters are allowed in tags.';

  @override
  String get items_tag_error_duplicate => 'This tag already exists.';

  @override
  String get items_discount_info => 'e.g. 500g, spicy, vegan';

  @override
  String get image_cleanup_error =>
      'The new image is saved, but the old image could not be removed from storage.';

  @override
  String overview_welcome(String name) {
    return 'Welcome back, $name!';
  }

  @override
  String get overview_chef_fallback => 'Chef';

  @override
  String get overview_subtitle =>
      'Here is what is happening with your restaurant today.';

  @override
  String get overview_setup_title => 'Finish your setup';

  @override
  String overview_setup_progress(int completed, int total) {
    return '$completed of $total steps completed';
  }

  @override
  String get overview_task_logo_title => 'Upload Logo';

  @override
  String get overview_task_logo_desc =>
      'Your brand identity on the customer app.';

  @override
  String get overview_task_banner_title => 'Restaurant Banner';

  @override
  String get overview_task_banner_desc =>
      'A high-quality photo of your best dish.';

  @override
  String get overview_task_address_title => 'Business Address';

  @override
  String get overview_task_address_desc =>
      'So customers know where to find you.';

  @override
  String get overview_task_photo_title => 'Profile Photo';

  @override
  String get overview_task_photo_desc =>
      'Add a personal touch to your account.';

  @override
  String get overview_task_menu_title => 'Create Menus';

  @override
  String get overview_task_menu_desc =>
      'Add at least one menu category and one item.';

  @override
  String get overview_task_iban_title => 'Payout Details';

  @override
  String get overview_task_iban_desc =>
      'Enter your IBAN to receive weekly earnings.';

  @override
  String get overview_stat_total_orders => 'Total Orders';

  @override
  String get overview_stat_pending => 'Pending';

  @override
  String get overview_stat_completed => 'Completed';

  @override
  String get overview_stat_revenue => 'Total Revenue';

  @override
  String get promo_empty_title => 'No active promotions';

  @override
  String get promo_empty_subtitle =>
      'Create your first campaign to boost your restaurant\'s visibility.';

  @override
  String get promo_field_title_hint => 'e.g. Summer Burger Fest';

  @override
  String get promo_field_desc_hint => 'Explain the offer to your customers...';

  @override
  String promo_items_linked(int count) {
    return '$count Item linked';
  }

  @override
  String promo_items_linked_plural(int count) {
    return '$count Items linked';
  }

  @override
  String get promo_date_order_error => 'End date must be after start date.';

  @override
  String get promo_no_dates => 'Please select both start and end dates.';

  @override
  String get promo_created => 'Promotion is now live.';

  @override
  String get promo_updated => 'Promotion details have been updated.';

  @override
  String get promo_deleted => 'Promotion has been removed.';

  @override
  String get promo_banner_cleanup_error =>
      'Promotion saved, but the old banner could not be removed from storage.';

  @override
  String get promo_error_no_image =>
      'A banner image is required for new promotions.';

  @override
  String get promo_link_no_items => 'No items found in your menus.';

  @override
  String get promo_image_recommended => 'Recommended ratio 16:9';

  @override
  String get settings_error => 'Could not load settings. Please try again.';

  @override
  String get settings_logo_recommended => 'Square PNG or JPG (min. 512x512px)';

  @override
  String get settings_logo_uploading => 'Uploading...';

  @override
  String get settings_logo_updated => 'Restaurant logo has been updated.';

  @override
  String get settings_banner_recommended =>
      'Wide 16:9 aspect ratio recommended';

  @override
  String get settings_banner_updated => 'Cover banner has been updated.';

  @override
  String get settings_business_updated =>
      'Business information has been saved.';

  @override
  String get settings_profile_updated => 'Profile changes have been saved.';

  @override
  String get settings_password_reset_sent =>
      'A password reset link has been sent to your email.';

  @override
  String get settings_delete_dialog_title => 'Are you absolutely sure?';

  @override
  String get settings_delete_dialog_body =>
      'This action is irreversible. All your menus, promotions, and history will be wiped.';

  @override
  String get settings_address_set => 'No address pinned yet';

  @override
  String get settings_map_no_pick => 'Please pick a location on the map first.';

  @override
  String get settings_profile_name_hint => 'Full Name';

  @override
  String get build_user_experience =>
      'Build the next generation of dining experiences.';

  @override
  String get join_thousands =>
      'Join thousands of restaurants growing their business with our platform.';

  @override
  String get sign_in_to_dashboard => 'Sign in to Dashboard';

  @override
  String get create_your_account => 'Create your account';

  @override
  String get new_to_the_platform => 'New to the platform?';

  @override
  String get already_have_an_account => 'Already have an account?';

  @override
  String get with_google => 'with Google';

  @override
  String get terms_of_service =>
      'By continuing, you agree to our Terms of Service and Privacy Policy.';

  @override
  String get errorNoUserRecord =>
      'No user profile found. Please contact support.';

  @override
  String get errorRestaurantAccountOnly =>
      'This portal is for restaurant and admin accounts only.';

  @override
  String get errorNoRestaurantRecord =>
      'No restaurant business profile found for this account.';

  @override
  String get hintEmail => 'Email Address';

  @override
  String get hintPassword => 'Password';

  @override
  String get business => 'Business';

  @override
  String get business_name => 'Business Name';

  @override
  String get business_phone => 'Business Phone';

  @override
  String get owner_full_name => 'Owner Full Name';

  @override
  String get owner_phone => 'Owner Phone';

  @override
  String get creating_partner_account => 'Creating partner account...';

  @override
  String get account_is_pending_approval =>
      'Registration successful! Your account is now pending approval.';

  @override
  String get now_live_in => 'Now live in Kraków & Warsaw';

  @override
  String get put_your_restaurant_on =>
      'Put your restaurant on the digital map.';

  @override
  String get manage_your_menu =>
      'Manage your menu, track live sales, and grow your customer base with our all-in-one merchant dashboard.';

  @override
  String get register_your_restaurant => 'Register Your Restaurant';

  @override
  String get see_how_it_works => 'See How it Works';

  @override
  String get live_platform_stats => 'LIVE PLATFORM STATS';

  @override
  String get restaurants_on_platform => 'Restaurants on platform';

  @override
  String get orders_placed => 'Orders placed';

  @override
  String get menus_published => 'Menus published';

  @override
  String get items_available => 'Items available';

  @override
  String get trusted_by_restaurants => 'TRUSTED BY 200+ LOCAL RESTAURANTS';

  @override
  String get digital_menu => 'Digital Menu';

  @override
  String get your_menu_goes_live_instantly =>
      'Your menu goes live instantly on our customer platform.';

  @override
  String get custom_banners => 'Custom Banners';

  @override
  String get full_creative_control =>
      'Full creative control over your store\'s visual identity.';

  @override
  String get sales_analytics => 'Sales Analytics';

  @override
  String get track_peak_hours =>
      'Track peak hours and top-selling items in real-time.';

  @override
  String get ready_to_grow => 'Ready to grow your revenue?';

  @override
  String get join_restaurants =>
      'Join the restaurants already thriving on our platform.';

  @override
  String get hiw_title => 'How It Works';

  @override
  String get hiw_hero_badge => 'Simple Onboarding';

  @override
  String get hiw_hero_title =>
      'Getting your kitchen online has never been easier.';

  @override
  String get hiw_hero_subtitle =>
      'From registration to your first order, we\'ve streamlined every step.';

  @override
  String get hiw_step1_title => 'Create Account';

  @override
  String get hiw_step1_desc =>
      'Sign up with your business details (NIP/REGON) and owner information.';

  @override
  String get hiw_step2_title => 'Admin Verification';

  @override
  String get hiw_step2_desc =>
      'Our team reviews your application to ensure platform safety and quality standards.';

  @override
  String get hiw_step3_title => 'Setup Your Store';

  @override
  String get hiw_step3_desc =>
      'Upload your logo, set your operating hours, and define your delivery zones.';

  @override
  String get hiw_step4_title => 'Build Your Menu';

  @override
  String get hiw_step4_desc =>
      'Add categories, items, and modifiers. Use our AI tools for high-quality descriptions.';

  @override
  String get hiw_step5_title => 'Go Live';

  @override
  String get hiw_step5_desc =>
      'Switch your status to active and start receiving orders from local customers.';

  @override
  String get hiw_feature1_title => 'Real-time Sync';

  @override
  String get hiw_feature1_desc =>
      'Menu updates reflect instantly on the customer app with zero delay.';

  @override
  String get hiw_feature2_title => 'Detailed Analytics';

  @override
  String get hiw_feature2_desc =>
      'Track your best sellers and peak hours to optimize your staff and inventory.';

  @override
  String get hiw_feature3_title => 'Image Management';

  @override
  String get hiw_feature3_desc =>
      'Integrated cloud storage for all your high-resolution food photography.';

  @override
  String get hiw_feature4_title => 'Role-based Access';

  @override
  String get hiw_feature4_desc =>
      'Securely manage permissions for owners, managers, and kitchen staff.';

  @override
  String get hiw_feature5_title => 'Multi-device';

  @override
  String get hiw_feature5_desc =>
      'Manage your restaurant from a desktop, tablet, or mobile phone seamlessly.';

  @override
  String get hiw_feature6_title => '24/7 Support';

  @override
  String get hiw_feature6_desc =>
      'Our merchant success team is always available to help you grow.';

  @override
  String get hiw_cta_title => 'Ready to grow your revenue?';

  @override
  String get hiw_cta_subtitle =>
      'Join our community of successful restaurants today.';

  @override
  String get hiw_cta_primary => 'Start for Free';

  @override
  String get hiw_cta_secondary => 'View Pricing';

  @override
  String get pricing_title => 'Pricing';

  @override
  String get pricing_hero_badge => 'Transparent Fees';

  @override
  String get pricing_hero_title =>
      'Grow your business without the fixed costs.';

  @override
  String get pricing_hero_subtitle =>
      'We only succeed when you do. No setup fees, no monthly subscriptions.';

  @override
  String get pricing_step1_title => 'Customer Orders';

  @override
  String get pricing_step1_desc =>
      'Orders are placed through our secure customer platform.';

  @override
  String get pricing_step2_title => 'You Prepare';

  @override
  String get pricing_step2_desc =>
      'Manage the kitchen and keep 100% of the tips.';

  @override
  String get pricing_step3_title => 'Weekly Payouts';

  @override
  String get pricing_step3_desc =>
      'Funds are deposited minus our small commission fee.';

  @override
  String get pricing_calculator_title => 'Estimate your earnings.';

  @override
  String get pricing_slider_orders_label => 'Orders per day';

  @override
  String pricing_slider_orders_value(int count, int monthly) {
    return '$count orders ($monthly / month)';
  }

  @override
  String get pricing_slider_avg_label => 'Average order value';

  @override
  String pricing_tier_badge(String name, String pct) {
    return '$name Tier ($pct)';
  }

  @override
  String pricing_tier_monthly(int count) {
    return '$count monthly orders';
  }

  @override
  String get pricing_calc_revenue_label => 'Daily Revenue';

  @override
  String get pricing_calc_revenue_sub => 'Gross sales';

  @override
  String pricing_calc_fee_label(String pct) {
    return 'Platform Fee ($pct)';
  }

  @override
  String get pricing_calc_fee_sub => 'Our commission';

  @override
  String get pricing_calc_keep_label => 'You Keep';

  @override
  String get pricing_calc_disclaimer =>
      'Estimates based on current tier rates. Excludes payment processing fees.';

  @override
  String get pricing_tiers_title => 'The more you sell, the less you pay.';

  @override
  String get pricing_tiers_subtitle =>
      'Commission rates are automatically adjusted based on your previous 30-day order volume.';

  @override
  String get pricing_tier_starter_label => 'Starter';

  @override
  String get pricing_tier_starter_range => '0–100 orders';

  @override
  String get pricing_tier_starter_desc =>
      'Perfect for new restaurants and pop-up kitchens.';

  @override
  String get pricing_tier_growing_label => 'Growing';

  @override
  String get pricing_tier_growing_range => '101–500 orders';

  @override
  String get pricing_tier_growing_desc =>
      'For local favorites starting to scale their delivery.';

  @override
  String get pricing_tier_established_label => 'Established';

  @override
  String get pricing_tier_established_range => '501–1500 orders';

  @override
  String get pricing_tier_established_desc =>
      'High-volume establishments with a loyal following.';

  @override
  String get pricing_tier_partner_label => 'Partner';

  @override
  String get pricing_tier_partner_range => '1500+ orders';

  @override
  String get pricing_tier_partner_desc =>
      'Deep integration for city-wide restaurant groups.';

  @override
  String get pricing_faq1_q => 'Are there any hidden monthly fees?';

  @override
  String get pricing_faq1_a =>
      'No. There are no monthly maintenance or subscription fees. You only pay commission on completed orders.';

  @override
  String get pricing_faq2_q => 'How often do I get paid?';

  @override
  String get pricing_faq2_a =>
      'Payouts are processed weekly every Tuesday for all orders completed in the previous week.';

  @override
  String get pricing_faq3_q => 'Do I pay commission on canceled orders?';

  @override
  String get pricing_faq3_a =>
      'No. If an order is canceled and the customer is refunded, no commission is charged.';

  @override
  String get pricing_faq4_q => 'Who handles the delivery?';

  @override
  String get pricing_faq4_a =>
      'This plan assumes you provide your own delivery staff. We provide the digital infrastructure to manage them.';

  @override
  String get pricing_faq5_q => 'Can I cancel at any time?';

  @override
  String get pricing_faq5_a =>
      'Yes. There are no long-term contracts. You can set your store to Inactive at any time.';

  @override
  String get pricing_cta_title => 'No risk, all reward.';

  @override
  String get pricing_cta_subtitle =>
      'Start receiving orders today and only pay for results.';

  @override
  String get pricing_cta_primary => 'Join as a Partner';

  @override
  String get admin_overview_review => 'Review';

  @override
  String get admin_overview_status_pending => 'Pending';

  @override
  String get admin_overview_status_processing => 'In Progress';

  @override
  String get admin_overview_status_delivered => 'Delivered';

  @override
  String get admin_overview_status_cancelled => 'Cancelled';

  @override
  String get requests_action_activate => 'Activate';

  @override
  String get requests_action_decline => 'Decline';

  @override
  String get requests_action_approve => 'Approve';

  @override
  String get requests_action_reject => 'Reject';

  @override
  String get requests_action_suspend => 'Suspend';

  @override
  String get requests_action_reinstate => 'Reinstate';

  @override
  String get requests_status_approved => 'Approved';

  @override
  String get requests_status_active => 'Active';

  @override
  String get requests_status_rejected => 'Rejected';

  @override
  String get requests_status_suspended => 'Suspended';

  @override
  String get requests_status_pending => 'Pending';

  @override
  String get users_banned_badge => 'BANNED';

  @override
  String get users_action_ban => 'Ban User';

  @override
  String get users_action_unban => 'Unban User';

  @override
  String get users_action_delete => 'Delete User';

  @override
  String get users_confirm_cancel => 'Cancel';

  @override
  String get users_role_admin => 'Platform Admin';

  @override
  String get users_role_restaurant => 'Restaurant Owner';

  @override
  String get users_role_customer => 'Customer';

  @override
  String get users_copied => 'Value copied to clipboard';

  @override
  String get shell_confirm_cancel => 'Cancel';

  @override
  String get analytics_status_normal => 'Normal';

  @override
  String get analytics_status_processing => 'Processing';

  @override
  String get analytics_status_delivered => 'Delivered';

  @override
  String get analytics_status_cancelled => 'Cancelled';

  @override
  String get menus_fab => 'Create Menu';

  @override
  String get menus_sheet_title => 'New Menu Category';

  @override
  String get menus_image_upload_label => 'Category Banner';

  @override
  String get menus_field_title_label => 'Category Name';

  @override
  String get menus_field_title_required => 'Name is required';

  @override
  String get menus_field_desc_label => 'Description';

  @override
  String get menus_field_desc_required => 'Description is required';

  @override
  String get menus_no_image => 'Please select a banner image';

  @override
  String get menus_submit => 'Add Category';

  @override
  String get menus_design_view_items => 'View items';

  @override
  String get menus_design_edit_button => 'Edit';

  @override
  String get menus_design_edit_sheet_title => 'Edit Menu';

  @override
  String get menus_design_delete_button => 'Delete';

  @override
  String get menus_design_change_image_hint => 'Tap to change banner image';

  @override
  String get menus_design_field_title_label => 'Menu Title';

  @override
  String get menus_design_field_title_required => 'Please enter a title';

  @override
  String get menus_design_field_desc_label => 'Description';

  @override
  String get menus_design_field_desc_required => 'Please enter a description';

  @override
  String get menus_design_save_changes => 'Save Changes';

  @override
  String get menus_design_saved => 'Menu updated successfully';

  @override
  String get menus_design_banner_cleanup_error =>
      'Note: Menu updated, but the old image could not be removed.';

  @override
  String get menus_design_delete_dialog_title => 'Delete Menu?';

  @override
  String get menus_design_delete_dialog_body =>
      'Are you sure? This will permanently remove this menu and all its associated data.';

  @override
  String get menus_design_delete_cancel => 'Cancel';

  @override
  String get menus_design_delete_confirm => 'Delete Permanently';

  @override
  String get menus_design_delete_missing_id =>
      'Error: Missing IDs. Cannot delete.';

  @override
  String get menus_design_deleted => 'Menu deleted';

  @override
  String get items_app_bar_fallback => 'Menu Items';

  @override
  String get items_fab => 'Add Item';

  @override
  String get items_sheet_title => 'Add New Item';

  @override
  String get items_image_upload_label => 'Item Photo';

  @override
  String get items_image_browse => 'Tap to browse images';

  @override
  String get items_field_title_label => 'Item Name';

  @override
  String get items_field_info_label => 'Short Info';

  @override
  String get items_field_desc_label => 'Full Description';

  @override
  String get items_field_price_label => 'Base Price';

  @override
  String get items_field_price_required => 'Price is required';

  @override
  String get items_field_price_invalid => 'Enter a valid price';

  @override
  String get items_field_tags_label => 'Tags';

  @override
  String get items_discount_label => 'Discount Percentage';

  @override
  String get items_discount_required => 'Enter discount amount';

  @override
  String get items_discount_invalid => 'Enter 1-100';

  @override
  String get items_no_image => 'Please upload an image first';

  @override
  String get items_submit => 'Create Item';

  @override
  String get items_design_edit_button => 'Edit';

  @override
  String get items_design_image_cleanup_error =>
      'Item updated, but the previous image could not be deleted from storage.';

  @override
  String get items_design_saved => 'Item updated successfully';

  @override
  String get items_design_deleted => 'Item has been removed';

  @override
  String get items_design_delete_dialog_title => 'Delete Item?';

  @override
  String get items_design_delete_dialog_body =>
      'Are you sure you want to delete this item? This action cannot be undone.';

  @override
  String get items_design_delete_cancel => 'Cancel';

  @override
  String get items_design_delete_confirm => 'Delete';

  @override
  String get items_design_edit_sheet_title => 'Edit Item';

  @override
  String get items_design_delete_button => 'Delete';

  @override
  String get items_design_change_image_hint => 'Tap the image to change it';

  @override
  String get items_design_field_title_label => 'Item Name';

  @override
  String get items_field_title_required => 'Name is required';

  @override
  String get items_design_field_info_label => 'Short Info';

  @override
  String get items_design_field_info_hint => 'e.g. 500g, spicy, vegan';

  @override
  String get items_field_info_required => 'Short info is required';

  @override
  String get items_design_field_desc_label => 'Description';

  @override
  String get items_field_desc_required => 'Description is required';

  @override
  String get items_design_field_price_label => 'Base Price';

  @override
  String get items_design_field_price_required => 'Price is required';

  @override
  String get items_design_field_price_invalid => 'Enter a valid price';

  @override
  String get items_design_field_tags_label => 'Tags';

  @override
  String get items_design_field_tags_hint => 'Add tags (e.g. Popular)';

  @override
  String get items_discount_toggle => 'Offer a discount';

  @override
  String get items_design_discount_label => 'Discount Percentage';

  @override
  String get items_design_discount_required => 'Discount value is required';

  @override
  String get items_design_discount_invalid => 'Enter a value between 1 and 100';

  @override
  String get overview_section_glance => 'AT A GLANCE';

  @override
  String get overview_section_orders => 'RECENT ORDERS';

  @override
  String get overview_task_done => 'Done';

  @override
  String get overview_task_setup => 'Setup';

  @override
  String get promo_fab => 'Create Promotion';

  @override
  String get promo_badge_live => 'LIVE';

  @override
  String get promo_badge_inactive => 'INACTIVE';

  @override
  String get promo_edit_button => 'Manage';

  @override
  String get promo_sheet_add_title => 'New Promotion';

  @override
  String get promo_sheet_edit_title => 'Edit Promotion';

  @override
  String get promo_field_title_label => 'Campaign Title';

  @override
  String get promo_field_title_required => 'Please enter a title';

  @override
  String get promo_field_desc_label => 'Short Description';

  @override
  String get promo_field_desc_required => 'Description is required';

  @override
  String get promo_date_start => 'Start Date';

  @override
  String get promo_date_end => 'End Date';

  @override
  String get promo_date_pick => 'Select Date';

  @override
  String get promo_active_toggle => 'Show promotion to customers';

  @override
  String get promo_image_upload_hint => 'Tap to upload a campaign banner';

  @override
  String get promo_image_change_hint => 'Tap to change banner';

  @override
  String get promo_delete_title => 'Delete Promotion?';

  @override
  String get promo_delete_body =>
      'This will permanently remove the campaign and its banner. This action cannot be undone.';

  @override
  String get promo_delete_cancel => 'Keep it';

  @override
  String get promo_delete_confirm => 'Delete';

  @override
  String get promo_no_image => 'A banner image is required for new promotions';

  @override
  String get promo_link_section_label => 'Link Items';

  @override
  String get promo_link_section_hint =>
      'Select which items belong to this promotion.';

  @override
  String get promo_image_upload_label => 'Promotion Image';

  @override
  String get promo_save_changes => 'Save Changes';

  @override
  String get promo_create => 'Launch Promotion';

  @override
  String get settings_section_business => 'Business Details';

  @override
  String get settings_section_business_sub =>
      'Manage your restaurant\'s public identity.';

  @override
  String get settings_section_profile => 'Account Profile';

  @override
  String get settings_section_profile_sub =>
      'Your personal contact information.';

  @override
  String get settings_section_danger => 'Danger Zone';

  @override
  String get settings_section_danger_sub => 'Irreversible account actions.';

  @override
  String get settings_logo_title => 'Restaurant Logo';

  @override
  String get settings_logo_status_staged => 'New logo selected';

  @override
  String get settings_logo_status_exists => 'Logo uploaded';

  @override
  String get settings_logo_status_none => 'No logo set';

  @override
  String get settings_logo_choose => 'Choose Image';

  @override
  String get settings_logo_upload => 'Save Logo';

  @override
  String get settings_logo_success => 'Logo updated successfully!';

  @override
  String get settings_banner_title => 'Cover Banner';

  @override
  String get settings_banner_choose => 'Tap to choose a cover photo';

  @override
  String get settings_banner_upload => 'Save Banner';

  @override
  String get settings_banner_success => 'Banner updated successfully!';

  @override
  String get settings_business_title => 'Store Information';

  @override
  String get settings_address_pick => 'Pin on Map';

  @override
  String get settings_address_change => 'Change';

  @override
  String get settings_business_saved => 'Business information updated!';

  @override
  String get settings_profile_title => 'Account Owner';

  @override
  String get settings_profile_photo_ready => 'New photo ready to save';

  @override
  String get settings_profile_phone_label => 'Contact Phone';

  @override
  String get settings_save_changes => 'Save Changes';

  @override
  String get settings_cancel => 'Cancel';

  @override
  String get settings_danger_reset_title => 'Reset Password';

  @override
  String get settings_danger_reset_sub =>
      'Send a password reset link to your email.';

  @override
  String get settings_danger_reset_button => 'Reset';

  @override
  String get settings_danger_reset_sent =>
      'Reset email sent! Please check your inbox.';

  @override
  String get settings_danger_delete_title => 'Delete Account';

  @override
  String get settings_danger_delete_sub =>
      'Permanently remove your restaurant and all data.';

  @override
  String get settings_danger_delete_button => 'Delete';

  @override
  String get settings_danger_delete_dialog_title => 'Are you absolutely sure?';

  @override
  String get settings_danger_delete_dialog_body =>
      'This action is irreversible. All your menus, promotions, and history will be wiped.';

  @override
  String get settings_map_dialog_title => 'Select Location';

  @override
  String get settings_map_no_location => 'No location selected yet.';

  @override
  String get settings_map_open => 'Open Map';

  @override
  String get settings_map_change => 'Change Location';

  @override
  String get settings_map_confirm => 'Confirm Location';

  @override
  String get settings_profile_saved => 'The changes has been saved';

  @override
  String get how_it_works => 'How It Works';

  @override
  String get pricing => 'Pricing';

  @override
  String get getStarted => 'Get Started';

  @override
  String get tapToUploadImage => 'Tap to upload Image';

  @override
  String get sign_up => 'Sign up';

  @override
  String get log_in => 'Log in';

  @override
  String get sign_in => 'Sign in';

  @override
  String get errorEnterEmailOrPassword =>
      'Please enter your email and password.';

  @override
  String get errorLoginFailed =>
      'Login failed. Please check your connection or credentials.';

  @override
  String get error_no_user_record_found =>
      'No user profile found. Please contact support.';

  @override
  String get permission_restaurant_accounts_only =>
      'This portal is for restaurant and admin accounts only.';

  @override
  String get error_no_restaurant_record_found =>
      'No restaurant business profile found for this account.';

  @override
  String get admin_profile => 'Admin Profile';

  @override
  String get info_continue => 'Continue';

  @override
  String get hintConfPassword => 'Confirm Password';

  @override
  String get errorNoMatchPasswords => 'Passwords do not match.';

  @override
  String get orders_today => 'Orders Today';

  @override
  String get total_orders => 'Total Orders';

  @override
  String get menu_items => 'Menu Items';

  @override
  String get upper_features => 'Features';

  @override
  String get register_now => 'Register Now';

  @override
  String get hiw_section_process => 'The Process';

  @override
  String get hiw_section_features => 'Everything You Need';

  @override
  String get hiw_features_title => 'Powerful tools for modern kitchens.';
}
