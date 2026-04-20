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
}
