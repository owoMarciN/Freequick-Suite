// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'customer_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class CustomerLocalizationsPl extends CustomerLocalizations {
  CustomerLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get welcomeNotifTitle =>
      'Witaj, dziękujemy za dołączenie do Freequick! 🍔';

  @override
  String welcomeNotifBody(String name) {
    return 'Cześć $name, Twoje konto jest gotowe. Zacznij odkrywać pyszne dania w Twojej okolicy!';
  }

  @override
  String get errorBlockedAccount =>
      'Twoje konto zostało zablokowane lub nie jest kontem klienta. Skontaktuj się z pomocą techniczną.';

  @override
  String get suggestedMatch => 'Sugerowane dopasowanie';

  @override
  String get confirmContinue => 'Potwierdź i kontynuuj';

  @override
  String get refreshLocation => 'Odśwież lokalizację';

  @override
  String get tabFoodDelivery => 'Dostawa jedzenia';

  @override
  String get tabPickup => 'Ulec poprawie';

  @override
  String get tabGroceryShopping => 'Artykuły spożywcze';

  @override
  String get tabGifting => 'Obdarowywanie';

  @override
  String get tabBenefits => 'Korzyści';

  @override
  String get orderAgain => 'Zamów ponownie';

  @override
  String get orderAgainSubtitle => 'Na podstawie Twoich ostatnich ulubionych';

  @override
  String get topRestaurants => 'Najlepsze restauracje';

  @override
  String get topRestaurantsSubtitle => 'Wysoko oceniane w Twojej okolicy';

  @override
  String get whatsOnYourMind => 'O czym myślisz?';

  @override
  String get inTheSpotlight => 'W centrum uwagi';

  @override
  String get allOpenRestaurants => 'Wszystkie otwarte restauracje';

  @override
  String get errorLoadingRestaurants => 'Błąd ładowania restauracji';

  @override
  String seeMore(String category) {
    return 'Zobacz więcej $category';
  }

  @override
  String seeLess(String category) {
    return 'Zobacz mniej $category';
  }

  @override
  String get fav_pleaseLoginFor => 'Zaloguj się, aby dodać ulubione';

  @override
  String get fav_removed => 'Usunięto z ulubionych';

  @override
  String get fav_added => 'Dodano do ulubionych';

  @override
  String get fav_error_update => 'Błąd podczas aktualizacji ulubionych';

  @override
  String get paymentNotCompleted => 'Płatność nie została zrealizowana';

  @override
  String get paymentCancelled => 'Płatność anulowana';

  @override
  String paymentFailed(String error) {
    return 'Płatność nie powiodła się: $error';
  }

  @override
  String get categoryDiscounts => 'Rabaty';

  @override
  String get categoryPork => 'Wieprzowina';

  @override
  String get categoryTonkatsuSashimi => 'Tonkatsu i Sashimi';

  @override
  String get categoryPizza => 'Pizza';

  @override
  String get categoryStew => 'Gulasz';

  @override
  String get categoryChinese => 'chiński';

  @override
  String get categoryChicken => 'Kurczak';

  @override
  String get categoryKorean => 'koreański';

  @override
  String get categoryOneBowl => 'Posiłki z jednej miski';

  @override
  String get categoryPichupDiscount => 'Rabat za odbiór osobisty';

  @override
  String get categoryFastFood => 'Fast food';

  @override
  String get categoryCoffee => 'Kawa i deser';

  @override
  String get categoryBakery => 'Piekarnia';

  @override
  String get categoryLunch => 'Lunch Specjalny';

  @override
  String get categoryFreshProduce => 'Świeże produkty';

  @override
  String get categoryDairyEggs => 'Nabiał i jaja';

  @override
  String get categoryMeat => 'Mięso';

  @override
  String get categoryBeverages => 'Napoje';

  @override
  String get categoryFrozen => 'Mrożonki';

  @override
  String get categorySnacks => 'Przekąski i słodycze';

  @override
  String get categoryHousehold => 'Artykuły gospodarstwa domowego';

  @override
  String get categoryCakes => 'Ciasta';

  @override
  String get categoryFlowers => 'Kwiaty';

  @override
  String get categoryGiftBoxes => 'Pudełka prezentowe';

  @override
  String get categoryPartySupplies => 'Artykuły imprezowe';

  @override
  String get categoryGiftCards => 'Karty podarunkowe';

  @override
  String get categorySpecialOccasions => 'Specjalne okazje';

  @override
  String get categoryDailyDeals => 'Oferty dnia';

  @override
  String get categoryLoyaltyRewards => 'Nagrody za lojalność';

  @override
  String get categoryCoupons => 'Moje kupony';

  @override
  String get categoryNewOffers => 'Nowe oferty';

  @override
  String get categoryExclusiveDeals => 'Ekskluzywne oferty';

  @override
  String get jalebi => 'Dżalebi';

  @override
  String get kajuBarfi => 'Kaju Barfi';

  @override
  String get gulabJamun => 'Gulab Jamun';

  @override
  String get softDrinks => 'Napoje bezalkoholowe';

  @override
  String get laddoo => 'Laddoo';

  @override
  String get shake => 'Potrząsnąć';

  @override
  String get pastries => 'Ciastka';

  @override
  String get momos => 'Momos';

  @override
  String get chocolate => 'Czekolada';

  @override
  String get pizza => 'Pizza';

  @override
  String get cartItemAdded => 'Produkt został dodany do koszyka.';

  @override
  String get cartItemRemoved => 'Pozycja została usunięta z koszyka.';

  @override
  String get cartCleared => 'Twój koszyk został wyczyszczony.';

  @override
  String get cartAlreadyEmpty => 'Twój koszyk jest już pusty.';

  @override
  String get cartMaxQuantityReached =>
      'Osiągnięto maksymalną ilość tego produktu.';

  @override
  String get cartSingleRestaurantError =>
      'Możesz składać zamówienia tylko w jednej restauracji na raz.';

  @override
  String get cartItemNotFound => 'Nie znaleziono produktu w koszyku.';

  @override
  String get customerOrderHistory => 'Moje zamówienia';

  @override
  String get orderPlacedSuccess =>
      'Twoje zamówienie zostało złożone pomyślnie.';

  @override
  String get orderCancelledSuccess => 'Twoje zamówienie zostało anulowane.';

  @override
  String get addressManager => 'Menedżer adresów';

  @override
  String get addNewAddress => 'Dodaj nowy adres';

  @override
  String get noAddressesYet => 'Brak adresów';

  @override
  String get addDeliveryAddressHint =>
      'Dodaj adres dostawy, aby rozpocząć składanie zamówień.';

  @override
  String get itemNotFound => 'Element nie znaleziony';

  @override
  String get unknownItem => 'Nieznany przedmiot';

  @override
  String get description => 'Opis';

  @override
  String get noDescription => 'Brak opisu';

  @override
  String get quantity => 'Ilość';

  @override
  String addToCartTotal(Object total) {
    return 'Dodaj do koszyka - ${total}zł';
  }

  @override
  String get menuNotFound => 'Menu nie znaleziono';

  @override
  String get noItemsFound => 'Nie znaleziono żadnych pozycji w tym menu.';

  @override
  String get profileSettingsTitle => 'Ustawienia profilu';

  @override
  String get noChangesDetected => 'Nie wykryto żadnych zmian.';

  @override
  String get updatingProfile => 'Aktualizowanie profilu...';

  @override
  String get profileUpdatedSuccessfully => 'Profil zaktualizowano pomyślnie!';

  @override
  String get fullName => 'Pełne imię i nazwisko';

  @override
  String get phoneNumber => 'Numer telefonu';

  @override
  String get saveChanges => 'Zapisz zmiany';

  @override
  String get notificationsSection => 'Powiadomienia';

  @override
  String get notificationsSubtitle =>
      'Wybierz powiadomienia, które chcesz otrzymywać';

  @override
  String get notifOrderStatusLabel => 'Aktualizacje statusu zamówienia';

  @override
  String get notifOrderStatusSubtitle =>
      'Powiadomienie o zmianie statusu Twojego zamówienia';

  @override
  String get notifPromotionsLabel => 'Promocje i oferty';

  @override
  String get notifPromotionsSubtitle => 'Zniżki i promocje w restauracjach';

  @override
  String get notifNearbyLabel => 'Nowe restauracje w pobliżu';

  @override
  String get notifNearbySubtitle =>
      'Kiedy w Twojej okolicy otwiera się nowa restauracja';

  @override
  String get notifAppNewsLabel => 'Aktualności i aktualizacje aplikacji';

  @override
  String get notifAppNewsSubtitle => 'Ogłoszenia funkcji i nowości aplikacji';

  @override
  String get appearanceSection => 'Wygląd';

  @override
  String get darkModeLabel => 'Tryb ciemny';

  @override
  String get darkModeSubtitle => 'Przełącz na ciemny motyw';

  @override
  String get accountSection => 'Konto';

  @override
  String get accountSecurityLabel => 'Bezpieczeństwo konta';

  @override
  String get accountSecuritySubtitle => 'Zmień hasło, ustawienia 2FA';

  @override
  String get deleteAccountLabel => 'Usuń konto';

  @override
  String get deleteAccountSubtitle => 'Trwale usuń swoje konto i dane';

  @override
  String comingSoon(Object feature) {
    return '$feature — już wkrótce!';
  }

  @override
  String get deleteAccountDialogTitle => 'Usuń konto';

  @override
  String get deleteAccountDialogContent =>
      'Spowoduje to trwałe usunięcie Twojego konta i wszystkich Twoich danych. Tej czynności nie można cofnąć.';

  @override
  String get cancel => 'Anulować';

  @override
  String get delete => 'Usuwać';

  @override
  String get personalInformationSection => 'Informacje osobiste';

  @override
  String get cartScreenTitle => 'Koszyk';

  @override
  String get errorLoadingCart => 'Błąd ładowania koszyka';

  @override
  String get addItemsToGetStarted => 'Dodaj elementy, aby rozpocząć';

  @override
  String get originalTotal => 'Suma oryginalna:';

  @override
  String get youSave => 'Oszczędzasz:';

  @override
  String get total => 'Całkowity:';

  @override
  String get clearCart => 'Wyczyść koszyk';

  @override
  String get proceedToCheckout => 'Przejdź do kasy';

  @override
  String get favoritesTitle => 'Ulubione';

  @override
  String get errorLoadingFavorites => 'Błąd ładowania ulubionych';

  @override
  String get noFavoritesYet => 'Brak ulubionych';

  @override
  String get noFavoritesSubtitle =>
      'Kliknij ikonę serca na dowolnym elemencie, aby go tutaj zapisać';

  @override
  String get topRestaurantsTitle => 'Najlepsze restauracje';

  @override
  String get inTheSpotlightSubtitle => 'Wszystkie otwarte restauracje';

  @override
  String get offersAndPromotions => 'Oferty i promocje';

  @override
  String get promotionsLive => 'Na żywo';

  @override
  String get orderAgainTitle => 'Zamów ponownie';

  @override
  String get promotionBannerPlaceholder =>
      'Tutaj wyświetlane są banery promocyjne';

  @override
  String get noActivePromotions => 'Brak aktywnych promocji w tej chwili';

  @override
  String get restaurantsDisplayedHere => 'Tutaj wyświetlane są restauracje';

  @override
  String get noRestaurantsOpen =>
      'W tej chwili żadna restauracja nie jest otwarta';

  @override
  String get unknownRestaurant => 'Restauracja';

  @override
  String get navHome => 'Dom';

  @override
  String get navOrders => 'Święcenia';

  @override
  String get navSearch => 'Szukaj';

  @override
  String get navFavorites => 'Ulubione';

  @override
  String get notificationsTitle => 'Powiadomienia';

  @override
  String get noNotifications => 'Brak powiadomień';

  @override
  String get allCaughtUp => 'Wszyscy jesteście na bieżąco!';

  @override
  String unreadCount(int count) {
    return '$count nieprzeczytane';
  }

  @override
  String get markAllAsRead => 'Oznacz wszystkie jako przeczytane';

  @override
  String get timeJustNow => 'Właśnie';

  @override
  String timeMinutesAgo(int count) {
    return '${count}m temu';
  }

  @override
  String timeHoursAgo(int count) {
    return '${count}godz. temu';
  }

  @override
  String get timeYesterday => 'Wczoraj';

  @override
  String timeDaysAgo(int count) {
    return '${count}dni temu';
  }

  @override
  String get searchTitle => 'Szukaj!';

  @override
  String get searchHint => 'Wyszukaj restauracje lub produkty...';

  @override
  String searchResultCount(int count, int ms) {
    return '$count wyników (${ms}ms)';
  }

  @override
  String get searchSearching => 'Badawczy...';

  @override
  String searchError(String message) {
    return 'Błąd: $message';
  }

  @override
  String get searchRetry => 'Spróbować ponownie';

  @override
  String get searchNoResults => 'Nie znaleziono wyników';

  @override
  String get searchTypeItem => 'Przedmiot';

  @override
  String get searchTypeRestaurant => 'Restauracja';

  @override
  String get searchItemIdMissing => 'Brak identyfikatora przedmiotu';

  @override
  String get searchRestaurantIdMissing => 'Brak identyfikatora restauracji';

  @override
  String get searchFiltersTitle => 'Filtry';

  @override
  String get searchFilterResetAll => 'Zresetuj wszystko';

  @override
  String get searchFilterCategories => 'Kategorie';

  @override
  String get searchFilterNames => 'Nazwy';

  @override
  String searchFilterPriceRange(int min, int max) {
    return 'Zakres cen: $min - $max zł';
  }

  @override
  String get searchFilterApply => 'Zastosuj filtry';

  @override
  String orderIdMessage(String id) {
    return 'Zamówienie nr$id';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementów',
      one: '1 pozycja',
    );
    return '$_temp0';
  }

  @override
  String quantityMessage(int qty) {
    return 'Ilość: $qty';
  }

  @override
  String get viewDetails => 'Zobacz szczegóły';

  @override
  String currencyFormat(String price) {
    return '${price}zł';
  }

  @override
  String deliveryTime(String min, String max) {
    return '$min–$max minut';
  }

  @override
  String get freeDelivery => 'Darmowa dostawa';

  @override
  String get newStatus => 'Nowy';

  @override
  String discountPercent(int percent) {
    return '$percent% zniżki';
  }

  @override
  String saveAmount(String amount) {
    return 'Oszczędź $amount zł';
  }

  @override
  String get removeItemTitle => 'Usuń element';

  @override
  String removeItemConfirm(String item) {
    return 'Czy na pewno chcesz usunąć $item z koszyka?';
  }

  @override
  String get remove => 'Usunąć';

  @override
  String get itemRemoved => 'Pozycja usunięta z koszyka';

  @override
  String get errorInvalidId =>
      'Nie można usunąć elementu: nieprawidłowy identyfikator elementu';

  @override
  String get details => 'Bliższe dane';

  @override
  String discountValue(String percent) {
    return '-$percent%';
  }

  @override
  String get untitledMenu => 'Menu bez tytułu';

  @override
  String get browse => 'Przeglądać';

  @override
  String get recipientName => 'Nazwa odbiorcy';

  @override
  String get noPhoneNumber => 'Brak numeru telefonu';

  @override
  String get deliveryAddress => 'Adres dostawy';

  @override
  String get addressNotSpecified => 'Adres nie został określony';

  @override
  String get rateOrderTitle => 'Oceń swoje zamówienie';

  @override
  String get skip => 'Pominąć';

  @override
  String get foodQuality => 'Jakość żywności';

  @override
  String get deliveryDriver => 'Kierowca dostawczy';

  @override
  String get leaveCommentHint => 'Zostaw komentarz (opcjonalnie)...';

  @override
  String get submitRating => 'Prześlij ocenę';

  @override
  String get thanksFeedback => 'Dziękujemy za opinię!';

  @override
  String get ratingValidation =>
      'Proszę ocenić zarówno jedzenie, jak i kierowcę.';

  @override
  String errorOccurred(Object error) {
    return 'Błąd: $error';
  }

  @override
  String get ratingsAndReviews => 'Oceny i recenzje';

  @override
  String reviewCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count recenzji',
      one: '1 recenzja',
    );
    return '$_temp0';
  }

  @override
  String get ratingTrend => 'Trend ocen — ostatnie 7 dni';

  @override
  String get notEnoughData => 'Za mało danych';

  @override
  String get recentReviews => 'Ostatnie recenzje';

  @override
  String get noReviewsYet => 'Brak recenzji';

  @override
  String get beTheFirstToRate => 'Oceń tę restaurację jako pierwszy';

  @override
  String get today => 'Dzisiaj';

  @override
  String get yesterday => 'Wczoraj';

  @override
  String daysAgo(Object days) {
    return '${days}dni temu';
  }

  @override
  String get unknownCustomer => 'Klient';

  @override
  String get noData => 'Brak danych';

  @override
  String get drawerAccount => 'Konto';

  @override
  String get profileSettings => 'Ustawienia profilu';

  @override
  String get myOrders => 'Moje zamówienia';

  @override
  String get favourites => 'Ulubione';

  @override
  String get language => 'Język';

  @override
  String get drawerSupport => 'Wsparcie';

  @override
  String get helpFaq => 'Pomoc i FAQ';

  @override
  String get contactUs => 'Skontaktuj się z nami';

  @override
  String get drawerLegal => 'Prawny';

  @override
  String get privacyPolicy => 'Polityka prywatności';

  @override
  String get termsConditions => 'Warunki korzystania';

  @override
  String get signOut => 'Wyloguj się';

  @override
  String get policyIntroTitle => '1. Wprowadzenie';

  @override
  String get policyIntroBody =>
      'Witamy w Freequick. Korzystając z naszej aplikacji, akceptujesz niniejszy regulamin. Prosimy o uważne zapoznanie się z nim przed złożeniem zamówienia lub skorzystaniem z naszych usług.';

  @override
  String get policyDataTitle => '2. Gromadzone przez nas dane';

  @override
  String get policyDataBody =>
      'Gromadzimy informacje, które podajesz bezpośrednio, takie jak imię i nazwisko, adres e-mail, numer telefonu, adres dostawy i dane dotyczące płatności. Gromadzimy również dane dotyczące użytkowania, aby ulepszać nasze usługi.';

  @override
  String get policyUsageTitle => '3. Jak wykorzystujemy Twoje dane';

  @override
  String get policyUsageBody =>
      'Twoje dane są wykorzystywane do przetwarzania zamówień, przesyłania aktualizacji zamówień, personalizacji Twoich doświadczeń i ulepszania naszej platformy. Nie sprzedajemy Twoich danych osobowych osobom trzecim.';

  @override
  String get policyRightsTitle => '4. Twoje prawa';

  @override
  String get policyRightsBody =>
      'Masz prawo dostępu, poprawiania lub usuwania swoich danych osobowych w dowolnym momencie. Możesz zarządzać swoimi preferencjami w Ustawieniach profilu lub skontaktować się z naszym zespołem wsparcia.';

  @override
  String get policyContactTitle => '5. Kontakt';

  @override
  String get policyContactBody =>
      'Jeśli masz pytania dotyczące tej polityki, skontaktuj się z nami pod adresem support@freequick.app.';
}
