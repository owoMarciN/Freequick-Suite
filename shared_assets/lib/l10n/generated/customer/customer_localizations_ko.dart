// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'customer_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class CustomerLocalizationsKo extends CustomerLocalizations {
  CustomerLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get welcomeNotifTitle => 'Freequick에 오신 것을 환영합니다! 가입해 주셔서 감사합니다! 🍔';

  @override
  String welcomeNotifBody(String name) {
    return '안녕하세요 $name님, 계정이 생성되었습니다. 지금 바로 주변의 맛있는 음식점을 찾아보세요!';
  }

  @override
  String get errorBlockedAccount =>
      '회원님의 계정이 차단되었거나 고객 계정이 아닙니다. 고객 지원팀에 문의해 주세요.';

  @override
  String get suggestedMatch => '추천 매치';

  @override
  String get confirmContinue => '확인 후 계속 진행';

  @override
  String get refreshLocation => '위치 새로 고침';

  @override
  String get tabFoodDelivery => '음식 배달';

  @override
  String get tabPickup => '찾다';

  @override
  String get tabGroceryShopping => '식료 잡화류';

  @override
  String get tabGifting => '선물하기';

  @override
  String get tabBenefits => '이익';

  @override
  String get orderAgain => '다시 주문하세요';

  @override
  String get orderAgainSubtitle => '최근 즐겨찾기를 기반으로';

  @override
  String get topRestaurants => '최고의 레스토랑';

  @override
  String get topRestaurantsSubtitle => '주변에서 평점이 높은 곳';

  @override
  String get whatsOnYourMind => '무슨 생각을 하고 있나요?';

  @override
  String get inTheSpotlight => '주목받는 인물';

  @override
  String get allOpenRestaurants => '모든 영업 중인 레스토랑';

  @override
  String get errorLoadingRestaurants => '레스토랑 불러오기 오류';

  @override
  String seeMore(String category) {
    return '더 보기 $category';
  }

  @override
  String seeLess(String category) {
    return '자세히 보기 $category';
  }

  @override
  String get fav_pleaseLoginFor => '즐겨찾기를 추가하려면 로그인하세요.';

  @override
  String get fav_removed => '즐겨찾기에서 삭제됨';

  @override
  String get fav_added => '즐겨찾기에 추가됨';

  @override
  String get fav_error_update => '즐겨찾기 업데이트 오류';

  @override
  String get paymentNotCompleted => '결제가 완료되지 않았습니다.';

  @override
  String get paymentCancelled => '결제 취소됨';

  @override
  String paymentFailed(String error) {
    return '결제 실패: $error';
  }

  @override
  String get categoryDiscounts => '할인';

  @override
  String get categoryPork => '돼지고기';

  @override
  String get categoryTonkatsuSashimi => '돈까스 & 사시미';

  @override
  String get categoryPizza => '피자';

  @override
  String get categoryStew => '스튜';

  @override
  String get categoryChinese => '중국인';

  @override
  String get categoryChicken => '닭';

  @override
  String get categoryKorean => '한국인';

  @override
  String get categoryOneBowl => '한 그릇 요리';

  @override
  String get categoryPichupDiscount => '픽업 할인';

  @override
  String get categoryFastFood => '패스트푸드';

  @override
  String get categoryCoffee => '커피 & 디저트';

  @override
  String get categoryBakery => '빵집';

  @override
  String get categoryLunch => '점심 특선';

  @override
  String get categoryFreshProduce => '신선한 농산물';

  @override
  String get categoryDairyEggs => '유제품 및 계란';

  @override
  String get categoryMeat => '고기';

  @override
  String get categoryBeverages => '음료수';

  @override
  String get categoryFrozen => '냉동식품';

  @override
  String get categorySnacks => '스낵 및 과자류';

  @override
  String get categoryHousehold => '생활필수품';

  @override
  String get categoryCakes => '케이크';

  @override
  String get categoryFlowers => '월경';

  @override
  String get categoryGiftBoxes => '선물 상자';

  @override
  String get categoryPartySupplies => '파티 용품';

  @override
  String get categoryGiftCards => '기프트 카드';

  @override
  String get categorySpecialOccasions => '특별한 날';

  @override
  String get categoryDailyDeals => '오늘의 특가 상품';

  @override
  String get categoryLoyaltyRewards => '로열티 보상';

  @override
  String get categoryCoupons => '내 쿠폰';

  @override
  String get categoryNewOffers => '새로운 혜택';

  @override
  String get categoryExclusiveDeals => '독점 할인';

  @override
  String get jalebi => '잘레비';

  @override
  String get kajuBarfi => '카주 바르피';

  @override
  String get gulabJamun => '굴랍 자문';

  @override
  String get softDrinks => '청량음료';

  @override
  String get laddoo => '라두';

  @override
  String get shake => '떨림';

  @override
  String get pastries => '페이스트리';

  @override
  String get momos => '모모스';

  @override
  String get chocolate => '초콜릿';

  @override
  String get pizza => '피자';

  @override
  String get cartItemAdded => '상품이 장바구니에 추가되었습니다.';

  @override
  String get cartItemRemoved => '해당 상품이 장바구니에서 삭제되었습니다.';

  @override
  String get cartCleared => '장바구니가 비워졌습니다.';

  @override
  String get cartAlreadyEmpty => '장바구니가 이미 비어 있습니다.';

  @override
  String get cartMaxQuantityReached => '해당 품목의 구매 수량 제한에 도달했습니다.';

  @override
  String get cartSingleRestaurantError => '한 번에 한 레스토랑에서만 주문할 수 있습니다.';

  @override
  String get cartItemNotFound => '장바구니에 담긴 상품을 찾을 수 없습니다.';

  @override
  String get customerOrderHistory => '내 주문';

  @override
  String get orderPlacedSuccess => '주문이 성공적으로 완료되었습니다.';

  @override
  String get orderCancelledSuccess => '주문이 취소되었습니다.';

  @override
  String get addressManager => '주소 관리자';

  @override
  String get addNewAddress => '새 주소 추가';

  @override
  String get noAddressesYet => '아직 주소가 없습니다.';

  @override
  String get addDeliveryAddressHint => '주문을 시작하려면 배송 주소를 추가하세요.';

  @override
  String get itemNotFound => '해당 상품을 찾을 수 없습니다.';

  @override
  String get unknownItem => '알 수 없는 항목';

  @override
  String get description => '설명';

  @override
  String get noDescription => '설명 없음';

  @override
  String get quantity => '수량';

  @override
  String addToCartTotal(Object total) {
    return '장바구니에 담기 - ${total}zł';
  }

  @override
  String get menuNotFound => '메뉴를 찾을 수 없습니다';

  @override
  String get noItemsFound => '이 메뉴에는 항목이 없습니다.';

  @override
  String get profileSettingsTitle => '프로필 설정';

  @override
  String get noChangesDetected => '변경 사항이 감지되지 않았습니다.';

  @override
  String get updatingProfile => '프로필을 업데이트하는 중...';

  @override
  String get profileUpdatedSuccessfully => '프로필이 성공적으로 업데이트되었습니다!';

  @override
  String get fullName => '성명';

  @override
  String get phoneNumber => '전화 번호';

  @override
  String get saveChanges => '변경 사항 저장';

  @override
  String get notificationsSection => '알림';

  @override
  String get notificationsSubtitle => '받고 싶은 알림을 선택하세요';

  @override
  String get notifOrderStatusLabel => '주문 상태 업데이트';

  @override
  String get notifOrderStatusSubtitle => '주문 상태가 변경될 때 알림을 받습니다.';

  @override
  String get notifPromotionsLabel => '프로모션 및 할인';

  @override
  String get notifPromotionsSubtitle => '레스토랑 할인 및 특가 상품';

  @override
  String get notifNearbyLabel => '근처에 새로 생긴 레스토랑';

  @override
  String get notifNearbySubtitle => '지역에 새로운 레스토랑이 문을 열었을 때';

  @override
  String get notifAppNewsLabel => '앱 뉴스 및 업데이트';

  @override
  String get notifAppNewsSubtitle => '새로운 기능 발표 및 앱 소식';

  @override
  String get appearanceSection => '모습';

  @override
  String get darkModeLabel => '다크 모드';

  @override
  String get darkModeSubtitle => '다크 테마로 전환';

  @override
  String get accountSection => '계정';

  @override
  String get accountSecurityLabel => '계정 보안';

  @override
  String get accountSecuritySubtitle => '비밀번호 변경, 2단계 인증 설정';

  @override
  String get deleteAccountLabel => '계정 삭제';

  @override
  String get deleteAccountSubtitle => '계정과 데이터를 영구적으로 삭제합니다.';

  @override
  String comingSoon(Object feature) {
    return '$feature — 곧 출시됩니다!';
  }

  @override
  String get deleteAccountDialogTitle => '계정 삭제';

  @override
  String get deleteAccountDialogContent =>
      '이렇게 하면 계정과 모든 데이터가 영구적으로 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get personalInformationSection => '개인 정보';

  @override
  String get cartScreenTitle => '쇼핑 카트';

  @override
  String get errorLoadingCart => '장바구니 불러오기 오류';

  @override
  String get addItemsToGetStarted => '시작하려면 항목을 추가하세요';

  @override
  String get originalTotal => '원래 총액:';

  @override
  String get youSave => '절약 금액:';

  @override
  String get total => '총:';

  @override
  String get clearCart => '장바구니 지우기';

  @override
  String get proceedToCheckout => '결제 진행';

  @override
  String get favoritesTitle => '즐겨찾기';

  @override
  String get errorLoadingFavorites => '즐겨찾기 불러오는 중 오류 발생';

  @override
  String get noFavoritesYet => '아직 좋아하는 사람이 없습니다';

  @override
  String get noFavoritesSubtitle => '아무 항목이나 하트 아이콘을 탭하여 여기에 저장하세요.';

  @override
  String get topRestaurantsTitle => '최고의 레스토랑';

  @override
  String get inTheSpotlightSubtitle => '모든 영업 중인 레스토랑';

  @override
  String get offersAndPromotions => '할인 및 프로모션';

  @override
  String get promotionsLive => '살다';

  @override
  String get orderAgainTitle => '다시 주문하세요';

  @override
  String get promotionBannerPlaceholder => '여기에 홍보 배너가 표시되어 있습니다.';

  @override
  String get noActivePromotions => '현재 진행 중인 프로모션이 없습니다.';

  @override
  String get restaurantsDisplayedHere => '레스토랑 목록이 여기에 표시됩니다.';

  @override
  String get noRestaurantsOpen => '지금은 영업하는 식당이 없습니다.';

  @override
  String get unknownRestaurant => '식당';

  @override
  String get navHome => '집';

  @override
  String get navOrders => '명령';

  @override
  String get navSearch => '찾다';

  @override
  String get navFavorites => '즐겨찾기';

  @override
  String get notificationsTitle => '알림';

  @override
  String get noNotifications => '알림 없음';

  @override
  String get allCaughtUp => '이제 모든 내용을 따라잡으셨군요!';

  @override
  String unreadCount(int count) {
    return '$count 읽지 않음';
  }

  @override
  String get markAllAsRead => '모두 읽음으로 표시';

  @override
  String get timeJustNow => '방금';

  @override
  String timeMinutesAgo(int count) {
    return '${count}m 전';
  }

  @override
  String timeHoursAgo(int count) {
    return '$count시간 전';
  }

  @override
  String get timeYesterday => '어제';

  @override
  String timeDaysAgo(int count) {
    return '$count일 전';
  }

  @override
  String get searchTitle => '찾다!';

  @override
  String get searchHint => '레스토랑이나 상품을 검색하세요...';

  @override
  String searchResultCount(int count, int ms) {
    return '$count 결과(${ms}ms)';
  }

  @override
  String get searchSearching => '수색...';

  @override
  String searchError(String message) {
    return '오류: $message';
  }

  @override
  String get searchRetry => '다시 해 보다';

  @override
  String get searchNoResults => '검색 결과가 없습니다.';

  @override
  String get searchTypeItem => '목';

  @override
  String get searchTypeRestaurant => '식당';

  @override
  String get searchItemIdMissing => '품목 ID가 누락되었습니다.';

  @override
  String get searchRestaurantIdMissing => '레스토랑 ID가 누락되었습니다.';

  @override
  String get searchFiltersTitle => '필터';

  @override
  String get searchFilterResetAll => '모두 초기화';

  @override
  String get searchFilterCategories => '카테고리';

  @override
  String get searchFilterNames => '이름';

  @override
  String searchFilterPriceRange(int min, int max) {
    return '가격 범위: $min - $max PLN';
  }

  @override
  String get searchFilterApply => '필터 적용';

  @override
  String orderIdMessage(String id) {
    return '주문 번호 #$id';
  }

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 항목',
      one: '1개 품목',
    );
    return '$_temp0';
  }

  @override
  String quantityMessage(int qty) {
    return '수량: $qty';
  }

  @override
  String get viewDetails => '상세 정보 보기';

  @override
  String currencyFormat(String price) {
    return '${price}zł';
  }

  @override
  String deliveryTime(String min, String max) {
    return '$min–$max분';
  }

  @override
  String get freeDelivery => '무료 배송';

  @override
  String get newStatus => '새로운';

  @override
  String discountPercent(int percent) {
    return '$percent% 할인';
  }

  @override
  String saveAmount(String amount) {
    return '$amount zł 저장';
  }

  @override
  String get removeItemTitle => '제거 항목';

  @override
  String removeItemConfirm(String item) {
    return '장바구니에서 $item를 정말로 삭제하시겠습니까?';
  }

  @override
  String get remove => '제거하다';

  @override
  String get itemRemoved => '장바구니에서 상품이 삭제되었습니다.';

  @override
  String get errorInvalidId => '항목을 삭제할 수 없습니다: 잘못된 항목 ID입니다.';

  @override
  String get details => '세부';

  @override
  String discountValue(String percent) {
    return '-$percent%';
  }

  @override
  String get untitledMenu => '제목 없는 메뉴';

  @override
  String get browse => '먹다';

  @override
  String get recipientName => '수신자 이름';

  @override
  String get noPhoneNumber => '전화번호 없음';

  @override
  String get deliveryAddress => '배송 주소';

  @override
  String get addressNotSpecified => '주소가 지정되지 않았습니다';

  @override
  String get rateOrderTitle => '주문 내역을 평가해 주세요';

  @override
  String get skip => '건너뛰다';

  @override
  String get foodQuality => '식품 품질';

  @override
  String get deliveryDriver => '배달 기사';

  @override
  String get leaveCommentHint => '댓글을 남겨주세요 (선택 사항)...';

  @override
  String get submitRating => '평가 제출';

  @override
  String get thanksFeedback => '피드백 주셔서 감사합니다!';

  @override
  String get ratingValidation => '음식과 운전기사 모두 평가해 주세요.';

  @override
  String errorOccurred(Object error) {
    return '오류: $error';
  }

  @override
  String get ratingsAndReviews => '평점 및 리뷰';

  @override
  String reviewCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 리뷰',
      one: '리뷰 1개',
    );
    return '$_temp0';
  }

  @override
  String get ratingTrend => '평점 추세 - 최근 7일';

  @override
  String get notEnoughData => '아직 데이터가 충분하지 않습니다.';

  @override
  String get recentReviews => '최근 리뷰';

  @override
  String get noReviewsYet => '아직 리뷰가 없습니다.';

  @override
  String get beTheFirstToRate => '이 레스토랑에 대한 첫 번째 리뷰를 남겨주세요';

  @override
  String get today => '오늘';

  @override
  String get yesterday => '어제';

  @override
  String daysAgo(Object days) {
    return '$days일 전';
  }

  @override
  String get unknownCustomer => '고객';

  @override
  String get noData => '데이터 없음';

  @override
  String get drawerAccount => '계정';

  @override
  String get profileSettings => '프로필 설정';

  @override
  String get myOrders => '내 주문';

  @override
  String get favourites => '즐겨찾기';

  @override
  String get language => '언어';

  @override
  String get drawerSupport => '지원하다';

  @override
  String get helpFaq => '도움말 및 FAQ';

  @override
  String get contactUs => '문의하기';

  @override
  String get drawerLegal => '합법적인';

  @override
  String get privacyPolicy => '개인정보 보호정책';

  @override
  String get termsConditions => '이용약관';

  @override
  String get signOut => '로그아웃';

  @override
  String get policyIntroTitle => '1. 서론';

  @override
  String get policyIntroBody =>
      '프리퀵에 오신 것을 환영합니다. 저희 앱을 이용하시면 다음 약관에 동의하시는 것으로 간주됩니다. 주문 또는 서비스 이용 전에 약관을 주의 깊게 읽어주시기 바랍니다.';

  @override
  String get policyDataTitle => '2. 수집하는 데이터';

  @override
  String get policyDataBody =>
      '당사는 귀하가 직접 제공하는 이름, 이메일 주소, 전화번호, 배송 주소 및 결제 정보와 같은 정보를 수집합니다. 또한 서비스 개선을 위해 사용 데이터를 수집합니다.';

  @override
  String get policyUsageTitle => '3. 당사가 귀하의 데이터를 사용하는 방법';

  @override
  String get policyUsageBody =>
      '고객님의 데이터는 주문 처리, 주문 업데이트 안내, 맞춤형 서비스 제공 및 플랫폼 개선에 사용됩니다. 당사는 고객님의 개인 데이터를 제3자에게 판매하지 않습니다.';

  @override
  String get policyRightsTitle => '4. 귀하의 권리';

  @override
  String get policyRightsBody =>
      '귀하는 언제든지 개인 데이터에 접근, 수정 또는 삭제할 권리가 있습니다. 프로필 설정에서 환경 설정을 관리하거나 고객 지원팀에 문의하실 수 있습니다.';

  @override
  String get policyContactTitle => '5. 연락처';

  @override
  String get policyContactBody =>
      '이 정책에 대해 궁금한 점이 있으면 support@freequick.app으로 문의해 주세요.';
}
