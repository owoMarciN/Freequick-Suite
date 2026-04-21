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
}
