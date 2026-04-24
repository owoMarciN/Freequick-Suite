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
  String get fav_pleaseLoginFor =>
      'Bitte melden Sie sich an, um Favoriten hinzuzufügen.';

  @override
  String get fav_removed => 'Aus den Favoriten entfernt';

  @override
  String get fav_added => 'Zu Favoriten hinzugefügt';

  @override
  String get fav_error_update => 'Fehler beim Aktualisieren der Favoriten';

  @override
  String get paymentNotCompleted => 'Die Zahlung wurde nicht abgeschlossen.';

  @override
  String get paymentCancelled => 'Zahlung storniert';

  @override
  String paymentFailed(String error) {
    return 'Zahlung fehlgeschlagen: $error';
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
  String get jalebi => 'Jalebi';

  @override
  String get kajuBarfi => 'Kaju Barfi';

  @override
  String get gulabJamun => 'Gulab Jamun';

  @override
  String get softDrinks => 'Erfrischungsgetränke';

  @override
  String get laddoo => 'Laddoo';

  @override
  String get shake => 'Shake';

  @override
  String get pastries => 'Gebäck';

  @override
  String get momos => 'Momos';

  @override
  String get chocolate => 'Schokolade';

  @override
  String get pizza => 'Pizza';

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

  @override
  String get addressManager => 'Adressmanager';

  @override
  String get addNewAddress => 'Neue Adresse hinzufügen';

  @override
  String get noAddressesYet => 'Noch keine Adressen.';

  @override
  String get addDeliveryAddressHint =>
      'Geben Sie eine Lieferadresse an, um Bestellungen aufzugeben.';

  @override
  String get itemNotFound => 'Artikel nicht gefunden';

  @override
  String get unknownItem => 'Unbekannter Gegenstand';

  @override
  String get description => 'Beschreibung';

  @override
  String get noDescription => 'Keine Beschreibung verfügbar';

  @override
  String get quantity => 'Menge';

  @override
  String addToCartTotal(Object total) {
    return 'In den Warenkorb - ${total}zł';
  }

  @override
  String get menuNotFound => 'Menü nicht gefunden';

  @override
  String get noItemsFound => 'In diesem Menü wurden keine Artikel gefunden.';

  @override
  String get profileSettingsTitle => 'Profileinstellungen';

  @override
  String get noChangesDetected => 'Keine Änderungen festgestellt.';

  @override
  String get updatingProfile => 'Profil wird aktualisiert...';

  @override
  String get profileUpdatedSuccessfully => 'Profil erfolgreich aktualisiert!';

  @override
  String get fullName => 'Vollständiger Name';

  @override
  String get phoneNumber => 'Telefonnummer';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get notificationsSection => 'Benachrichtigungen';

  @override
  String get notificationsSubtitle =>
      'Wählen Sie aus, welche Benachrichtigungen Sie erhalten möchten.';

  @override
  String get notifOrderStatusLabel => 'Bestellstatus-Aktualisierungen';

  @override
  String get notifOrderStatusSubtitle =>
      'Sie werden benachrichtigt, wenn sich der Status Ihrer Bestellung ändert.';

  @override
  String get notifPromotionsLabel => 'Aktionen & Angebote';

  @override
  String get notifPromotionsSubtitle => 'Rabatte und Angebote von Restaurants';

  @override
  String get notifNearbyLabel => 'Neue Restaurants in der Nähe';

  @override
  String get notifNearbySubtitle =>
      'Wenn in Ihrer Gegend ein neues Restaurant eröffnet';

  @override
  String get notifAppNewsLabel => 'App-Neuigkeiten & Updates';

  @override
  String get notifAppNewsSubtitle =>
      'Funktionsankündigungen und App-Neuigkeiten';

  @override
  String get appearanceSection => 'Aussehen';

  @override
  String get darkModeLabel => 'Dunkelmodus';

  @override
  String get darkModeSubtitle => 'Zum dunklen Design wechseln';

  @override
  String get accountSection => 'Konto';

  @override
  String get accountSecurityLabel => 'Kontosicherheit';

  @override
  String get accountSecuritySubtitle => 'Passwort ändern, 2FA-Einstellungen';

  @override
  String get deleteAccountLabel => 'Konto löschen';

  @override
  String get deleteAccountSubtitle =>
      'Löschen Sie Ihr Konto und Ihre Daten endgültig.';

  @override
  String comingSoon(Object feature) {
    return '$feature — demnächst verfügbar!';
  }

  @override
  String get deleteAccountDialogTitle => 'Konto löschen';

  @override
  String get deleteAccountDialogContent =>
      'Dadurch werden Ihr Konto und alle Ihre Daten endgültig gelöscht. Dieser Vorgang kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Stornieren';

  @override
  String get delete => 'Löschen';

  @override
  String get personalInformationSection => 'Persönliche Daten';

  @override
  String get cartScreenTitle => 'Warenkorb';

  @override
  String get errorLoadingCart => 'Fehler beim Laden des Warenkorbs';

  @override
  String get addItemsToGetStarted => 'Fügen Sie Elemente hinzu, um loszulegen.';

  @override
  String get originalTotal => 'Ursprünglicher Gesamtbetrag:';

  @override
  String get youSave => 'Sie sparen:';

  @override
  String get total => 'Gesamt:';

  @override
  String get clearCart => 'Warenkorb leeren';

  @override
  String get proceedToCheckout => 'Zur Kasse gehen';

  @override
  String get favoritesTitle => 'Favoriten';

  @override
  String get errorLoadingFavorites => 'Fehler beim Laden der Favoriten';

  @override
  String get noFavoritesYet => 'Noch keine Favoriten';

  @override
  String get noFavoritesSubtitle =>
      'Tippe auf das Herzsymbol bei einem beliebigen Element, um es hier zu speichern.';

  @override
  String get topRestaurantsTitle => 'Top-Restaurants';

  @override
  String get inTheSpotlightSubtitle => 'Alle geöffneten Restaurants';

  @override
  String get offersAndPromotions => 'Angebote & Aktionen';

  @override
  String get promotionsLive => 'Live';

  @override
  String get orderAgainTitle => 'Erneut bestellen';

  @override
  String get promotionBannerPlaceholder => 'Hier werden Werbebanner angezeigt.';

  @override
  String get noActivePromotions => 'Derzeit sind keine Aktionen aktiv.';

  @override
  String get restaurantsDisplayedHere => 'Hier werden Restaurants angezeigt';

  @override
  String get noRestaurantsOpen => 'Derzeit sind keine Restaurants geöffnet.';

  @override
  String get unknownRestaurant => 'Restaurant';

  @override
  String get navHome => 'Heim';

  @override
  String get navOrders => 'Bestellungen';

  @override
  String get navSearch => 'Suchen';

  @override
  String get navFavorites => 'Favoriten';

  @override
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get noNotifications => 'Keine Benachrichtigungen';

  @override
  String get allCaughtUp => 'Sie sind nun auf dem neuesten Stand!';

  @override
  String unreadCount(int count) {
    return '$count ungelesen';
  }

  @override
  String get markAllAsRead => 'Alle als gelesen markieren';

  @override
  String get timeJustNow => 'Soeben';

  @override
  String timeMinutesAgo(int count) {
    return '${count}m vor';
  }

  @override
  String timeHoursAgo(int count) {
    return 'vor 5 Stunden';
  }

  @override
  String get timeYesterday => 'Gestern';

  @override
  String timeDaysAgo(int count) {
    return '${count}d ago';
  }

  @override
  String get searchTitle => 'Suchen!';

  @override
  String get searchHint => 'Restaurants oder Artikel suchen...';

  @override
  String searchResultCount(int count, int ms) {
    return '$count Ergebnisse (${ms}ms)';
  }

  @override
  String get searchSearching => 'Suche...';

  @override
  String searchError(String message) {
    return 'Fehler: $message';
  }

  @override
  String get searchRetry => 'Wiederholen';

  @override
  String get searchNoResults => 'Keine Ergebnisse gefunden';

  @override
  String get searchTypeItem => 'Artikel';

  @override
  String get searchTypeRestaurant => 'Restaurant';

  @override
  String get searchItemIdMissing => 'Artikel-ID fehlt';

  @override
  String get searchRestaurantIdMissing => 'Restaurant-ID fehlt';

  @override
  String get searchFiltersTitle => 'Filter';

  @override
  String get searchFilterResetAll => 'Alles zurücksetzen';

  @override
  String get searchFilterCategories => 'Kategorien';

  @override
  String get searchFilterNames => 'Namen';

  @override
  String searchFilterPriceRange(int min, int max) {
    return 'Preisspanne: $min - $max PLN';
  }

  @override
  String get searchFilterApply => 'Filter anwenden';

  @override
  String orderIdMessage(String id) {
    return 'Bestellung Nr.$id';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Artikel',
      one: '1 Stück',
    );
    return '$_temp0';
  }

  @override
  String quantityMessage(int qty) {
    return 'Menge: $qty';
  }

  @override
  String get viewDetails => 'Details anzeigen';

  @override
  String currencyFormat(String price) {
    return '${price}zł';
  }

  @override
  String deliveryTime(String min, String max) {
    return '$min–$max min';
  }

  @override
  String get freeDelivery => 'Kostenloser Versand';

  @override
  String get newStatus => 'Neu';

  @override
  String discountPercent(int percent) {
    return '13 % Rabatt';
  }

  @override
  String saveAmount(String amount) {
    return 'Spare $amount zł';
  }

  @override
  String get removeItemTitle => 'Element entfernen';

  @override
  String removeItemConfirm(String item) {
    return 'Möchten Sie $item wirklich aus Ihrem Warenkorb entfernen?';
  }

  @override
  String get remove => 'Entfernen';

  @override
  String get itemRemoved => 'Artikel aus dem Warenkorb entfernt';

  @override
  String get errorInvalidId =>
      'Artikel kann nicht entfernt werden: Ungültige Artikel-ID';

  @override
  String get details => 'Details';

  @override
  String discountValue(String percent) {
    return '-$percent%';
  }

  @override
  String get untitledMenu => 'Unbenanntes Menü';

  @override
  String get browse => 'Durchsuchen';

  @override
  String get recipientName => 'Name des Empfängers';

  @override
  String get noPhoneNumber => 'Keine Telefonnummer';

  @override
  String get deliveryAddress => 'Lieferadresse';

  @override
  String get addressNotSpecified => 'Adresse nicht angegeben';

  @override
  String get rateOrderTitle => 'Bewerten Sie Ihre Bestellung';

  @override
  String get skip => 'Überspringen';

  @override
  String get foodQuality => 'Lebensmittelqualität';

  @override
  String get deliveryDriver => 'Auslieferungsfahrer';

  @override
  String get leaveCommentHint =>
      'Hinterlassen Sie einen Kommentar (optional)...';

  @override
  String get submitRating => 'Bewertung abgeben';

  @override
  String get thanksFeedback => 'Vielen Dank für Ihr Feedback!';

  @override
  String get ratingValidation =>
      'Bitte bewerten Sie sowohl das Essen als auch den Fahrer.';

  @override
  String errorOccurred(Object error) {
    return 'Fehler: $error';
  }

  @override
  String get ratingsAndReviews => 'Bewertungen und Rezensionen';

  @override
  String reviewCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Bewertungen',
      one: '1 Bewertung',
    );
    return '$_temp0';
  }

  @override
  String get ratingTrend => 'Bewertungstrend – Letzte 7 Tage';

  @override
  String get notEnoughData => 'Noch nicht genügend Daten';

  @override
  String get recentReviews => 'Aktuelle Rezensionen';

  @override
  String get noReviewsYet => 'Noch keine Bewertungen';

  @override
  String get beTheFirstToRate => 'Bewerten Sie dieses Restaurant als Erster!';

  @override
  String get today => 'Heute';

  @override
  String get yesterday => 'Gestern';

  @override
  String daysAgo(Object days) {
    return '${days}d ago';
  }

  @override
  String get unknownCustomer => 'Kunde';

  @override
  String get noData => 'Keine Daten';

  @override
  String get drawerAccount => 'Konto';

  @override
  String get profileSettings => 'Profileinstellungen';

  @override
  String get myOrders => 'Meine Bestellungen';

  @override
  String get favourites => 'Favoriten';

  @override
  String get language => 'Sprache';

  @override
  String get drawerSupport => 'Unterstützung';

  @override
  String get helpFaq => 'Hilfe & FAQ';

  @override
  String get contactUs => 'Kontaktieren Sie uns';

  @override
  String get drawerLegal => 'Recht';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get termsConditions => 'Allgemeine Geschäftsbedingungen';

  @override
  String get signOut => 'Abmelden';

  @override
  String get policyIntroTitle => '1. Einleitung';

  @override
  String get policyIntroBody =>
      'Willkommen bei Freequick. Mit der Nutzung unserer App stimmen Sie diesen Nutzungsbedingungen zu. Bitte lesen Sie diese sorgfältig durch, bevor Sie eine Bestellung aufgeben oder unsere Dienste nutzen.';

  @override
  String get policyDataTitle => '2. Von uns erfasste Daten';

  @override
  String get policyDataBody =>
      'Wir erfassen Informationen, die Sie uns direkt mitteilen, wie beispielsweise Ihren Namen, Ihre E-Mail-Adresse, Ihre Telefonnummer, Ihre Lieferadresse und Ihre Zahlungsinformationen. Wir erfassen außerdem Nutzungsdaten, um unseren Service zu verbessern.';

  @override
  String get policyUsageTitle => '3. Wie wir Ihre Daten verwenden';

  @override
  String get policyUsageBody =>
      'Ihre Daten werden zur Bearbeitung von Bestellungen, zur Benachrichtigung über Bestellaktualisierungen, zur Personalisierung Ihres Nutzererlebnisses und zur Verbesserung unserer Plattform verwendet. Wir verkaufen Ihre personenbezogenen Daten nicht an Dritte.';

  @override
  String get policyRightsTitle => '4. Ihre Rechte';

  @override
  String get policyRightsBody =>
      'Sie haben jederzeit das Recht, Ihre personenbezogenen Daten einzusehen, zu korrigieren oder zu löschen. Ihre Einstellungen können Sie in Ihrem Profil verwalten oder sich an unser Support-Team wenden.';

  @override
  String get policyContactTitle => '5. Kontakt';

  @override
  String get policyContactBody =>
      'Bei Fragen zu dieser Richtlinie kontaktieren Sie uns bitte unter support@freequick.app.';
}
