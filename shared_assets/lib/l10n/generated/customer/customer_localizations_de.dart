// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'customer_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class CustomerLocalizationsDe extends CustomerLocalizations {
  CustomerLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get welcomeNotifTitle =>
      'Herzlich willkommen und vielen Dank für Ihre Teilnahme bei Freequick! 🍔';

  @override
  String welcomeNotifBody(String name) {
    return 'Hallo $name, dein Konto ist fertig. Entdecke jetzt leckere Gerichte in deiner Nähe!';
  }

  @override
  String get errorBlockedAccount =>
      'Ihr Konto wurde gesperrt oder ist kein Kundenkonto. Bitte kontaktieren Sie den Support.';

  @override
  String get suggestedMatch => 'Vorschlag für eine passende Übereinstimmung';

  @override
  String get confirmContinue => 'Bestätigen & Fortfahren';

  @override
  String get refreshLocation => 'Standort aktualisieren';

  @override
  String get tabFoodDelivery => 'Essenslieferung';

  @override
  String get tabPickup => 'Abholen';

  @override
  String get tabGroceryShopping => 'Lebensmittel';

  @override
  String get tabGifting => 'Geschenke';

  @override
  String get tabBenefits => 'Vorteile';

  @override
  String get orderAgain => 'Erneut bestellen';

  @override
  String get orderAgainSubtitle => 'Basierend auf Ihren letzten Favoriten';

  @override
  String get topRestaurants => 'Top-Restaurants';

  @override
  String get topRestaurantsSubtitle => 'Hoch bewertete Produkte in Ihrer Nähe';

  @override
  String get whatsOnYourMind => 'Was hast du im Kopf?';

  @override
  String get inTheSpotlight => 'Im Rampenlicht';

  @override
  String get allOpenRestaurants => 'Alle geöffneten Restaurants';

  @override
  String get errorLoadingRestaurants => 'Fehler beim Laden der Restaurants';

  @override
  String seeMore(String category) {
    return 'Mehr anzeigen $category';
  }

  @override
  String seeLess(String category) {
    return 'Weniger anzeigen $category';
  }

  @override
  String get categoryDiscounts => 'Rabatte';

  @override
  String get categoryPork => 'Schweinefleisch';

  @override
  String get categoryTonkatsuSashimi => 'Tonkatsu und Sashimi';

  @override
  String get categoryPizza => 'Pizza';

  @override
  String get categoryStew => 'Eintopf';

  @override
  String get categoryChinese => 'chinesisch';

  @override
  String get categoryChicken => 'Huhn';

  @override
  String get categoryKorean => 'Koreanisch';

  @override
  String get categoryOneBowl => 'Ein-Schüssel-Gerichte';

  @override
  String get categoryPichupDiscount => 'Abholrabatt';

  @override
  String get categoryFastFood => 'Fastfood';

  @override
  String get categoryCoffee => 'Kaffee & Dessert';

  @override
  String get categoryBakery => 'Bäckerei';

  @override
  String get categoryLunch => 'Mittagsangebote';

  @override
  String get categoryFreshProduce => 'Frisches Obst und Gemüse';

  @override
  String get categoryDairyEggs => 'Milchprodukte & Eier';

  @override
  String get categoryMeat => 'Fleisch';

  @override
  String get categoryBeverages => 'Getränke';

  @override
  String get categoryFrozen => 'Tiefkühlkost';

  @override
  String get categorySnacks => 'Snacks & Süßigkeiten';

  @override
  String get categoryHousehold => 'Haushaltsartikel';

  @override
  String get categoryCakes => 'Kuchen';

  @override
  String get categoryFlowers => 'Blumen';

  @override
  String get categoryGiftBoxes => 'Geschenkboxen';

  @override
  String get categoryPartySupplies => 'Partyartikel';

  @override
  String get categoryGiftCards => 'Geschenkgutscheine';

  @override
  String get categorySpecialOccasions => 'Besondere Anlässe';

  @override
  String get categoryDailyDeals => 'Tagesangebote';

  @override
  String get categoryLoyaltyRewards => 'Treueprämien';

  @override
  String get categoryCoupons => 'Meine Gutscheine';

  @override
  String get categoryNewOffers => 'Neue Angebote';

  @override
  String get categoryExclusiveDeals => 'Exklusive Angebote';

  @override
  String get cartItemAdded => 'Der Artikel wurde Ihrem Warenkorb hinzugefügt.';

  @override
  String get cartItemRemoved =>
      'Der Artikel wurde aus Ihrem Warenkorb entfernt.';

  @override
  String get cartCleared => 'Ihr Warenkorb wurde geleert.';

  @override
  String get cartAlreadyEmpty => 'Ihr Warenkorb ist bereits leer.';

  @override
  String get cartMaxQuantityReached =>
      'Sie haben die maximale Bestellmenge für diesen Artikel erreicht.';

  @override
  String get cartSingleRestaurantError =>
      'Sie können jeweils nur bei einem Restaurant bestellen.';

  @override
  String get cartItemNotFound => 'Artikel nicht im Warenkorb gefunden.';

  @override
  String get customerOrderHistory => 'Meine Bestellungen';

  @override
  String get orderPlacedSuccess =>
      'Ihre Bestellung wurde erfolgreich aufgegeben.';

  @override
  String get orderCancelledSuccess => 'Ihre Bestellung wurde storniert.';
}
