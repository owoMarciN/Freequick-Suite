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
