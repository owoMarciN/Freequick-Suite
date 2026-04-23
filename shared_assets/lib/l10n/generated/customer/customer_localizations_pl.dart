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
}
