// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'customer_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class CustomerLocalizationsEn extends CustomerLocalizations {
  CustomerLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get welcomeNotifTitle => 'Welcome to Freequick!';

  @override
  String welcomeNotifBody(String name) {
    return 'Hi $name, your account is ready. Start exploring delicious meals near you!';
  }

  @override
  String get errorBlockedAccount =>
      'Your account has been blocked or is not a customer account. Please contact support.';

  @override
  String get suggestedMatch => 'Suggested match';

  @override
  String get confirmContinue => 'Confirm & Continue';

  @override
  String get refreshLocation => 'Refresh Location';

  @override
  String get tabFoodDelivery => 'Food Delivery';

  @override
  String get tabPickup => 'Pickup';

  @override
  String get tabGroceryShopping => 'Grocery Shopping';

  @override
  String get tabGifting => 'Gifting';

  @override
  String get tabBenefits => 'Benefits';

  @override
  String get orderAgain => 'Order Again';

  @override
  String get orderAgainSubtitle => 'Based on your recent favorites';

  @override
  String get topRestaurants => 'Top Restaurants';

  @override
  String get topRestaurantsSubtitle => 'Highly rated near you';

  @override
  String get whatsOnYourMind => 'What\'s on your mind?';

  @override
  String get inTheSpotlight => 'In the Spotlight';

  @override
  String get allOpenRestaurants => 'All open restaurants';

  @override
  String get errorLoadingRestaurants => 'Error loading restaurants';

  @override
  String seeMore(String category) {
    return 'See more $category';
  }

  @override
  String seeLess(String category) {
    return 'See less $category';
  }

  @override
  String get fav_pleaseLoginFor => 'Please login to add favorites';

  @override
  String get fav_removed => 'Removed from favorites';

  @override
  String get fav_added => 'Added to favorites';

  @override
  String get fav_error_update => 'Error updating favorites';

  @override
  String get paymentNotCompleted => 'Payment was not completed';

  @override
  String get paymentCancelled => 'Payment cancelled';

  @override
  String paymentFailed(String error) {
    return 'Payment failed: $error';
  }

  @override
  String get categoryDiscounts => 'Discounts';

  @override
  String get categoryPork => 'Pork';

  @override
  String get categoryTonkatsuSashimi => 'Tonkatsu & Sashimi';

  @override
  String get categoryPizza => 'Pizza';

  @override
  String get categoryStew => 'Stew';

  @override
  String get categoryChinese => 'Chinese';

  @override
  String get categoryChicken => 'Chicken';

  @override
  String get categoryKorean => 'Korean';

  @override
  String get categoryOneBowl => 'One-bowl Meals';

  @override
  String get categoryPichupDiscount => 'Pickup Discount';

  @override
  String get categoryFastFood => 'Fast Food';

  @override
  String get categoryCoffee => 'Coffee & Dessert';

  @override
  String get categoryBakery => 'Bakery';

  @override
  String get categoryLunch => 'Lunch Specials';

  @override
  String get categoryFreshProduce => 'Fresh Produce';

  @override
  String get categoryDairyEggs => 'Dairy & Eggs';

  @override
  String get categoryMeat => 'Meat';

  @override
  String get categoryBeverages => 'Beverages';

  @override
  String get categoryFrozen => 'Frozen Foods';

  @override
  String get categorySnacks => 'Snacks & Sweets';

  @override
  String get categoryHousehold => 'Household Essentials';

  @override
  String get categoryCakes => 'Cakes';

  @override
  String get categoryFlowers => 'Flowers';

  @override
  String get categoryGiftBoxes => 'Gift Boxes';

  @override
  String get categoryPartySupplies => 'Party Supplies';

  @override
  String get categoryGiftCards => 'Gift Cards';

  @override
  String get categorySpecialOccasions => 'Special Occasions';

  @override
  String get categoryDailyDeals => 'Daily Deals';

  @override
  String get categoryLoyaltyRewards => 'Loyalty Rewards';

  @override
  String get categoryCoupons => 'My Coupons';

  @override
  String get categoryNewOffers => 'New Offers';

  @override
  String get categoryExclusiveDeals => 'Exclusive Deals';

  @override
  String get jalebi => 'Jalebi';

  @override
  String get kajuBarfi => 'Kaju Barfi';

  @override
  String get gulabJamun => 'Gulab Jamun';

  @override
  String get softDrinks => 'Soft Drinks';

  @override
  String get laddoo => 'Laddoo';

  @override
  String get shake => 'Shake';

  @override
  String get pastries => 'Pastries';

  @override
  String get momos => 'Momos';

  @override
  String get chocolate => 'Chocolate';

  @override
  String get pizza => 'Pizza';

  @override
  String get cartItemAdded => 'Item has been added to your cart.';

  @override
  String get cartItemRemoved => 'Item has been removed from your cart.';

  @override
  String get cartCleared => 'Your cart has been cleared.';

  @override
  String get cartAlreadyEmpty => 'Your cart is already empty.';

  @override
  String get cartMaxQuantityReached =>
      'You have reached the maximum quantity for this item.';

  @override
  String get cartSingleRestaurantError =>
      'You can only order from one restaurant at a time.';

  @override
  String get cartItemNotFound => 'Item not found in cart.';

  @override
  String get customerOrderHistory => 'My Orders';

  @override
  String get orderPlacedSuccess => 'Your order has been placed successfully.';

  @override
  String get orderCancelledSuccess => 'Your order has been cancelled.';

  @override
  String get addressManager => 'Address Manager';

  @override
  String get addNewAddress => 'Add New Address';

  @override
  String get noAddressesYet => 'No addresses yet';

  @override
  String get addDeliveryAddressHint =>
      'Add a delivery address to start placing orders.';

  @override
  String get itemNotFound => 'Item not found';

  @override
  String get unknownItem => 'Unknown Item';

  @override
  String get description => 'Description';

  @override
  String get noDescription => 'No description available';

  @override
  String get quantity => 'Quantity';

  @override
  String addToCartTotal(Object total) {
    return 'Add to Cart - ${total}zł';
  }

  @override
  String get menuNotFound => 'Menu not found';

  @override
  String get noItemsFound => 'No items found in this menu.';

  @override
  String get profileSettingsTitle => 'Profile Settings';

  @override
  String get noChangesDetected => 'No changes detected.';

  @override
  String get updatingProfile => 'Updating profile...';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully!';

  @override
  String get fullName => 'Full Name';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get notificationsSection => 'Notifications';

  @override
  String get notificationsSubtitle => 'Choose which notifications you receive';

  @override
  String get notifOrderStatusLabel => 'Order Status Updates';

  @override
  String get notifOrderStatusSubtitle =>
      'Notified when your order status changes';

  @override
  String get notifPromotionsLabel => 'Promotions & Offers';

  @override
  String get notifPromotionsSubtitle => 'Discounts and deals from restaurants';

  @override
  String get notifNearbyLabel => 'New Restaurants Nearby';

  @override
  String get notifNearbySubtitle => 'When a new restaurant opens in your area';

  @override
  String get notifAppNewsLabel => 'App News & Updates';

  @override
  String get notifAppNewsSubtitle => 'Feature announcements and app news';

  @override
  String get appearanceSection => 'Appearance';

  @override
  String get darkModeLabel => 'Dark Mode';

  @override
  String get darkModeSubtitle => 'Switch to dark theme';

  @override
  String get accountSection => 'Account';

  @override
  String get accountSecurityLabel => 'Account Security';

  @override
  String get accountSecuritySubtitle => 'Change password, 2FA settings';

  @override
  String get deleteAccountLabel => 'Delete Account';

  @override
  String get deleteAccountSubtitle =>
      'Permanently remove your account and data';

  @override
  String comingSoon(Object feature) {
    return '$feature — coming soon!';
  }

  @override
  String get deleteAccountDialogTitle => 'Delete Account';

  @override
  String get deleteAccountDialogContent =>
      'This will permanently delete your account and all your data. This cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get personalInformationSection => 'Personal Information';

  @override
  String get cartScreenTitle => 'Shopping Cart';

  @override
  String get errorLoadingCart => 'Error loading cart';

  @override
  String get addItemsToGetStarted => 'Add items to get started';

  @override
  String get originalTotal => 'Original Total:';

  @override
  String get youSave => 'You Save:';

  @override
  String get total => 'Total:';

  @override
  String get clearCart => 'Clear Cart';

  @override
  String get proceedToCheckout => 'Proceed to Checkout';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get errorLoadingFavorites => 'Error loading favorites';

  @override
  String get noFavoritesYet => 'No favorites yet';

  @override
  String get noFavoritesSubtitle =>
      'Tap the heart icon on any item to save it here';

  @override
  String get topRestaurantsTitle => 'Top Restaurants';

  @override
  String get inTheSpotlightSubtitle => 'All open restaurants';

  @override
  String get offersAndPromotions => 'Offers & Promotions';

  @override
  String get promotionsLive => 'Live';

  @override
  String get orderAgainTitle => 'Order Again';

  @override
  String get promotionBannerPlaceholder =>
      'Promotion banners are displayed here';

  @override
  String get noActivePromotions => 'No active promotions right now';

  @override
  String get restaurantsDisplayedHere => 'Restaurants are displayed here';

  @override
  String get noRestaurantsOpen => 'No restaurants are open right now';

  @override
  String get unknownRestaurant => 'Restaurant';

  @override
  String get navHome => 'Home';

  @override
  String get navOrders => 'Orders';

  @override
  String get navSearch => 'Search';

  @override
  String get navFavorites => 'Favs';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get allCaughtUp => 'You\'re all caught up!';

  @override
  String unreadCount(int count) {
    return '$count unread';
  }

  @override
  String get markAllAsRead => 'Mark all as read';

  @override
  String get timeJustNow => 'Just now';

  @override
  String timeMinutesAgo(int count) {
    return '${count}m ago';
  }

  @override
  String timeHoursAgo(int count) {
    return '${count}h ago';
  }

  @override
  String get timeYesterday => 'Yesterday';

  @override
  String timeDaysAgo(int count) {
    return '${count}d ago';
  }

  @override
  String get searchTitle => 'Search!';

  @override
  String get searchHint => 'Search restaurants or items...';

  @override
  String searchResultCount(int count, int ms) {
    return '$count results (${ms}ms)';
  }

  @override
  String get searchSearching => 'Searching...';

  @override
  String searchError(String message) {
    return 'Error: $message';
  }

  @override
  String get searchRetry => 'Retry';

  @override
  String get searchNoResults => 'No results found';

  @override
  String get searchTypeItem => 'Item';

  @override
  String get searchTypeRestaurant => 'Restaurant';

  @override
  String get searchItemIdMissing => 'Item ID missing';

  @override
  String get searchRestaurantIdMissing => 'Restaurant ID missing';

  @override
  String get searchFiltersTitle => 'Filters';

  @override
  String get searchFilterResetAll => 'Reset All';

  @override
  String get searchFilterCategories => 'Categories';

  @override
  String get searchFilterNames => 'Names';

  @override
  String searchFilterPriceRange(int min, int max) {
    return 'Price Range: $min - $max PLN';
  }

  @override
  String get searchFilterApply => 'Apply Filters';

  @override
  String orderIdMessage(String id) {
    return 'Order #$id';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String quantityMessage(int qty) {
    return 'Qty: $qty';
  }

  @override
  String get viewDetails => 'View Details';

  @override
  String currencyFormat(String price) {
    return '${price}zł';
  }

  @override
  String deliveryTime(String min, String max) {
    return '$min-$max min';
  }

  @override
  String get freeDelivery => 'Free delivery';

  @override
  String get newStatus => 'New';

  @override
  String discountPercent(int percent) {
    return '$percent% OFF';
  }

  @override
  String saveAmount(String amount) {
    return 'Save $amount zł';
  }

  @override
  String get removeItemTitle => 'Remove Item';

  @override
  String removeItemConfirm(String item) {
    return 'Are you sure you want to remove $item from your cart?';
  }

  @override
  String get remove => 'Remove';

  @override
  String get itemRemoved => 'Item removed from cart';

  @override
  String get errorInvalidId => 'Cannot remove item: Invalid item ID';

  @override
  String get details => 'Details';

  @override
  String discountValue(String percent) {
    return '-$percent%';
  }

  @override
  String get untitledMenu => 'Untitled Menu';

  @override
  String get browse => 'Browse';

  @override
  String get recipientName => 'Recipient Name';

  @override
  String get noPhoneNumber => 'No Phone Number';

  @override
  String get deliveryAddress => 'Delivery Address';

  @override
  String get addressNotSpecified => 'Address not specified';

  @override
  String get rateOrderTitle => 'Rate your order';

  @override
  String get skip => 'Skip';

  @override
  String get foodQuality => 'Food Quality';

  @override
  String get deliveryDriver => 'Delivery Driver';

  @override
  String get leaveCommentHint => 'Leave a comment (optional)...';

  @override
  String get submitRating => 'Submit Rating';

  @override
  String get thanksFeedback => 'Thanks for your feedback!';

  @override
  String get ratingValidation => 'Please rate both food and driver.';

  @override
  String errorOccurred(Object error) {
    return 'Error: $error';
  }

  @override
  String get ratingsAndReviews => 'Ratings & Reviews';

  @override
  String reviewCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count reviews',
      one: '1 review',
    );
    return '$_temp0';
  }

  @override
  String get ratingTrend => 'Rating Trend — Last 7 Days';

  @override
  String get notEnoughData => 'Not enough data yet';

  @override
  String get recentReviews => 'Recent Reviews';

  @override
  String get noReviewsYet => 'No reviews yet';

  @override
  String get beTheFirstToRate => 'Be the first to rate this restaurant';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String daysAgo(Object days) {
    return '${days}d ago';
  }

  @override
  String get unknownCustomer => 'Customer';

  @override
  String get noData => 'No data';

  @override
  String get drawerAccount => 'Account';

  @override
  String get profileSettings => 'Profile Settings';

  @override
  String get myOrders => 'My Orders';

  @override
  String get favourites => 'Favourites';

  @override
  String get language => 'Language';

  @override
  String get drawerSupport => 'Support';

  @override
  String get helpFaq => 'Help & FAQ';

  @override
  String get contactUs => 'Contact Us';

  @override
  String get drawerLegal => 'Legal';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get signOut => 'Sign Out';

  @override
  String get policyIntroTitle => '1. Introduction';

  @override
  String get policyIntroBody =>
      'Welcome to Freequick. By using our app you agree to these terms. Please read them carefully before placing an order or using any of our services.';

  @override
  String get policyDataTitle => '2. Data We Collect';

  @override
  String get policyDataBody =>
      'We collect information you provide directly, such as your name, email address, phone number, delivery address, and payment information. We also collect usage data to improve our service.';

  @override
  String get policyUsageTitle => '3. How We Use Your Data';

  @override
  String get policyUsageBody =>
      'Your data is used to process orders, communicate order updates, personalise your experience, and improve our platform. We do not sell your personal data to third parties.';

  @override
  String get policyRightsTitle => '4. Your Rights';

  @override
  String get policyRightsBody =>
      'You have the right to access, correct, or delete your personal data at any time. You can manage your preferences in Profile Settings or contact our support team.';

  @override
  String get policyContactTitle => '5. Contact';

  @override
  String get policyContactBody =>
      'If you have questions about this policy, contact us at support@freequick.app.';
}
