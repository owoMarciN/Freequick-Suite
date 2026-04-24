import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'customer_localizations_de.dart';
import 'customer_localizations_en.dart';
import 'customer_localizations_ko.dart';
import 'customer_localizations_pl.dart';
import 'customer_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of CustomerLocalizations
/// returned by `CustomerLocalizations.of(context)`.
///
/// Applications need to include `CustomerLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'customer/customer_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: CustomerLocalizations.localizationsDelegates,
///   supportedLocales: CustomerLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the CustomerLocalizations.supportedLocales
/// property.
abstract class CustomerLocalizations {
  CustomerLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static CustomerLocalizations? of(BuildContext context) {
    return Localizations.of<CustomerLocalizations>(
        context, CustomerLocalizations);
  }

  static const LocalizationsDelegate<CustomerLocalizations> delegate =
      _CustomerLocalizationsDelegate();

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

  /// No description provided for @welcomeNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Freequick!'**
  String get welcomeNotifTitle;

  /// No description provided for @welcomeNotifBody.
  ///
  /// In en, this message translates to:
  /// **'Hi {name}, your account is ready. Start exploring delicious meals near you!'**
  String welcomeNotifBody(String name);

  /// No description provided for @errorBlockedAccount.
  ///
  /// In en, this message translates to:
  /// **'Your account has been blocked or is not a customer account. Please contact support.'**
  String get errorBlockedAccount;

  /// No description provided for @suggestedMatch.
  ///
  /// In en, this message translates to:
  /// **'Suggested match'**
  String get suggestedMatch;

  /// No description provided for @confirmContinue.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Continue'**
  String get confirmContinue;

  /// No description provided for @refreshLocation.
  ///
  /// In en, this message translates to:
  /// **'Refresh Location'**
  String get refreshLocation;

  /// No description provided for @tabFoodDelivery.
  ///
  /// In en, this message translates to:
  /// **'Food Delivery'**
  String get tabFoodDelivery;

  /// No description provided for @tabPickup.
  ///
  /// In en, this message translates to:
  /// **'Pickup'**
  String get tabPickup;

  /// No description provided for @tabGroceryShopping.
  ///
  /// In en, this message translates to:
  /// **'Grocery Shopping'**
  String get tabGroceryShopping;

  /// No description provided for @tabGifting.
  ///
  /// In en, this message translates to:
  /// **'Gifting'**
  String get tabGifting;

  /// No description provided for @tabBenefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get tabBenefits;

  /// No description provided for @orderAgain.
  ///
  /// In en, this message translates to:
  /// **'Order Again'**
  String get orderAgain;

  /// No description provided for @orderAgainSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Based on your recent favorites'**
  String get orderAgainSubtitle;

  /// No description provided for @topRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Top Restaurants'**
  String get topRestaurants;

  /// No description provided for @topRestaurantsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Highly rated near you'**
  String get topRestaurantsSubtitle;

  /// No description provided for @whatsOnYourMind.
  ///
  /// In en, this message translates to:
  /// **'What\'s on your mind?'**
  String get whatsOnYourMind;

  /// No description provided for @inTheSpotlight.
  ///
  /// In en, this message translates to:
  /// **'In the Spotlight'**
  String get inTheSpotlight;

  /// No description provided for @allOpenRestaurants.
  ///
  /// In en, this message translates to:
  /// **'All open restaurants'**
  String get allOpenRestaurants;

  /// No description provided for @errorLoadingRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Error loading restaurants'**
  String get errorLoadingRestaurants;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See more {category}'**
  String seeMore(String category);

  /// No description provided for @seeLess.
  ///
  /// In en, this message translates to:
  /// **'See less {category}'**
  String seeLess(String category);

  /// No description provided for @fav_pleaseLoginFor.
  ///
  /// In en, this message translates to:
  /// **'Please login to add favorites'**
  String get fav_pleaseLoginFor;

  /// No description provided for @fav_removed.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get fav_removed;

  /// No description provided for @fav_added.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get fav_added;

  /// No description provided for @fav_error_update.
  ///
  /// In en, this message translates to:
  /// **'Error updating favorites'**
  String get fav_error_update;

  /// Shown when the payment intent does not succeed
  ///
  /// In en, this message translates to:
  /// **'Payment was not completed'**
  String get paymentNotCompleted;

  /// Shown when the user cancels the Stripe payment sheet
  ///
  /// In en, this message translates to:
  /// **'Payment cancelled'**
  String get paymentCancelled;

  /// Shown when an unexpected error occurs during payment
  ///
  /// In en, this message translates to:
  /// **'Payment failed: {error}'**
  String paymentFailed(String error);

  /// No description provided for @categoryDiscounts.
  ///
  /// In en, this message translates to:
  /// **'Discounts'**
  String get categoryDiscounts;

  /// No description provided for @categoryPork.
  ///
  /// In en, this message translates to:
  /// **'Pork'**
  String get categoryPork;

  /// No description provided for @categoryTonkatsuSashimi.
  ///
  /// In en, this message translates to:
  /// **'Tonkatsu & Sashimi'**
  String get categoryTonkatsuSashimi;

  /// No description provided for @categoryPizza.
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get categoryPizza;

  /// No description provided for @categoryStew.
  ///
  /// In en, this message translates to:
  /// **'Stew'**
  String get categoryStew;

  /// No description provided for @categoryChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get categoryChinese;

  /// No description provided for @categoryChicken.
  ///
  /// In en, this message translates to:
  /// **'Chicken'**
  String get categoryChicken;

  /// No description provided for @categoryKorean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get categoryKorean;

  /// No description provided for @categoryOneBowl.
  ///
  /// In en, this message translates to:
  /// **'One-bowl Meals'**
  String get categoryOneBowl;

  /// No description provided for @categoryPichupDiscount.
  ///
  /// In en, this message translates to:
  /// **'Pickup Discount'**
  String get categoryPichupDiscount;

  /// No description provided for @categoryFastFood.
  ///
  /// In en, this message translates to:
  /// **'Fast Food'**
  String get categoryFastFood;

  /// No description provided for @categoryCoffee.
  ///
  /// In en, this message translates to:
  /// **'Coffee & Dessert'**
  String get categoryCoffee;

  /// No description provided for @categoryBakery.
  ///
  /// In en, this message translates to:
  /// **'Bakery'**
  String get categoryBakery;

  /// No description provided for @categoryLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch Specials'**
  String get categoryLunch;

  /// No description provided for @categoryFreshProduce.
  ///
  /// In en, this message translates to:
  /// **'Fresh Produce'**
  String get categoryFreshProduce;

  /// No description provided for @categoryDairyEggs.
  ///
  /// In en, this message translates to:
  /// **'Dairy & Eggs'**
  String get categoryDairyEggs;

  /// No description provided for @categoryMeat.
  ///
  /// In en, this message translates to:
  /// **'Meat'**
  String get categoryMeat;

  /// No description provided for @categoryBeverages.
  ///
  /// In en, this message translates to:
  /// **'Beverages'**
  String get categoryBeverages;

  /// No description provided for @categoryFrozen.
  ///
  /// In en, this message translates to:
  /// **'Frozen Foods'**
  String get categoryFrozen;

  /// No description provided for @categorySnacks.
  ///
  /// In en, this message translates to:
  /// **'Snacks & Sweets'**
  String get categorySnacks;

  /// No description provided for @categoryHousehold.
  ///
  /// In en, this message translates to:
  /// **'Household Essentials'**
  String get categoryHousehold;

  /// No description provided for @categoryCakes.
  ///
  /// In en, this message translates to:
  /// **'Cakes'**
  String get categoryCakes;

  /// No description provided for @categoryFlowers.
  ///
  /// In en, this message translates to:
  /// **'Flowers'**
  String get categoryFlowers;

  /// No description provided for @categoryGiftBoxes.
  ///
  /// In en, this message translates to:
  /// **'Gift Boxes'**
  String get categoryGiftBoxes;

  /// No description provided for @categoryPartySupplies.
  ///
  /// In en, this message translates to:
  /// **'Party Supplies'**
  String get categoryPartySupplies;

  /// No description provided for @categoryGiftCards.
  ///
  /// In en, this message translates to:
  /// **'Gift Cards'**
  String get categoryGiftCards;

  /// No description provided for @categorySpecialOccasions.
  ///
  /// In en, this message translates to:
  /// **'Special Occasions'**
  String get categorySpecialOccasions;

  /// No description provided for @categoryDailyDeals.
  ///
  /// In en, this message translates to:
  /// **'Daily Deals'**
  String get categoryDailyDeals;

  /// No description provided for @categoryLoyaltyRewards.
  ///
  /// In en, this message translates to:
  /// **'Loyalty Rewards'**
  String get categoryLoyaltyRewards;

  /// No description provided for @categoryCoupons.
  ///
  /// In en, this message translates to:
  /// **'My Coupons'**
  String get categoryCoupons;

  /// No description provided for @categoryNewOffers.
  ///
  /// In en, this message translates to:
  /// **'New Offers'**
  String get categoryNewOffers;

  /// No description provided for @categoryExclusiveDeals.
  ///
  /// In en, this message translates to:
  /// **'Exclusive Deals'**
  String get categoryExclusiveDeals;

  /// No description provided for @jalebi.
  ///
  /// In en, this message translates to:
  /// **'Jalebi'**
  String get jalebi;

  /// No description provided for @kajuBarfi.
  ///
  /// In en, this message translates to:
  /// **'Kaju Barfi'**
  String get kajuBarfi;

  /// No description provided for @gulabJamun.
  ///
  /// In en, this message translates to:
  /// **'Gulab Jamun'**
  String get gulabJamun;

  /// No description provided for @softDrinks.
  ///
  /// In en, this message translates to:
  /// **'Soft Drinks'**
  String get softDrinks;

  /// No description provided for @laddoo.
  ///
  /// In en, this message translates to:
  /// **'Laddoo'**
  String get laddoo;

  /// No description provided for @shake.
  ///
  /// In en, this message translates to:
  /// **'Shake'**
  String get shake;

  /// No description provided for @pastries.
  ///
  /// In en, this message translates to:
  /// **'Pastries'**
  String get pastries;

  /// No description provided for @momos.
  ///
  /// In en, this message translates to:
  /// **'Momos'**
  String get momos;

  /// No description provided for @chocolate.
  ///
  /// In en, this message translates to:
  /// **'Chocolate'**
  String get chocolate;

  /// No description provided for @pizza.
  ///
  /// In en, this message translates to:
  /// **'Pizza'**
  String get pizza;

  /// No description provided for @cartItemAdded.
  ///
  /// In en, this message translates to:
  /// **'Item has been added to your cart.'**
  String get cartItemAdded;

  /// No description provided for @cartItemRemoved.
  ///
  /// In en, this message translates to:
  /// **'Item has been removed from your cart.'**
  String get cartItemRemoved;

  /// No description provided for @cartCleared.
  ///
  /// In en, this message translates to:
  /// **'Your cart has been cleared.'**
  String get cartCleared;

  /// No description provided for @cartAlreadyEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is already empty.'**
  String get cartAlreadyEmpty;

  /// No description provided for @cartMaxQuantityReached.
  ///
  /// In en, this message translates to:
  /// **'You have reached the maximum quantity for this item.'**
  String get cartMaxQuantityReached;

  /// No description provided for @cartSingleRestaurantError.
  ///
  /// In en, this message translates to:
  /// **'You can only order from one restaurant at a time.'**
  String get cartSingleRestaurantError;

  /// No description provided for @cartItemNotFound.
  ///
  /// In en, this message translates to:
  /// **'Item not found in cart.'**
  String get cartItemNotFound;

  /// No description provided for @customerOrderHistory.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get customerOrderHistory;

  /// No description provided for @orderPlacedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your order has been placed successfully.'**
  String get orderPlacedSuccess;

  /// No description provided for @orderCancelledSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your order has been cancelled.'**
  String get orderCancelledSuccess;

  /// No description provided for @addressManager.
  ///
  /// In en, this message translates to:
  /// **'Address Manager'**
  String get addressManager;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addNewAddress;

  /// No description provided for @noAddressesYet.
  ///
  /// In en, this message translates to:
  /// **'No addresses yet'**
  String get noAddressesYet;

  /// No description provided for @addDeliveryAddressHint.
  ///
  /// In en, this message translates to:
  /// **'Add a delivery address to start placing orders.'**
  String get addDeliveryAddressHint;

  /// No description provided for @itemNotFound.
  ///
  /// In en, this message translates to:
  /// **'Item not found'**
  String get itemNotFound;

  /// No description provided for @unknownItem.
  ///
  /// In en, this message translates to:
  /// **'Unknown Item'**
  String get unknownItem;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description available'**
  String get noDescription;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @addToCartTotal.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart - {total}zł'**
  String addToCartTotal(Object total);

  /// No description provided for @menuNotFound.
  ///
  /// In en, this message translates to:
  /// **'Menu not found'**
  String get menuNotFound;

  /// No description provided for @noItemsFound.
  ///
  /// In en, this message translates to:
  /// **'No items found in this menu.'**
  String get noItemsFound;

  /// No description provided for @profileSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profileSettingsTitle;

  /// No description provided for @noChangesDetected.
  ///
  /// In en, this message translates to:
  /// **'No changes detected.'**
  String get noChangesDetected;

  /// No description provided for @updatingProfile.
  ///
  /// In en, this message translates to:
  /// **'Updating profile...'**
  String get updatingProfile;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @notificationsSection.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsSection;

  /// No description provided for @notificationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose which notifications you receive'**
  String get notificationsSubtitle;

  /// No description provided for @notifOrderStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Order Status Updates'**
  String get notifOrderStatusLabel;

  /// No description provided for @notifOrderStatusSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Notified when your order status changes'**
  String get notifOrderStatusSubtitle;

  /// No description provided for @notifPromotionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Promotions & Offers'**
  String get notifPromotionsLabel;

  /// No description provided for @notifPromotionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Discounts and deals from restaurants'**
  String get notifPromotionsSubtitle;

  /// No description provided for @notifNearbyLabel.
  ///
  /// In en, this message translates to:
  /// **'New Restaurants Nearby'**
  String get notifNearbyLabel;

  /// No description provided for @notifNearbySubtitle.
  ///
  /// In en, this message translates to:
  /// **'When a new restaurant opens in your area'**
  String get notifNearbySubtitle;

  /// No description provided for @notifAppNewsLabel.
  ///
  /// In en, this message translates to:
  /// **'App News & Updates'**
  String get notifAppNewsLabel;

  /// No description provided for @notifAppNewsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Feature announcements and app news'**
  String get notifAppNewsSubtitle;

  /// No description provided for @appearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceSection;

  /// No description provided for @darkModeLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkModeLabel;

  /// No description provided for @darkModeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch to dark theme'**
  String get darkModeSubtitle;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSection;

  /// No description provided for @accountSecurityLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Security'**
  String get accountSecurityLabel;

  /// No description provided for @accountSecuritySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change password, 2FA settings'**
  String get accountSecuritySubtitle;

  /// No description provided for @deleteAccountLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountLabel;

  /// No description provided for @deleteAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Permanently remove your account and data'**
  String get deleteAccountSubtitle;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'{feature} — coming soon!'**
  String comingSoon(Object feature);

  /// No description provided for @deleteAccountDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountDialogTitle;

  /// No description provided for @deleteAccountDialogContent.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account and all your data. This cannot be undone.'**
  String get deleteAccountDialogContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @personalInformationSection.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformationSection;

  /// No description provided for @cartScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping Cart'**
  String get cartScreenTitle;

  /// No description provided for @errorLoadingCart.
  ///
  /// In en, this message translates to:
  /// **'Error loading cart'**
  String get errorLoadingCart;

  /// No description provided for @addItemsToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Add items to get started'**
  String get addItemsToGetStarted;

  /// No description provided for @originalTotal.
  ///
  /// In en, this message translates to:
  /// **'Original Total:'**
  String get originalTotal;

  /// No description provided for @youSave.
  ///
  /// In en, this message translates to:
  /// **'You Save:'**
  String get youSave;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total:'**
  String get total;

  /// No description provided for @clearCart.
  ///
  /// In en, this message translates to:
  /// **'Clear Cart'**
  String get clearCart;

  /// No description provided for @proceedToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get proceedToCheckout;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @errorLoadingFavorites.
  ///
  /// In en, this message translates to:
  /// **'Error loading favorites'**
  String get errorLoadingFavorites;

  /// No description provided for @noFavoritesYet.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavoritesYet;

  /// No description provided for @noFavoritesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart icon on any item to save it here'**
  String get noFavoritesSubtitle;

  /// No description provided for @topRestaurantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Top Restaurants'**
  String get topRestaurantsTitle;

  /// No description provided for @inTheSpotlightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All open restaurants'**
  String get inTheSpotlightSubtitle;

  /// No description provided for @offersAndPromotions.
  ///
  /// In en, this message translates to:
  /// **'Offers & Promotions'**
  String get offersAndPromotions;

  /// No description provided for @promotionsLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get promotionsLive;

  /// No description provided for @orderAgainTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Again'**
  String get orderAgainTitle;

  /// No description provided for @promotionBannerPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Promotion banners are displayed here'**
  String get promotionBannerPlaceholder;

  /// No description provided for @noActivePromotions.
  ///
  /// In en, this message translates to:
  /// **'No active promotions right now'**
  String get noActivePromotions;

  /// No description provided for @restaurantsDisplayedHere.
  ///
  /// In en, this message translates to:
  /// **'Restaurants are displayed here'**
  String get restaurantsDisplayedHere;

  /// No description provided for @noRestaurantsOpen.
  ///
  /// In en, this message translates to:
  /// **'No restaurants are open right now'**
  String get noRestaurantsOpen;

  /// No description provided for @unknownRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get unknownRestaurant;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get navOrders;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favs'**
  String get navFavorites;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @allCaughtUp.
  ///
  /// In en, this message translates to:
  /// **'You\'re all caught up!'**
  String get allCaughtUp;

  /// No description provided for @unreadCount.
  ///
  /// In en, this message translates to:
  /// **'{count} unread'**
  String unreadCount(int count);

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// No description provided for @timeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get timeJustNow;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String timeMinutesAgo(int count);

  /// No description provided for @timeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String timeHoursAgo(int count);

  /// No description provided for @timeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get timeYesterday;

  /// No description provided for @timeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}d ago'**
  String timeDaysAgo(int count);

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search!'**
  String get searchTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search restaurants or items...'**
  String get searchHint;

  /// No description provided for @searchResultCount.
  ///
  /// In en, this message translates to:
  /// **'{count} results ({ms}ms)'**
  String searchResultCount(int count, int ms);

  /// No description provided for @searchSearching.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searchSearching;

  /// No description provided for @searchError.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String searchError(String message);

  /// No description provided for @searchRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get searchRetry;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get searchNoResults;

  /// No description provided for @searchTypeItem.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get searchTypeItem;

  /// No description provided for @searchTypeRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get searchTypeRestaurant;

  /// No description provided for @searchItemIdMissing.
  ///
  /// In en, this message translates to:
  /// **'Item ID missing'**
  String get searchItemIdMissing;

  /// No description provided for @searchRestaurantIdMissing.
  ///
  /// In en, this message translates to:
  /// **'Restaurant ID missing'**
  String get searchRestaurantIdMissing;

  /// No description provided for @searchFiltersTitle.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get searchFiltersTitle;

  /// No description provided for @searchFilterResetAll.
  ///
  /// In en, this message translates to:
  /// **'Reset All'**
  String get searchFilterResetAll;

  /// No description provided for @searchFilterCategories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get searchFilterCategories;

  /// No description provided for @searchFilterNames.
  ///
  /// In en, this message translates to:
  /// **'Names'**
  String get searchFilterNames;

  /// No description provided for @searchFilterPriceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range: {min} - {max} PLN'**
  String searchFilterPriceRange(int min, int max);

  /// No description provided for @searchFilterApply.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get searchFilterApply;

  /// No description provided for @orderIdMessage.
  ///
  /// In en, this message translates to:
  /// **'Order #{id}'**
  String orderIdMessage(String id);

  /// No description provided for @itemCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 item} other{{count} items}}'**
  String itemCount(int count);

  /// No description provided for @quantityMessage.
  ///
  /// In en, this message translates to:
  /// **'Qty: {qty}'**
  String quantityMessage(int qty);

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @currencyFormat.
  ///
  /// In en, this message translates to:
  /// **'{price}zł'**
  String currencyFormat(String price);

  /// No description provided for @deliveryTime.
  ///
  /// In en, this message translates to:
  /// **'{min}-{max} min'**
  String deliveryTime(String min, String max);

  /// No description provided for @freeDelivery.
  ///
  /// In en, this message translates to:
  /// **'Free delivery'**
  String get freeDelivery;

  /// No description provided for @newStatus.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newStatus;

  /// No description provided for @discountPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% OFF'**
  String discountPercent(int percent);

  /// No description provided for @saveAmount.
  ///
  /// In en, this message translates to:
  /// **'Save {amount} zł'**
  String saveAmount(String amount);

  /// No description provided for @removeItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove Item'**
  String get removeItemTitle;

  /// No description provided for @removeItemConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove {item} from your cart?'**
  String removeItemConfirm(String item);

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @itemRemoved.
  ///
  /// In en, this message translates to:
  /// **'Item removed from cart'**
  String get itemRemoved;

  /// No description provided for @errorInvalidId.
  ///
  /// In en, this message translates to:
  /// **'Cannot remove item: Invalid item ID'**
  String get errorInvalidId;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @discountValue.
  ///
  /// In en, this message translates to:
  /// **'-{percent}%'**
  String discountValue(String percent);

  /// No description provided for @untitledMenu.
  ///
  /// In en, this message translates to:
  /// **'Untitled Menu'**
  String get untitledMenu;

  /// No description provided for @browse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get browse;

  /// No description provided for @recipientName.
  ///
  /// In en, this message translates to:
  /// **'Recipient Name'**
  String get recipientName;

  /// No description provided for @noPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'No Phone Number'**
  String get noPhoneNumber;

  /// No description provided for @deliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get deliveryAddress;

  /// No description provided for @addressNotSpecified.
  ///
  /// In en, this message translates to:
  /// **'Address not specified'**
  String get addressNotSpecified;

  /// No description provided for @rateOrderTitle.
  ///
  /// In en, this message translates to:
  /// **'Rate your order'**
  String get rateOrderTitle;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @foodQuality.
  ///
  /// In en, this message translates to:
  /// **'Food Quality'**
  String get foodQuality;

  /// No description provided for @deliveryDriver.
  ///
  /// In en, this message translates to:
  /// **'Delivery Driver'**
  String get deliveryDriver;

  /// No description provided for @leaveCommentHint.
  ///
  /// In en, this message translates to:
  /// **'Leave a comment (optional)...'**
  String get leaveCommentHint;

  /// No description provided for @submitRating.
  ///
  /// In en, this message translates to:
  /// **'Submit Rating'**
  String get submitRating;

  /// No description provided for @thanksFeedback.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your feedback!'**
  String get thanksFeedback;

  /// No description provided for @ratingValidation.
  ///
  /// In en, this message translates to:
  /// **'Please rate both food and driver.'**
  String get ratingValidation;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorOccurred(Object error);

  /// No description provided for @ratingsAndReviews.
  ///
  /// In en, this message translates to:
  /// **'Ratings & Reviews'**
  String get ratingsAndReviews;

  /// No description provided for @reviewCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 review} other{{count} reviews}}'**
  String reviewCount(num count);

  /// No description provided for @ratingTrend.
  ///
  /// In en, this message translates to:
  /// **'Rating Trend — Last 7 Days'**
  String get ratingTrend;

  /// No description provided for @notEnoughData.
  ///
  /// In en, this message translates to:
  /// **'Not enough data yet'**
  String get notEnoughData;

  /// No description provided for @recentReviews.
  ///
  /// In en, this message translates to:
  /// **'Recent Reviews'**
  String get recentReviews;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @beTheFirstToRate.
  ///
  /// In en, this message translates to:
  /// **'Be the first to rate this restaurant'**
  String get beTheFirstToRate;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d ago'**
  String daysAgo(Object days);

  /// No description provided for @unknownCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get unknownCustomer;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @drawerAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get drawerAccount;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Profile Settings'**
  String get profileSettings;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @favourites.
  ///
  /// In en, this message translates to:
  /// **'Favourites'**
  String get favourites;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @drawerSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get drawerSupport;

  /// No description provided for @helpFaq.
  ///
  /// In en, this message translates to:
  /// **'Help & FAQ'**
  String get helpFaq;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @drawerLegal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get drawerLegal;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @policyIntroTitle.
  ///
  /// In en, this message translates to:
  /// **'1. Introduction'**
  String get policyIntroTitle;

  /// No description provided for @policyIntroBody.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Freequick. By using our app you agree to these terms. Please read them carefully before placing an order or using any of our services.'**
  String get policyIntroBody;

  /// No description provided for @policyDataTitle.
  ///
  /// In en, this message translates to:
  /// **'2. Data We Collect'**
  String get policyDataTitle;

  /// No description provided for @policyDataBody.
  ///
  /// In en, this message translates to:
  /// **'We collect information you provide directly, such as your name, email address, phone number, delivery address, and payment information. We also collect usage data to improve our service.'**
  String get policyDataBody;

  /// No description provided for @policyUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'3. How We Use Your Data'**
  String get policyUsageTitle;

  /// No description provided for @policyUsageBody.
  ///
  /// In en, this message translates to:
  /// **'Your data is used to process orders, communicate order updates, personalise your experience, and improve our platform. We do not sell your personal data to third parties.'**
  String get policyUsageBody;

  /// No description provided for @policyRightsTitle.
  ///
  /// In en, this message translates to:
  /// **'4. Your Rights'**
  String get policyRightsTitle;

  /// No description provided for @policyRightsBody.
  ///
  /// In en, this message translates to:
  /// **'You have the right to access, correct, or delete your personal data at any time. You can manage your preferences in Profile Settings or contact our support team.'**
  String get policyRightsBody;

  /// No description provided for @policyContactTitle.
  ///
  /// In en, this message translates to:
  /// **'5. Contact'**
  String get policyContactTitle;

  /// No description provided for @policyContactBody.
  ///
  /// In en, this message translates to:
  /// **'If you have questions about this policy, contact us at support@freequick.app.'**
  String get policyContactBody;
}

class _CustomerLocalizationsDelegate
    extends LocalizationsDelegate<CustomerLocalizations> {
  const _CustomerLocalizationsDelegate();

  @override
  Future<CustomerLocalizations> load(Locale locale) {
    return SynchronousFuture<CustomerLocalizations>(
        lookupCustomerLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'ko', 'pl', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_CustomerLocalizationsDelegate old) => false;
}

CustomerLocalizations lookupCustomerLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return CustomerLocalizationsDe();
    case 'en':
      return CustomerLocalizationsEn();
    case 'ko':
      return CustomerLocalizationsKo();
    case 'pl':
      return CustomerLocalizationsPl();
    case 'uk':
      return CustomerLocalizationsUk();
  }

  throw FlutterError(
      'CustomerLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
