// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'customer_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class CustomerLocalizationsUk extends CustomerLocalizations {
  CustomerLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get welcomeNotifTitle =>
      'Ласкаво просимо, дякуємо, що приєдналися до Freequick! 🍔';

  @override
  String welcomeNotifBody(String name) {
    return 'Привіт, $name, твій обліковий запис готовий. Почни досліджувати смачні страви поруч із тобою!';
  }

  @override
  String get errorBlockedAccount =>
      'Ваш обліковий запис заблоковано або він не є обліковим записом клієнта. Зверніться до служби підтримки.';

  @override
  String get suggestedMatch => 'Пропонований збіг';

  @override
  String get confirmContinue => 'Підтвердити та продовжити';

  @override
  String get refreshLocation => 'Оновити місцезнаходження';

  @override
  String get tabFoodDelivery => 'Доставка їжі';

  @override
  String get tabPickup => 'Самовивіз';

  @override
  String get tabGroceryShopping => 'Бакалія';

  @override
  String get tabGifting => 'Дарування';

  @override
  String get tabBenefits => 'Переваги';

  @override
  String get orderAgain => 'Замовити ще раз';

  @override
  String get orderAgainSubtitle => 'На основі ваших нещодавніх улюблених';

  @override
  String get topRestaurants => 'Найкращі ресторани';

  @override
  String get topRestaurantsSubtitle => 'Високий рейтинг поруч з вами';

  @override
  String get whatsOnYourMind => 'Що у тебе на думці?';

  @override
  String get inTheSpotlight => 'У центрі уваги';

  @override
  String get allOpenRestaurants => 'Усі відкриті ресторани';

  @override
  String get errorLoadingRestaurants => 'Помилка завантаження ресторанів';

  @override
  String seeMore(String category) {
    return 'Дивитися більше $category';
  }

  @override
  String seeLess(String category) {
    return 'Показати менше $category';
  }

  @override
  String get fav_pleaseLoginFor =>
      'Будь ласка, увійдіть, щоб додати до обраного';

  @override
  String get fav_removed => 'Видалено з обраного';

  @override
  String get fav_added => 'Додано до обраного';

  @override
  String get fav_error_update => 'Помилка оновлення обраного';

  @override
  String get paymentNotCompleted => 'Оплату не завершено';

  @override
  String get paymentCancelled => 'Платіж скасовано';

  @override
  String paymentFailed(String error) {
    return 'Платіж не вдалося: $error';
  }

  @override
  String get categoryDiscounts => 'Знижки';

  @override
  String get categoryPork => 'Свинина';

  @override
  String get categoryTonkatsuSashimi => 'Тонкацу і сашимі';

  @override
  String get categoryPizza => 'Піца';

  @override
  String get categoryStew => 'Рагу';

  @override
  String get categoryChinese => 'китайська';

  @override
  String get categoryChicken => 'Курка';

  @override
  String get categoryKorean => 'Корейська';

  @override
  String get categoryOneBowl => 'Страви з однієї миски';

  @override
  String get categoryPichupDiscount => 'Знижка на самовивіз';

  @override
  String get categoryFastFood => 'Фастфуд';

  @override
  String get categoryCoffee => 'Кава та десерт';

  @override
  String get categoryBakery => 'Пекарня';

  @override
  String get categoryLunch => 'Спеціальні пропозиції на обід';

  @override
  String get categoryFreshProduce => 'Свіжі продукти';

  @override
  String get categoryDairyEggs => 'Молочні продукти та яйця';

  @override
  String get categoryMeat => 'М\'ясо';

  @override
  String get categoryBeverages => 'Напої';

  @override
  String get categoryFrozen => 'Заморожені продукти';

  @override
  String get categorySnacks => 'Закуски та солодощі';

  @override
  String get categoryHousehold => 'Необхідні речі для дому';

  @override
  String get categoryCakes => 'Торти';

  @override
  String get categoryFlowers => 'Квіти';

  @override
  String get categoryGiftBoxes => 'Подарункові коробки';

  @override
  String get categoryPartySupplies => 'святкове приладдя';

  @override
  String get categoryGiftCards => 'Подарункові картки';

  @override
  String get categorySpecialOccasions => 'Особливі випадки';

  @override
  String get categoryDailyDeals => 'Щоденні пропозиції';

  @override
  String get categoryLoyaltyRewards => 'Нагороди за лояльність';

  @override
  String get categoryCoupons => 'Мої купони';

  @override
  String get categoryNewOffers => 'Нові пропозиції';

  @override
  String get categoryExclusiveDeals => 'Ексклюзивні пропозиції';

  @override
  String get jalebi => 'Джалебі';

  @override
  String get kajuBarfi => 'Каджу Барфі';

  @override
  String get gulabJamun => 'Гулаб Джамун';

  @override
  String get softDrinks => 'Безалкогольні напої';

  @override
  String get laddoo => 'Ладду';

  @override
  String get shake => 'Струсити';

  @override
  String get pastries => 'Випічка';

  @override
  String get momos => 'Момос';

  @override
  String get chocolate => 'Шоколад';

  @override
  String get pizza => 'Піца';

  @override
  String get cartItemAdded => 'Товар додано до вашого кошика.';

  @override
  String get cartItemRemoved => 'Товар видалено з вашого кошика.';

  @override
  String get cartCleared => 'Ваш кошик очищено.';

  @override
  String get cartAlreadyEmpty => 'Ваш кошик вже порожній.';

  @override
  String get cartMaxQuantityReached =>
      'Ви досягли максимальної кількості для цього товару.';

  @override
  String get cartSingleRestaurantError =>
      'Ви можете замовляти лише з одного ресторану одночасно.';

  @override
  String get cartItemNotFound => 'Товар не знайдено в кошику.';

  @override
  String get customerOrderHistory => 'Мої замовлення';

  @override
  String get orderPlacedSuccess => 'Ваше замовлення успішно оформлено.';

  @override
  String get orderCancelledSuccess => 'Ваше замовлення скасовано.';

  @override
  String get addressManager => 'Менеджер адрес';

  @override
  String get addNewAddress => 'Додати нову адресу';

  @override
  String get noAddressesYet => 'Адрес ще немає';

  @override
  String get addDeliveryAddressHint =>
      'Додайте адресу доставки, щоб почати робити замовлення.';

  @override
  String get itemNotFound => 'Елемент не знайдено';

  @override
  String get unknownItem => 'Невідомий елемент';

  @override
  String get description => 'Опис';

  @override
  String get noDescription => 'Опис недоступний';

  @override
  String get quantity => 'Кількість';

  @override
  String addToCartTotal(Object total) {
    return 'Додати до кошика - ${total}zł';
  }

  @override
  String get menuNotFound => 'Меню не знайдено';

  @override
  String get noItemsFound => 'У цьому меню не знайдено жодного елемента.';
}
