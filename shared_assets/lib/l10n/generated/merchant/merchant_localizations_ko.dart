// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'merchant_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class MerchantLocalizationsKo extends MerchantLocalizations {
  MerchantLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get admin_panel => '관리자 패널';

  @override
  String get join_requests => '가입 요청';

  @override
  String get edit_sheet_title => '편집 시트';

  @override
  String get admin_notifications_tab_send => '보내다';

  @override
  String get admin_notifications_tab_history => '역사';

  @override
  String get admin_notifications_target_audience => '타겟 고객';

  @override
  String get admin_notifications_audience_all => '모든 사용자';

  @override
  String get admin_notifications_audience_restaurants => '레스토랑';

  @override
  String get admin_notifications_audience_specific => '특정 사용자';

  @override
  String get admin_notifications_search_hint => '이름 또는 이메일로 사용자를 검색하세요...';

  @override
  String get admin_notifications_search_hint_more => '다른 사용자를 추가하세요...';

  @override
  String get admin_notifications_title_label => '알림 제목';

  @override
  String get admin_notifications_title_hint => '제목을 입력하세요';

  @override
  String get admin_notifications_body_label => '메시지 본문';

  @override
  String get admin_notifications_body_hint => '메시지를 입력하세요';

  @override
  String get admin_notifications_required => '이 항목은 필수 입력 사항입니다.';

  @override
  String get admin_notifications_sending => '배상...';

  @override
  String get admin_notifications_send_button => '알림 보내기';

  @override
  String get admin_notifications_select_user => '최소 한 명의 사용자를 선택해 주세요.';

  @override
  String get admin_notifications_sent_one => '알림이 성공적으로 전송되었습니다.';

  @override
  String admin_notifications_sent_many(int count) {
    return '$count명의 사용자에게 알림이 전송되었습니다.';
  }

  @override
  String get admin_notifications_history_empty => '아직 알림 기록이 없습니다.';

  @override
  String get admin_notifications_history_sent_badge => '전송된';

  @override
  String admin_notifications_history_sent_count(int count) {
    return '$count 보냈습니다';
  }

  @override
  String get admin_overview_platform_glance => '플랫폼 개요';

  @override
  String get admin_overview_revenue_30d => '매출 (최근 30일)';

  @override
  String get admin_overview_pending_requests => '대기 중인 가입 요청';

  @override
  String get admin_overview_view_all => '모두 보기';

  @override
  String get admin_overview_order_status => '주문 상태';

  @override
  String get admin_overview_top_restaurants => '최고의 레스토랑';

  @override
  String get admin_overview_stat_restaurants => '총 레스토랑 수';

  @override
  String admin_overview_stat_restaurants_sub(int active) {
    return '$active 활성';
  }

  @override
  String get admin_overview_stat_orders => '총 주문량';

  @override
  String admin_overview_stat_orders_sub(int today) {
    return '$today 오늘';
  }

  @override
  String get admin_overview_stat_revenue => '총 수익';

  @override
  String admin_overview_stat_revenue_sub(String last7d) {
    return '$last7d PLN 지난 7일';
  }

  @override
  String get admin_overview_stat_avg => '평균 주문 금액';

  @override
  String admin_overview_stat_avg_sub(int menus, int items) {
    return '$menus 메뉴 • $items 항목';
  }

  @override
  String get admin_overview_revenue_no_data => '수익 데이터가 없습니다.';

  @override
  String get admin_overview_no_pending => '현재 가입 요청이 없습니다.';

  @override
  String admin_overview_pending_nip(String nip, String date) {
    return 'NIP: $nip • $date';
  }

  @override
  String get admin_overview_no_orders => '아직 주문이 없습니다.';

  @override
  String get admin_overview_no_order_data => '주문 정보가 없습니다.';

  @override
  String admin_overview_orders_count(int count) {
    return '$count 주문';
  }

  @override
  String get requests_tab_registrations => '등록';

  @override
  String get requests_tab_go_live => '라이브 방송 시작';

  @override
  String get requests_filter_pending => '보류 중';

  @override
  String get requests_filter_approved => '승인됨';

  @override
  String get requests_filter_active => '활동적인';

  @override
  String get requests_filter_rejected => '거절됨';

  @override
  String get requests_filter_suspended => '정지된';

  @override
  String get requests_filter_all => '모두';

  @override
  String requests_empty_filtered(String status) {
    return '$status개의 요청이 발견되지 않았습니다.';
  }

  @override
  String get requests_empty_all => '등록 요청이 없습니다.';

  @override
  String get requests_go_live_empty => 'Go Live 요청이 없습니다.';

  @override
  String get requests_go_live_section_pending => '검토 중';

  @override
  String get requests_go_live_section_reviewed => '검토 완료';

  @override
  String requests_go_live_requested(String timeAgo, String date) {
    return '요청됨 $timeAgo ($date)';
  }

  @override
  String get requests_badge_activated => '활성화됨';

  @override
  String get requests_badge_declined => '거절됨';

  @override
  String get requests_badge_pending_review => '검토 중';

  @override
  String requests_go_live_activated_on(String date) {
    return '$date에서 활성화됨';
  }

  @override
  String requests_go_live_declined_on(String date) {
    return '$date에서 거절됨';
  }

  @override
  String get requests_check_logo => '심벌 마크';

  @override
  String get requests_check_banner => '기치';

  @override
  String get requests_check_address => '주소';

  @override
  String get requests_check_iban => '이반';

  @override
  String get requests_check_photo => '프로필 사진';

  @override
  String get requests_check_menu => '메뉴 항목';

  @override
  String requests_setup_progress(int completed, int total) {
    return '$completed/$total 설정 작업';
  }

  @override
  String requests_submitted(String date) {
    return '제출됨 $date';
  }

  @override
  String requests_copied(String id) {
    return 'ID 복사됨: $id';
  }

  @override
  String get requests_confirm_approve_title => '레스토랑을 승인하시겠습니까?';

  @override
  String get requests_confirm_approve_body =>
      '이를 통해 판매자는 메뉴와 프로필 설정을 시작할 수 있습니다.';

  @override
  String get requests_confirm_reject_title => '지원서를 거부하시겠습니까?';

  @override
  String get requests_confirm_reject_body =>
      '이렇게 하면 판매자가 대시보드에 접근할 수 없게 됩니다. 판매자에게는 거절 사실이 통지됩니다.';

  @override
  String get requests_confirm_suspend_title => '레스토랑 영업 정지?';

  @override
  String get requests_confirm_suspend_body =>
      '이렇게 하면 해당 레스토랑과 모든 상품이 플랫폼에서 즉시 숨겨집니다.';

  @override
  String get requests_confirm_reinstate_title => '레스토랑을 다시 운영할 수 있을까요?';

  @override
  String get requests_confirm_reinstate_body =>
      '이렇게 하면 레스토랑 상태가 \'활성\'으로 복원되어 고객에게 다시 표시됩니다.';

  @override
  String get requests_action_copy_id => '레스토랑 ID 복사';

  @override
  String requests_error_failed(String error) {
    return '작업 실패: $error';
  }

  @override
  String get users_search_hint => '이름 또는 이메일로 검색...';

  @override
  String get users_empty_filtered => '필터 조건에 맞는 사용자가 없습니다.';

  @override
  String get users_empty_all => '시스템에서 사용자를 찾을 수 없습니다.';

  @override
  String users_joined(String date) {
    return '$date에 가입했습니다';
  }

  @override
  String get users_detail_title => '사용자 정보';

  @override
  String get users_detail_id => '사용자 ID';

  @override
  String get users_detail_phone => '핸드폰';

  @override
  String get users_detail_joined => '가입함';

  @override
  String get users_detail_role => '역할';

  @override
  String get users_ban_body => '정말이세요? 해당 사용자는 즉시 로그아웃되고 계정에 접근할 수 없게 됩니다.';

  @override
  String get users_unban_body => '이렇게 하면 사용자의 플랫폼 접근 권한이 복원됩니다.';

  @override
  String get users_delete_title => '사용자를 영구적으로 삭제하시겠습니까?';

  @override
  String get users_delete_body =>
      '이 작업은 되돌릴 수 없습니다. 모든 사용자 프로필 데이터가 데이터베이스에서 삭제됩니다.';

  @override
  String get users_snack_banned => '해당 사용자는 차단되었습니다.';

  @override
  String get users_snack_unbanned => '사용자 접근 권한이 복원되었습니다.';

  @override
  String get users_snack_deleted => '사용자 계정이 성공적으로 삭제되었습니다.';

  @override
  String get users_filter_all => '모두';

  @override
  String get users_filter_restaurant => '레스토랑';

  @override
  String get users_filter_admin => '관리자';

  @override
  String get users_filter_customer => '고객';

  @override
  String get shell_nav_overview => '개요';

  @override
  String get shell_nav_orders => '명령';

  @override
  String get shell_nav_menus => '메뉴';

  @override
  String get shell_nav_promotions => '프로모션';

  @override
  String get shell_nav_analytics => '해석학';

  @override
  String get shell_nav_settings => '설정';

  @override
  String get shell_restaurant_not_found => '레스토랑 정보를 찾을 수 없습니다.';

  @override
  String get shell_finish_setup => '설정 완료';

  @override
  String get shell_my_account => '내 계정';

  @override
  String get shell_menu_support => '지원 센터';

  @override
  String get shell_menu_sales => '영업 담당자';

  @override
  String get shell_menu_cookies => '쿠키 정책';

  @override
  String get shell_menu_settings => '앱 설정';

  @override
  String get shell_menu_logout => '로그아웃';

  @override
  String get shell_already_pending => '이미 접수된 요청이 있습니다.';

  @override
  String get shell_go_live_submitted => '서비스 개시 요청이 제출되었습니다!';

  @override
  String shell_error(String error) {
    return '오류: $error';
  }

  @override
  String get shell_go_offline_title => '오프라인으로 전환하시겠습니까?';

  @override
  String get shell_go_offline_body => '귀하의 레스토랑은 더 이상 플랫폼에서 고객에게 표시되지 않습니다.';

  @override
  String get shell_go_offline_confirm => '네, 오프라인으로 전환하세요.';

  @override
  String get shell_live_go_offline => '라이브 / 오프라인';

  @override
  String get shell_go_live_pending => '요청 검토 중';

  @override
  String get shell_go_live_declined => '거절되었습니다 - 다시 시도해 주세요';

  @override
  String get shell_request_go_live => '라이브 방송 요청';

  @override
  String get gate_pending_title => '검토 중';

  @override
  String get gate_pending_message =>
      '저희 팀에서 현재 귀하의 레스토랑 프로필을 검토 중입니다. 승인되면 알려드리겠습니다.';

  @override
  String get gate_rejected_title => '신청이 거부되었습니다';

  @override
  String get gate_rejected_message =>
      '죄송하지만 현재 신청하신 내용은 승인되지 않았습니다. 자세한 사항은 고객 지원팀에 문의해 주세요.';

  @override
  String get gate_suspended_title => '계정 정지됨';

  @override
  String get gate_suspended_message => '정책 위반으로 인해 계정이 정지되었습니다.';

  @override
  String get gate_default_title => '접근 제한됨';

  @override
  String get gate_default_message => '아직 이 대시보드에 접근할 권한이 없습니다.';

  @override
  String get analytics_section_glance => '한눈에 보기';

  @override
  String analytics_stat_revenue(int days) {
    return '수익(${days}d)';
  }

  @override
  String analytics_stat_orders(int days) {
    return '주문(${days}d)';
  }

  @override
  String get analytics_stat_today => '오늘의 판매량';

  @override
  String get analytics_stat_avg => '평균 주문 금액';

  @override
  String get analytics_section_revenue => '수익 추세';

  @override
  String get analytics_no_revenue => '이 기간에 대한 매출 데이터는 없습니다.';

  @override
  String get analytics_section_status => '주문 상태 분석';

  @override
  String get analytics_no_orders => '이 기간에 대한 주문 내역이 없습니다.';

  @override
  String get analytics_section_popular => '가장 인기 있는 상품';

  @override
  String get analytics_no_items => '항목 데이터가 없습니다.';

  @override
  String analytics_orders_count(int count) {
    return '$count 주문';
  }

  @override
  String menus_error(String error) {
    return '메뉴를 불러올 수 없습니다: $error';
  }

  @override
  String get menus_empty_title => '메뉴가 비어 있습니다';

  @override
  String get menus_empty_subtitle =>
      '\'메인 요리\'나 \'음료\'와 같은 카테고리를 만들어 주방을 정리해 보세요.';

  @override
  String get menus_field_title_hint => '예: 이탈리아 피자';

  @override
  String get menus_field_desc_hint => '이 섹션의 내용을 간략하게 설명해 주세요...';

  @override
  String get menus_image_browse => 'JPG 또는 PNG 파일 형식, 16:9 비율 권장';

  @override
  String get menus_created => '메뉴 카테고리가 생성되었습니다!';

  @override
  String get menus_updated => '메뉴 카테고리가 업데이트되었습니다.';

  @override
  String get menus_deleted => '해당 메뉴 카테고리가 삭제되었습니다.';

  @override
  String get menus_image_cleanup_error =>
      '메뉴는 저장되었지만, 기존 배너는 저장소에서 삭제할 수 없었습니다.';

  @override
  String get menus_error_missing_ids => '필수 ID가 누락되었습니다. 삭제할 수 없습니다.';

  @override
  String items_error(String error) {
    return '항목 로드 오류: $error';
  }

  @override
  String get items_empty_title => '아직 상품이 없습니다.';

  @override
  String get items_empty_subtitle => '먼저 이 메뉴에 첫 번째 요리를 추가하세요.';

  @override
  String get items_field_title_hint => '예: 클래식 치즈버거';

  @override
  String get items_field_info_hint => '예: 소고기 200g, 체다 치즈, 피클';

  @override
  String get items_field_desc_hint => '재료와 조리법을 설명해 주세요...';

  @override
  String get items_field_price_hint => '0.00';

  @override
  String get items_field_tags_hint => '비건, 매운맛, 글루텐프리...';

  @override
  String get items_tag_hint => '태그 추가 (예: 인기)';

  @override
  String get items_added => '항목이 성공적으로 추가되었습니다.';

  @override
  String get items_updated => '상품 정보가 저장되었습니다.';

  @override
  String get items_deleted => '해당 항목이 메뉴에서 삭제되었습니다.';

  @override
  String get items_error_no_image => '먼저 이미지를 업로드해 주세요.';

  @override
  String get items_tag_error_empty => '태그는 비워둘 수 없습니다.';

  @override
  String get items_tag_error_capitalize => '태그는 반드시 대문자로 시작해야 합니다.';

  @override
  String get items_tag_error_letters => '글자만 허용됩니다.';

  @override
  String get items_tag_error_duplicate => '이 태그는 이미 존재합니다.';

  @override
  String get items_discount_info => '예: 500g, 매운맛, 비건';

  @override
  String get image_cleanup_error => '항목은 저장되었지만 이전 이미지를 저장소에서 삭제할 수 없습니다.';

  @override
  String overview_welcome(String name) {
    return '$name님, 다시 오신 것을 환영합니다!';
  }

  @override
  String get overview_chef_fallback => '요리사';

  @override
  String get overview_subtitle => '오늘 당신의 레스토랑에서 일어난 일은 다음과 같습니다.';

  @override
  String get overview_setup_title => '설정을 완료하세요';

  @override
  String overview_setup_progress(int completed, int total) {
    return '$total 단계 중 $completed 단계 완료';
  }

  @override
  String get overview_task_logo_title => '로고 업로드';

  @override
  String get overview_task_logo_desc => '고객 앱에서 브랜드 아이덴티티를 보여주세요.';

  @override
  String get overview_task_banner_title => '레스토랑 배너';

  @override
  String get overview_task_banner_desc => '가장 잘 만든 요리의 고화질 사진.';

  @override
  String get overview_task_address_title => '사업장 주소';

  @override
  String get overview_task_address_desc =>
      '고객들이 당신을 어디에서 찾을 수 있는지 알 수 있도록 하세요.';

  @override
  String get overview_task_photo_title => '프로필 사진';

  @override
  String get overview_task_photo_desc => '계정에 나만의 개성을 더해보세요.';

  @override
  String get overview_task_menu_title => '메뉴 만들기';

  @override
  String get overview_task_menu_desc => '메뉴 카테고리 하나 이상과 메뉴 항목 하나 이상을 추가하세요.';

  @override
  String get overview_task_iban_title => '지급 내역';

  @override
  String get overview_task_iban_desc => 'IBAN을 입력하시면 매주 수익금을 받으실 수 있습니다.';

  @override
  String get overview_stat_total_orders => '총 주문량';

  @override
  String get overview_stat_pending => '보류 중';

  @override
  String get overview_stat_completed => '완전한';

  @override
  String get overview_stat_revenue => '총 수익';

  @override
  String get promo_empty_title => '현재 진행 중인 프로모션 없음';

  @override
  String get promo_empty_subtitle => '레스토랑의 인지도를 높일 첫 번째 캠페인을 만들어 보세요.';

  @override
  String get promo_field_title_hint => '예: 여름 버거 축제';

  @override
  String get promo_field_desc_hint => '고객에게 제안 내용을 설명하세요...';

  @override
  String promo_items_linked(int count) {
    return '$count 연결된 항목';
  }

  @override
  String promo_items_linked_plural(int count) {
    return '$count 연결된 항목';
  }

  @override
  String get promo_date_order_error => '종료일은 시작일 이후여야 합니다.';

  @override
  String get promo_no_dates => '시작일과 종료일을 모두 선택해 주세요.';

  @override
  String get promo_created => '프로모션이 성공적으로 진행되었습니다!';

  @override
  String get promo_updated => '프로모션 세부 정보가 업데이트되었습니다.';

  @override
  String get promo_deleted => '프로모션이 삭제되었습니다.';

  @override
  String get promo_banner_cleanup_error => '참고: 기존 이미지를 저장소에서 삭제할 수 없습니다.';

  @override
  String get promo_error_no_image => '새로운 프로모션을 위해서는 배너 이미지가 필요합니다.';

  @override
  String get promo_link_no_items => '메뉴에서 원하는 항목을 찾을 수 없습니다.';

  @override
  String get promo_image_recommended => '권장 비율은 16:9입니다.';

  @override
  String get settings_error => '설정을 불러올 수 없습니다. 다시 시도해 주세요.';

  @override
  String get settings_logo_recommended => '정사각형 PNG 또는 JPG 파일 (최소 512x512픽셀)';

  @override
  String get settings_logo_uploading => '업로드 중...';

  @override
  String get settings_logo_updated => '레스토랑 로고가 업데이트되었습니다.';

  @override
  String get settings_banner_recommended => '16:9 와이드 화면비 권장';

  @override
  String get settings_banner_updated => '표지 배너가 업데이트되었습니다.';

  @override
  String get settings_business_updated => '회사 정보가 저장되었습니다.';

  @override
  String get settings_profile_updated => '프로필 변경 사항이 저장되었습니다.';

  @override
  String get settings_password_reset_sent => '비밀번호 재설정 링크가 이메일로 발송되었습니다.';

  @override
  String get settings_delete_dialog_title => '정말 확실하세요?';

  @override
  String get settings_delete_dialog_body =>
      '이 조치는 되돌릴 수 없습니다. 모든 메뉴, 프로모션 및 이용 내역이 삭제됩니다.';

  @override
  String get settings_address_set => '아직 주소가 고정되지 않았습니다.';

  @override
  String get settings_map_no_pick => '먼저 지도에서 위치를 선택해 주세요.';

  @override
  String get settings_profile_name_hint => '성명';

  @override
  String get build_user_experience => '차세대 다이닝 경험을 만들어보세요.';

  @override
  String get join_thousands => '저희 플랫폼을 통해 사업을 성장시키고 있는 수천 개의 레스토랑에 합류하세요.';

  @override
  String get sign_in_to_dashboard => '대시보드에 로그인하세요';

  @override
  String get create_your_account => '계정을 만드세요';

  @override
  String get new_to_the_platform => '이 플랫폼을 처음 사용하시나요?';

  @override
  String get already_have_an_account => '이미 계정이 있으신가요?';

  @override
  String get with_google => '구글과 함께';

  @override
  String get terms_of_service => '계속 진행하시면 서비스 약관 및 개인정보처리방침에 동의하시는 것으로 간주됩니다.';

  @override
  String get errorNoUserRecord => '사용자 프로필을 찾을 수 없습니다. 고객 지원팀에 문의해 주세요.';

  @override
  String get errorRestaurantAccountOnly => '이 포털은 레스토랑 및 관리자 계정 전용입니다.';

  @override
  String get errorNoRestaurantRecord => '이 계정에 대한 레스토랑 사업자 프로필을 찾을 수 없습니다.';

  @override
  String get hintEmail => '이메일 주소';

  @override
  String get hintPassword => '비밀번호';

  @override
  String get business => '사업';

  @override
  String get business_name => '회사명';

  @override
  String get business_phone => '업무용 전화';

  @override
  String get owner_full_name => '소유자 성명';

  @override
  String get owner_phone => '소유자 전화번호';

  @override
  String get creating_partner_account => '파트너 계정 생성 중...';

  @override
  String get account_is_pending_approval => '등록이 완료되었습니다! 계정 승인이 진행 중입니다.';

  @override
  String get now_live_in => '현재 크라쿠프와 바르샤바에 거주';

  @override
  String get put_your_restaurant_on => '레스토랑을 디지털 지도에 등록하세요.';

  @override
  String get manage_your_menu =>
      '메뉴 관리, 실시간 판매 추적, 고객 기반 확대를 위한 올인원 판매자 대시보드를 이용해 보세요.';

  @override
  String get register_your_restaurant => '레스토랑 등록하기';

  @override
  String get see_how_it_works => '작동 방식을 확인해 보세요';

  @override
  String get live_platform_stats => '실시간 플랫폼 통계';

  @override
  String get restaurants_on_platform => '플랫폼 내 레스토랑';

  @override
  String get orders_placed => '주문 완료';

  @override
  String get menus_published => '메뉴가 게시되었습니다';

  @override
  String get items_available => '판매 가능 상품';

  @override
  String get trusted_by_restaurants => '200개 이상의 지역 레스토랑에서 신뢰받는 서비스';

  @override
  String get digital_menu => '디지털 메뉴';

  @override
  String get your_menu_goes_live_instantly => '고객님의 메뉴는 저희 고객 플랫폼에 즉시 게시됩니다.';

  @override
  String get custom_banners => '맞춤 배너';

  @override
  String get full_creative_control => '매장의 시각적 정체성에 대한 완전한 창의적 통제권을 가지세요.';

  @override
  String get sales_analytics => '판매 분석';

  @override
  String get track_peak_hours => '피크 시간대와 가장 많이 팔리는 품목을 실시간으로 추적하세요.';

  @override
  String get ready_to_grow => '매출 증대를 원하시나요?';

  @override
  String get join_restaurants => '저희 플랫폼에서 이미 성공을 거두고 있는 레스토랑들에 합류하세요.';

  @override
  String get hiw_title => '작동 방식';

  @override
  String get hiw_hero_badge => '간편한 온보딩';

  @override
  String get hiw_hero_title => '주방을 온라인으로 꾸미는 것이 이렇게 쉬웠던 적은 없었습니다.';

  @override
  String get hiw_hero_subtitle =>
      '회원가입부터 첫 주문까지 모든 단계를 간소화하여 몇 주가 아닌 며칠 만에 서비스를 시작할 수 있도록 했습니다.';

  @override
  String get hiw_step1_title => '계정 생성';

  @override
  String get hiw_step1_desc => '사업자 등록 정보(사업자등록번호/지역명)와 소유자 정보를 입력하여 가입하세요.';

  @override
  String get hiw_step2_title => '관리자 확인';

  @override
  String get hiw_step2_desc => '저희 팀은 플랫폼의 안전 및 품질 기준을 준수하기 위해 귀하의 신청서를 검토합니다.';

  @override
  String get hiw_step3_title => '스토어 설정하기';

  @override
  String get hiw_step3_desc => '로고를 업로드하고, 영업시간을 설정하고, 배송 지역을 정의하세요.';

  @override
  String get hiw_step4_title => '나만의 메뉴를 만들어보세요';

  @override
  String get hiw_step4_desc =>
      '카테고리, 항목 및 수식어를 추가하세요. AI 도구를 활용하여 고품질 설명을 작성하세요.';

  @override
  String get hiw_step5_title => '라이브 방송 시작';

  @override
  String get hiw_step5_desc => '상태를 활성으로 변경하고 지역 고객으로부터 주문을 받기 시작하세요.';

  @override
  String get hiw_feature1_title => '실시간 동기화';

  @override
  String get hiw_feature1_desc => '메뉴 업데이트는 지연 없이 고객 앱에 즉시 반영됩니다.';

  @override
  String get hiw_feature2_title => '상세 분석';

  @override
  String get hiw_feature2_desc => '가장 잘 팔리는 상품과 피크 시간대를 파악하여 직원과 재고를 최적화하세요.';

  @override
  String get hiw_feature3_title => '이미지 관리';

  @override
  String get hiw_feature3_desc => '고해상도 음식 사진을 위한 통합 클라우드 스토리지.';

  @override
  String get hiw_feature4_title => '역할 기반 액세스';

  @override
  String get hiw_feature4_desc => '소유자, 관리자 및 주방 직원의 권한을 안전하게 관리하세요.';

  @override
  String get hiw_feature5_title => '다중 장치';

  @override
  String get hiw_feature5_desc => '데스크톱, 태블릿 또는 휴대폰에서 레스토랑을 원활하게 관리하세요.';

  @override
  String get hiw_feature6_title => '연중무휴 24시간 지원';

  @override
  String get hiw_feature6_desc => '저희 가맹점 성공팀은 언제나 고객님의 성장을 도와드릴 준비가 되어 있습니다.';

  @override
  String get hiw_cta_title => '매출 증대를 원하시나요?';

  @override
  String get hiw_cta_subtitle => '오늘 바로 성공적인 레스토랑 커뮤니티에 참여하세요.';

  @override
  String get hiw_cta_primary => '무료로 시작하세요';

  @override
  String get hiw_cta_secondary => '가격 보기';

  @override
  String get pricing_title => '가격';

  @override
  String get pricing_hero_badge => '투명한 수수료';

  @override
  String get pricing_hero_title => '고정 비용 없이 사업을 성장시키세요.';

  @override
  String get pricing_hero_subtitle =>
      '고객님의 성공이 곧 저희의 성공입니다. 초기 설정 비용도 없고, 월 구독료도 없습니다. 판매 금액의 일정 비율만 지불하시면 됩니다.';

  @override
  String get pricing_step1_title => '고객 주문';

  @override
  String get pricing_step1_desc => '주문은 안전한 고객 플랫폼을 통해 이루어집니다.';

  @override
  String get pricing_step2_title => '준비하세요';

  @override
  String get pricing_step2_desc => '주방을 관리하고 팁은 100% 모두 가져가세요.';

  @override
  String get pricing_step3_title => '주간 지급';

  @override
  String get pricing_step3_desc => '저희의 소액 수수료를 제외한 금액이 입금됩니다.';

  @override
  String get pricing_calculator_title => '예상 수입을 계산해 보세요.';

  @override
  String get pricing_slider_orders_label => '하루 주문량';

  @override
  String pricing_slider_orders_value(int count, int monthly) {
    return '$count 주문($monthly/월)';
  }

  @override
  String get pricing_slider_avg_label => '평균 주문 금액';

  @override
  String pricing_tier_badge(String name, String pct) {
    return '$name 티어($pct)';
  }

  @override
  String pricing_tier_monthly(int count) {
    return '$count 월간 주문';
  }

  @override
  String get pricing_calc_revenue_label => '일일 수익';

  @override
  String get pricing_calc_revenue_sub => '총매출액';

  @override
  String pricing_calc_fee_label(String pct) {
    return '플랫폼 수수료($pct)';
  }

  @override
  String get pricing_tier_starter_range => '0~100건의 주문';

  @override
  String get pricing_tier_growing_range => '101~500건의 주문';

  @override
  String get pricing_tier_established_range => '501~1500건의 주문';

  @override
  String get pricing_tier_partner_range => '1500건 이상의 주문';

  @override
  String get pricing_calc_fee_sub => '우리 위원회';

  @override
  String get pricing_calc_keep_label => '당신은 계속';

  @override
  String get pricing_calc_disclaimer =>
      '현재 요금표를 기준으로 산출한 예상 금액입니다. 결제 처리 수수료는 포함되지 않습니다.';

  @override
  String get pricing_tiers_title => '많이 팔수록 지불하는 금액은 줄어듭니다.';

  @override
  String get pricing_tiers_subtitle => '수수료율은 최근 30일간의 주문량에 따라 자동으로 조정됩니다.';

  @override
  String get pricing_tier_starter_label => '기동기';

  @override
  String get pricing_tier_starter_desc => '신규 레스토랑 및 팝업 키친에 안성맞춤입니다.';

  @override
  String get pricing_tier_growing_label => '성장';

  @override
  String get pricing_tier_growing_desc => '배달 서비스를 확장하려는 지역 인기 업체들을 위해.';

  @override
  String get pricing_tier_established_label => '확립된';

  @override
  String get pricing_tier_established_desc => '단골 고객층이 탄탄하고 매출이 높은 매장.';

  @override
  String get pricing_tier_partner_label => '파트너';

  @override
  String get pricing_tier_partner_desc => '도시 전역 레스토랑 그룹을 위한 심층적인 통합.';

  @override
  String get pricing_faq1_q => '숨겨진 월별 요금이 있나요?';

  @override
  String get pricing_faq1_a =>
      '아니요. 월별 유지비나 구독료는 없습니다. 완료된 주문에 대해서만 수수료를 지불하시면 됩니다.';

  @override
  String get pricing_faq2_q => '급여는 얼마나 자주 지급되나요?';

  @override
  String get pricing_faq2_a => '대금 지급은 전주에 완료된 모든 주문에 대해 매주 화요일에 처리됩니다.';

  @override
  String get pricing_faq3_q => '주문 취소 시에도 수수료를 내야 하나요?';

  @override
  String get pricing_faq3_a => '아니요. 주문이 취소되고 고객에게 환불되는 경우 수수료는 부과되지 않습니다.';

  @override
  String get pricing_faq4_q => '배송은 누가 담당하나요?';

  @override
  String get pricing_faq4_a =>
      '이 계획은 고객께서 직접 배송 인력을 확보하신다는 전제하에 수립되었습니다. 저희는 배송 인력 관리를 위한 디지털 인프라를 제공합니다.';

  @override
  String get pricing_faq5_q => '언제든지 취소할 수 있나요?';

  @override
  String get pricing_faq5_a =>
      '네. 장기 계약은 없습니다. 언제든지 상점을 \'비활성화\' 상태로 설정할 수 있습니다.';

  @override
  String get pricing_cta_title => '위험 부담 없이, 오직 보상만!';

  @override
  String get pricing_cta_subtitle => '오늘부터 주문을 받기 시작하고 결과에 따라서만 비용을 지불하세요.';

  @override
  String get pricing_cta_primary => '파트너로 참여하세요';

  @override
  String get admin_overview_review => '검토';

  @override
  String get admin_overview_status_pending => '보류 중';

  @override
  String get admin_overview_status_processing => '진행 중';

  @override
  String get admin_overview_status_delivered => '배송 완료';

  @override
  String get admin_overview_status_cancelled => '취소';

  @override
  String get requests_action_activate => '활성화';

  @override
  String get requests_action_decline => '감소';

  @override
  String get requests_action_approve => '승인하다';

  @override
  String get requests_action_reject => '거부하다';

  @override
  String get requests_action_suspend => '유예하다';

  @override
  String get requests_action_reinstate => '복원';

  @override
  String get requests_status_approved => '승인됨';

  @override
  String get requests_status_active => '활동적인';

  @override
  String get requests_status_rejected => '거절됨';

  @override
  String get requests_status_suspended => '정지된';

  @override
  String get requests_status_pending => '보류 중';

  @override
  String get users_banned_badge => '금지됨';

  @override
  String get users_action_ban => '차단 사용자';

  @override
  String get users_action_unban => '사용자 차단 해제';

  @override
  String get users_action_delete => '사용자 삭제';

  @override
  String get users_confirm_cancel => '취소';

  @override
  String get users_role_admin => '플랫폼 관리자';

  @override
  String get users_role_restaurant => '레스토랑 주인';

  @override
  String get users_role_customer => '고객';

  @override
  String get users_copied => '값이 클립보드에 복사되었습니다.';

  @override
  String get shell_confirm_cancel => '취소';

  @override
  String get analytics_status_normal => '정상';

  @override
  String get analytics_status_processing => '처리 중';

  @override
  String get analytics_status_delivered => '배송 완료';

  @override
  String get analytics_status_cancelled => '취소';

  @override
  String get menus_fab => '메뉴 만들기';

  @override
  String get menus_sheet_title => '새 메뉴 카테고리';

  @override
  String get menus_image_upload_label => '카테고리 배너';

  @override
  String get menus_field_title_label => '카테고리 이름';

  @override
  String get menus_field_title_required => '이름은 필수 입력 사항입니다.';

  @override
  String get menus_field_desc_label => '설명';

  @override
  String get menus_field_desc_required => '설명이 필요합니다';

  @override
  String get menus_no_image => '배너 이미지를 선택해 주세요.';

  @override
  String get menus_submit => '카테고리 추가';

  @override
  String get menus_design_view_items => '상품 보기';

  @override
  String get menus_design_edit_button => '편집하다';

  @override
  String get menus_design_edit_sheet_title => '편집 메뉴';

  @override
  String get menus_design_delete_button => '삭제';

  @override
  String get menus_design_change_image_hint => '배너 이미지를 변경하려면 탭하세요.';

  @override
  String get menus_design_field_title_label => '메뉴 제목';

  @override
  String get menus_design_field_title_required => '제목을 입력해 주세요';

  @override
  String get menus_design_field_desc_label => '설명';

  @override
  String get menus_design_field_desc_required => '설명을 입력해 주세요.';

  @override
  String get menus_design_save_changes => '변경 사항 저장';

  @override
  String get menus_design_saved => '메뉴가 성공적으로 업데이트되었습니다.';

  @override
  String get menus_design_banner_cleanup_error =>
      '참고: 메뉴가 업데이트되었지만 이전 이미지는 삭제되지 않았습니다.';

  @override
  String get menus_design_delete_dialog_title => '메뉴를 삭제하시겠습니까?';

  @override
  String get menus_design_delete_dialog_body =>
      '정말이세요? 이렇게 하면 이 메뉴와 관련된 모든 데이터가 영구적으로 삭제됩니다.';

  @override
  String get menus_design_delete_cancel => '취소';

  @override
  String get menus_design_delete_confirm => '영구 삭제';

  @override
  String get menus_design_delete_missing_id => '오류: ID가 누락되었습니다. 삭제할 수 없습니다.';

  @override
  String get menus_design_deleted => '메뉴가 삭제되었습니다';

  @override
  String get items_app_bar_fallback => '메뉴 항목';

  @override
  String get items_fab => '항목 추가';

  @override
  String get items_sheet_title => '새 항목 추가';

  @override
  String get items_image_upload_label => '상품 사진';

  @override
  String get items_image_browse => '이미지를 보려면 탭하세요.';

  @override
  String get items_field_title_label => '품목명';

  @override
  String get items_field_info_label => '간략 정보';

  @override
  String get items_field_desc_label => '전체 설명';

  @override
  String get items_field_price_label => '기본 가격';

  @override
  String get items_field_price_required => '가격이 필요합니다';

  @override
  String get items_field_price_invalid => '유효한 가격을 입력하세요';

  @override
  String get items_field_tags_label => '태그';

  @override
  String get items_discount_label => '할인율';

  @override
  String get items_discount_required => '할인 금액을 입력하세요';

  @override
  String get items_discount_invalid => '1부터 100까지 입력하세요';

  @override
  String get items_no_image => '먼저 이미지를 업로드해 주세요.';

  @override
  String get items_submit => '아이템 생성';

  @override
  String get items_design_edit_button => '편집하다';

  @override
  String get items_design_image_cleanup_error =>
      '항목이 업데이트되었지만 이전 이미지를 저장소에서 삭제할 수 없습니다.';

  @override
  String get items_design_saved => '항목이 성공적으로 업데이트되었습니다.';

  @override
  String get items_design_deleted => '해당 항목이 삭제되었습니다.';

  @override
  String get items_design_delete_dialog_title => '항목을 삭제하시겠습니까?';

  @override
  String get items_design_delete_dialog_body =>
      '이 항목을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get items_design_delete_cancel => '취소';

  @override
  String get items_design_delete_confirm => '삭제';

  @override
  String get items_design_edit_sheet_title => '항목 편집';

  @override
  String get items_design_delete_button => '삭제';

  @override
  String get items_design_change_image_hint => '이미지를 탭하여 변경하세요';

  @override
  String get items_design_field_title_label => '품목명';

  @override
  String get items_field_title_required => '이름은 필수 입력 사항입니다.';

  @override
  String get items_design_field_info_label => '간략 정보';

  @override
  String get items_design_field_info_hint => '예: 500g, 매운맛, 비건';

  @override
  String get items_field_info_required => '간략한 정보가 필요합니다.';

  @override
  String get items_design_field_desc_label => '설명';

  @override
  String get items_field_desc_required => '설명이 필요합니다';

  @override
  String get items_design_field_price_label => '기본 가격';

  @override
  String get items_design_field_price_required => '가격이 필요합니다';

  @override
  String get items_design_field_price_invalid => '유효한 가격을 입력하세요';

  @override
  String get items_design_field_tags_label => '태그';

  @override
  String get items_design_field_tags_hint => '태그 추가 (예: 인기)';

  @override
  String get items_discount_toggle => '할인 혜택을 제공하세요';

  @override
  String get items_design_discount_label => '할인율';

  @override
  String get items_design_discount_required => '할인 금액이 필요합니다.';

  @override
  String get items_design_discount_invalid => '1에서 100 사이의 값을 입력하세요.';

  @override
  String get overview_section_glance => '한눈에 보기';

  @override
  String get overview_section_orders => '최근 주문';

  @override
  String get overview_task_done => '완료';

  @override
  String get overview_task_setup => '설정';

  @override
  String get promo_fab => '프로모션 생성';

  @override
  String get promo_badge_live => '살다';

  @override
  String get promo_badge_inactive => '비활성';

  @override
  String get promo_edit_button => '관리하다';

  @override
  String get promo_sheet_add_title => '새로운 프로모션';

  @override
  String get promo_sheet_edit_title => '편집 프로모션';

  @override
  String get promo_field_title_label => '캠페인 제목';

  @override
  String get promo_field_title_required => '제목을 입력해 주세요';

  @override
  String get promo_field_desc_label => '간략 설명';

  @override
  String get promo_field_desc_required => '설명이 필요합니다';

  @override
  String get promo_date_start => '시작일';

  @override
  String get promo_date_end => '종료일';

  @override
  String get promo_date_pick => '날짜를 선택하세요';

  @override
  String get promo_active_toggle => '고객에게 프로모션을 보여주세요';

  @override
  String get promo_image_upload_hint => '캠페인 배너를 업로드하려면 탭하세요.';

  @override
  String get promo_image_change_hint => '배너를 변경하려면 탭하세요.';

  @override
  String get promo_delete_title => '프로모션을 삭제하시겠습니까?';

  @override
  String get promo_delete_body =>
      '이렇게 하면 캠페인과 캠페인 배너가 영구적으로 삭제됩니다. 이 작업은 되돌릴 수 없습니다.';

  @override
  String get promo_delete_cancel => '간직하세요';

  @override
  String get promo_delete_confirm => '삭제';

  @override
  String get promo_no_image => '새로운 프로모션을 위해서는 배너 이미지가 필요합니다.';

  @override
  String get promo_link_section_label => '링크 항목';

  @override
  String get promo_link_section_hint => '이 프로모션에 해당하는 상품을 선택하세요.';

  @override
  String get promo_image_upload_label => '홍보 이미지';

  @override
  String get promo_save_changes => '변경 사항 저장';

  @override
  String get promo_create => '출시 프로모션';

  @override
  String get settings_section_business => '사업 상세 정보';

  @override
  String get settings_section_business_sub => '레스토랑의 대외적인 이미지를 관리하세요.';

  @override
  String get settings_section_profile => '계정 프로필';

  @override
  String get settings_section_profile_sub => '귀하의 개인 연락처 정보입니다.';

  @override
  String get settings_section_danger => '위험 지역';

  @override
  String get settings_section_danger_sub => '계정 조치는 되돌릴 수 없습니다.';

  @override
  String get settings_logo_title => '레스토랑 로고';

  @override
  String get settings_logo_status_staged => '새 로고가 선택되었습니다';

  @override
  String get settings_logo_status_exists => '로고가 업로드되었습니다';

  @override
  String get settings_logo_status_none => '로고 설정 안 됨';

  @override
  String get settings_logo_choose => '이미지를 선택하세요';

  @override
  String get settings_logo_upload => '로고 저장';

  @override
  String get settings_logo_success => '로고 업데이트가 성공적으로 완료되었습니다!';

  @override
  String get settings_banner_title => '표지 배너';

  @override
  String get settings_banner_choose => '탭하여 표지 사진을 선택하세요';

  @override
  String get settings_banner_upload => '배너 저장';

  @override
  String get settings_banner_success => '배너 업데이트가 성공적으로 완료되었습니다!';

  @override
  String get settings_business_title => '매장 정보';

  @override
  String get settings_address_pick => '지도에 핀 표시';

  @override
  String get settings_address_change => '변화';

  @override
  String get settings_business_saved => '사업 정보가 업데이트되었습니다!';

  @override
  String get settings_profile_title => '계정 소유자';

  @override
  String get settings_profile_photo_ready => '새 사진 저장 준비 완료';

  @override
  String get settings_profile_phone_label => '연락처';

  @override
  String get settings_save_changes => '변경 사항 저장';

  @override
  String get settings_cancel => '취소';

  @override
  String get settings_danger_reset_title => '비밀번호 재설정';

  @override
  String get settings_danger_reset_sub => '비밀번호 재설정 링크를 이메일로 보내드립니다.';

  @override
  String get settings_danger_reset_button => '다시 놓기';

  @override
  String get settings_danger_reset_sent => '재설정 이메일이 발송되었습니다! 받은 편지함을 확인해 주세요.';

  @override
  String get settings_danger_delete_title => '계정 삭제';

  @override
  String get settings_danger_delete_sub => '레스토랑 및 모든 데이터를 영구적으로 삭제합니다.';

  @override
  String get settings_danger_delete_button => '삭제';

  @override
  String get settings_danger_delete_dialog_title => '정말 확실하세요?';

  @override
  String get settings_danger_delete_dialog_body =>
      '이 조치는 되돌릴 수 없습니다. 모든 메뉴, 프로모션 및 이용 내역이 삭제됩니다.';

  @override
  String get settings_map_dialog_title => '위치를 선택하세요';

  @override
  String get settings_map_no_location => '아직 위치를 선택하지 않았습니다.';

  @override
  String get settings_map_open => '지도 열기';

  @override
  String get settings_map_change => '위치 변경';

  @override
  String get settings_map_confirm => '위치 확인';

  @override
  String get settings_profile_saved => '변경 사항이 저장되었습니다.';

  @override
  String get how_it_works => '작동 방식';

  @override
  String get pricing => '가격';

  @override
  String get getStarted => '시작하기';

  @override
  String get tapToUploadImage => '이미지를 업로드하려면 탭하세요';

  @override
  String get sign_up => '가입하기';

  @override
  String get log_in => '로그인';

  @override
  String get sign_in => '로그인';

  @override
  String get errorEnterEmailOrPassword => '이메일 주소와 비밀번호를 입력하세요.';

  @override
  String get errorLoginFailed => '로그인에 실패했습니다. 연결 상태 또는 자격 증명을 확인하십시오.';

  @override
  String get error_no_user_record_found =>
      '사용자 프로필을 찾을 수 없습니다. 고객 지원팀에 문의해 주세요.';

  @override
  String get permission_restaurant_accounts_only =>
      '이 포털은 레스토랑 및 관리자 계정 전용입니다.';

  @override
  String get error_no_restaurant_record_found =>
      '이 계정에 대한 레스토랑 사업자 프로필을 찾을 수 없습니다.';

  @override
  String get admin_profile => '관리자 프로필';

  @override
  String get info_continue => '계속하다';

  @override
  String get hintConfPassword => '비밀번호 확인';

  @override
  String get errorNoMatchPasswords => '비밀번호가 일치하지 않습니다.';

  @override
  String get orders_today => '오늘 주문';

  @override
  String get total_orders => '총 주문량';

  @override
  String get menu_items => '메뉴 항목';

  @override
  String get upper_features => '특징';

  @override
  String get register_now => '지금 등록하세요';

  @override
  String get hiw_section_process => '과정';

  @override
  String get hiw_section_features => '필요한 모든 것';

  @override
  String get hiw_features_title => '현대적인 주방을 위한 강력한 도구들.';
}
