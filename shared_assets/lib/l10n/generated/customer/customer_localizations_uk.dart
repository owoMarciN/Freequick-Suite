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

  @override
  String get profileSettingsTitle => 'Налаштування профілю';

  @override
  String get noChangesDetected => 'Змін не виявлено.';

  @override
  String get updatingProfile => 'Оновлення профілю...';

  @override
  String get profileUpdatedSuccessfully => 'Профіль успішно оновлено!';

  @override
  String get fullName => 'Повне ім\'я';

  @override
  String get phoneNumber => 'Номер телефону';

  @override
  String get saveChanges => 'Зберегти зміни';

  @override
  String get notificationsSection => 'Сповіщення';

  @override
  String get notificationsSubtitle => 'Виберіть, які сповіщення отримувати';

  @override
  String get notifOrderStatusLabel => 'Оновлення статусу замовлення';

  @override
  String get notifOrderStatusSubtitle =>
      'Сповіщення про зміну статусу вашого замовлення';

  @override
  String get notifPromotionsLabel => 'Акції та пропозиції';

  @override
  String get notifPromotionsSubtitle => 'Знижки та пропозиції від ресторанів';

  @override
  String get notifNearbyLabel => 'Нові ресторани поблизу';

  @override
  String get notifNearbySubtitle =>
      'Коли у вашому районі відкривається новий ресторан';

  @override
  String get notifAppNewsLabel => 'Новини та оновлення додатків';

  @override
  String get notifAppNewsSubtitle =>
      'Оголошення функцій та новини про програми';

  @override
  String get appearanceSection => 'Зовнішній вигляд';

  @override
  String get darkModeLabel => 'Темний режим';

  @override
  String get darkModeSubtitle => 'Переключитися на темну тему';

  @override
  String get accountSection => 'Обліковий запис';

  @override
  String get accountSecurityLabel => 'Безпека облікового запису';

  @override
  String get accountSecuritySubtitle => 'Зміна пароля, налаштування 2FA';

  @override
  String get deleteAccountLabel => 'Видалити обліковий запис';

  @override
  String get deleteAccountSubtitle =>
      'Остаточне видалення облікового запису та даних';

  @override
  String comingSoon(Object feature) {
    return '$feature — скоро!';
  }

  @override
  String get deleteAccountDialogTitle => 'Видалити обліковий запис';

  @override
  String get deleteAccountDialogContent =>
      'Це назавжди видалить ваш обліковий запис і всі ваші дані. Цю дію не можна скасувати.';

  @override
  String get cancel => 'Скасувати';

  @override
  String get delete => 'Видалити';

  @override
  String get personalInformationSection => 'Персональна інформація';

  @override
  String get cartScreenTitle => 'Кошик для покупок';

  @override
  String get errorLoadingCart => 'Помилка завантаження кошика';

  @override
  String get addItemsToGetStarted => 'Додайте елементи, щоб розпочати';

  @override
  String get originalTotal => 'Початкова сума:';

  @override
  String get youSave => 'Ви економите:';

  @override
  String get total => 'Всього:';

  @override
  String get clearCart => 'Очистити кошик';

  @override
  String get proceedToCheckout => 'Перейти до оформлення замовлення';

  @override
  String get favoritesTitle => 'Улюблені';

  @override
  String get errorLoadingFavorites => 'Помилка завантаження обраного';

  @override
  String get noFavoritesYet => 'Поки що немає улюблених';

  @override
  String get noFavoritesSubtitle =>
      'Натисніть значок серця на будь-якому елементі, щоб зберегти його тут';

  @override
  String get topRestaurantsTitle => 'Найкращі ресторани';

  @override
  String get inTheSpotlightSubtitle => 'Усі відкриті ресторани';

  @override
  String get offersAndPromotions => 'Пропозиції та акції';

  @override
  String get promotionsLive => 'Живий';

  @override
  String get orderAgainTitle => 'Замовити ще раз';

  @override
  String get promotionBannerPlaceholder => 'Тут відображаються рекламні банери';

  @override
  String get noActivePromotions => 'Наразі немає активних акцій';

  @override
  String get restaurantsDisplayedHere => 'Тут відображаються ресторани';

  @override
  String get noRestaurantsOpen => 'Зараз немає відкритих ресторанів';

  @override
  String get unknownRestaurant => 'Ресторан';

  @override
  String get navHome => 'Дім';

  @override
  String get navOrders => 'Замовлення';

  @override
  String get navSearch => 'Пошук';

  @override
  String get navFavorites => 'Улюблені';

  @override
  String get notificationsTitle => 'Сповіщення';

  @override
  String get noNotifications => 'Немає сповіщень';

  @override
  String get allCaughtUp => 'Ви все встигли!';

  @override
  String unreadCount(int count) {
    return '$count непрочитані';
  }

  @override
  String get markAllAsRead => 'Позначити всі як прочитані';

  @override
  String get timeJustNow => 'Щойно';

  @override
  String timeMinutesAgo(int count) {
    return '$countхв тому';
  }

  @override
  String timeHoursAgo(int count) {
    return '$countгод тому';
  }

  @override
  String get timeYesterday => 'Вчора';

  @override
  String timeDaysAgo(int count) {
    return '$countднів тому';
  }

  @override
  String get searchTitle => 'Пошук!';

  @override
  String get searchHint => 'Пошук ресторанів або товарів...';

  @override
  String searchResultCount(int count, int ms) {
    return '$count результатів ($msмс)';
  }

  @override
  String get searchSearching => 'Пошук...';

  @override
  String searchError(String message) {
    return 'Помилка: $message';
  }

  @override
  String get searchRetry => 'Повторити спробу';

  @override
  String get searchNoResults => 'Результатів не знайдено';

  @override
  String get searchTypeItem => 'Елемент';

  @override
  String get searchTypeRestaurant => 'Ресторан';

  @override
  String get searchItemIdMissing => 'Ідентифікатор елемента відсутній';

  @override
  String get searchRestaurantIdMissing => 'Немає ідентифікатора ресторану';

  @override
  String get searchFiltersTitle => 'Фільтри';

  @override
  String get searchFilterResetAll => 'Скинути все';

  @override
  String get searchFilterCategories => 'Категорії';

  @override
  String get searchFilterNames => 'Імена';

  @override
  String searchFilterPriceRange(int min, int max) {
    return 'Ціновий діапазон: $min - $max злотих';
  }

  @override
  String get searchFilterApply => 'Застосувати фільтри';

  @override
  String orderIdMessage(String id) {
    return 'Замовлення №$id';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count предметів',
      one: '1 товар',
    );
    return '$_temp0';
  }

  @override
  String quantityMessage(int qty) {
    return 'Кількість: $qty';
  }

  @override
  String get viewDetails => 'Переглянути деталі';

  @override
  String currencyFormat(String price) {
    return '$priceзлоти';
  }

  @override
  String deliveryTime(String min, String max) {
    return '$min–$max хв';
  }

  @override
  String get freeDelivery => 'Безкоштовна доставка';

  @override
  String get newStatus => 'Новий';

  @override
  String discountPercent(int percent) {
    return 'ЗНИЖКА$percent%';
  }

  @override
  String saveAmount(String amount) {
    return 'Зберегти $amount злотих';
  }

  @override
  String get removeItemTitle => 'Видалити елемент';

  @override
  String removeItemConfirm(String item) {
    return 'Ви впевнені, що хочете видалити $item з кошика?';
  }

  @override
  String get remove => 'Видалити';

  @override
  String get itemRemoved => 'Товар видалено з кошика';

  @override
  String get errorInvalidId =>
      'Неможливо видалити елемент: Недійсний ідентифікатор елемента';

  @override
  String get details => 'Деталі';

  @override
  String discountValue(String percent) {
    return '-$percent%';
  }

  @override
  String get untitledMenu => 'Меню без назви';

  @override
  String get browse => 'Переглянути';

  @override
  String get recipientName => 'Ім\'я одержувача';

  @override
  String get noPhoneNumber => 'Без номера телефону';

  @override
  String get deliveryAddress => 'Адреса доставки';

  @override
  String get addressNotSpecified => 'Адреса не вказана';

  @override
  String get rateOrderTitle => 'Оцініть своє замовлення';

  @override
  String get skip => 'Пропустити';

  @override
  String get foodQuality => 'Якість харчових продуктів';

  @override
  String get deliveryDriver => 'Водій доставки';

  @override
  String get leaveCommentHint => 'Залиште коментар (необов\'язково)...';

  @override
  String get submitRating => 'Надіслати оцінку';

  @override
  String get thanksFeedback => 'Дякуємо за ваш відгук!';

  @override
  String get ratingValidation => 'Будь ласка, оцініть і їжу, і водія.';

  @override
  String errorOccurred(Object error) {
    return 'Помилка: $error';
  }

  @override
  String get ratingsAndReviews => 'Рейтинги та відгуки';

  @override
  String reviewCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count відгуків',
      one: '1 відгук',
    );
    return '$_temp0';
  }

  @override
  String get ratingTrend => 'Тенденція рейтингу — останні 7 днів';

  @override
  String get notEnoughData => 'Ще недостатньо даних';

  @override
  String get recentReviews => 'Недавні відгуки';

  @override
  String get noReviewsYet => 'Поки що немає відгуків';

  @override
  String get beTheFirstToRate => 'Будьте першим, хто оцінить цей ресторан';

  @override
  String get today => 'Сьогодні';

  @override
  String get yesterday => 'Вчора';

  @override
  String daysAgo(Object days) {
    return '$daysднів тому';
  }

  @override
  String get unknownCustomer => 'Клієнт';

  @override
  String get noData => 'Немає даних';

  @override
  String get drawerAccount => 'Обліковий запис';

  @override
  String get profileSettings => 'Налаштування профілю';

  @override
  String get myOrders => 'Мої замовлення';

  @override
  String get favourites => 'Улюблені';

  @override
  String get language => 'Мова';

  @override
  String get drawerSupport => 'Підтримка';

  @override
  String get helpFaq => 'Довідка та поширені запитання';

  @override
  String get contactUs => 'Зв\'яжіться з нами';

  @override
  String get drawerLegal => 'Юридичні';

  @override
  String get privacyPolicy => 'Політика конфіденційності';

  @override
  String get termsConditions => 'Умови та положення';

  @override
  String get signOut => 'Вийти';

  @override
  String get policyIntroTitle => '1. Вступ';

  @override
  String get policyIntroBody =>
      'Ласкаво просимо до Freequick. Використовуючи наш додаток, ви погоджуєтеся з цими умовами. Будь ласка, уважно прочитайте їх, перш ніж розміщувати замовлення або користуватися будь-якими з наших послуг.';

  @override
  String get policyDataTitle => '2. Дані, які ми збираємо';

  @override
  String get policyDataBody =>
      'Ми збираємо інформацію, яку ви надаєте безпосередньо, таку як ваше ім\'я, адресу електронної пошти, номер телефону, адресу доставки та платіжну інформацію. Ми також збираємо дані про використання для покращення нашого сервісу.';

  @override
  String get policyUsageTitle => '3. Як ми використовуємо ваші дані';

  @override
  String get policyUsageBody =>
      'Ваші дані використовуються для обробки замовлень, повідомлення про оновлення замовлень, персоналізації вашого досвіду та покращення нашої платформи. Ми не продаємо ваші персональні дані третім сторонам.';

  @override
  String get policyRightsTitle => '4. Ваші права';

  @override
  String get policyRightsBody =>
      'Ви маєте право доступу, виправлення або видалення своїх персональних даних у будь-який час. Ви можете керувати своїми налаштуваннями в налаштуваннях профілю або зв’язатися з нашою службою підтримки.';

  @override
  String get policyContactTitle => '5. Контакт';

  @override
  String get policyContactBody =>
      'Якщо у вас є запитання щодо цієї політики, зв’яжіться з нами за адресою support@freequick.app.';
}
