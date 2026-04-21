// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'merchant_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class MerchantLocalizationsPl extends MerchantLocalizations {
  MerchantLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get admin_panel => 'Panel administracyjny';

  @override
  String get join_requests => 'Prośby o dołączenie';

  @override
  String get edit_sheet_title => 'Arkusz edycji';

  @override
  String get admin_notifications_tab_send => 'Wysłać';

  @override
  String get admin_notifications_tab_history => 'Historia';

  @override
  String get admin_notifications_target_audience => 'Grupa docelowa';

  @override
  String get admin_notifications_audience_all => 'Wszyscy użytkownicy';

  @override
  String get admin_notifications_audience_restaurants => 'Restauracje';

  @override
  String get admin_notifications_audience_specific => 'Konkretni użytkownicy';

  @override
  String get admin_notifications_search_hint =>
      'Wyszukaj użytkowników po nazwie lub adresie e-mail...';

  @override
  String get admin_notifications_search_hint_more =>
      'Dodaj kolejnego użytkownika...';

  @override
  String get admin_notifications_title_label => 'Tytuł powiadomienia';

  @override
  String get admin_notifications_title_hint => 'Wprowadź tytuł';

  @override
  String get admin_notifications_body_label => 'Treść wiadomości';

  @override
  String get admin_notifications_body_hint => 'Wpisz wiadomość';

  @override
  String get admin_notifications_required => 'To pole jest wymagane';

  @override
  String get admin_notifications_sending => 'Przesyłka...';

  @override
  String get admin_notifications_send_button => 'Wyślij powiadomienie';

  @override
  String get admin_notifications_select_user =>
      'Proszę wybrać co najmniej jednego użytkownika';

  @override
  String get admin_notifications_sent_one =>
      'Powiadomienie zostało pomyślnie wysłane';

  @override
  String admin_notifications_sent_many(int count) {
    return 'Powiadomienia wysłane do $count użytkowników';
  }

  @override
  String get admin_notifications_history_empty => 'Brak historii powiadomień';

  @override
  String get admin_notifications_history_sent_badge => 'WYSŁANO';

  @override
  String admin_notifications_history_sent_count(int count) {
    return '$count wysłano';
  }

  @override
  String get admin_overview_platform_glance => 'Platforma w skrócie';

  @override
  String get admin_overview_revenue_30d => 'Przychody (ostatnie 30 dni)';

  @override
  String get admin_overview_pending_requests =>
      'Oczekujące prośby o dołączenie';

  @override
  String get admin_overview_view_all => 'Zobacz wszystko';

  @override
  String get admin_overview_order_status => 'Status zamówienia';

  @override
  String get admin_overview_top_restaurants => 'Najlepsze restauracje';

  @override
  String get admin_overview_stat_restaurants => 'Całkowita liczba restauracji';

  @override
  String admin_overview_stat_restaurants_sub(int active) {
    return '$active aktywny';
  }

  @override
  String get admin_overview_stat_orders => 'Łączna liczba zamówień';

  @override
  String admin_overview_stat_orders_sub(int today) {
    return '$today dzisiaj';
  }

  @override
  String get admin_overview_stat_revenue => 'Całkowity przychód';

  @override
  String admin_overview_stat_revenue_sub(String last7d) {
    return '$last7d zł ostatnie 7 dni';
  }

  @override
  String get admin_overview_stat_avg => 'Średnia wartość zamówienia';

  @override
  String admin_overview_stat_avg_sub(int menus, int items) {
    return '$menus menu • $items pozycji';
  }

  @override
  String get admin_overview_revenue_no_data => 'Brak danych o przychodach.';

  @override
  String get admin_overview_no_pending =>
      'Brak oczekujących próśb o dołączenie.';

  @override
  String admin_overview_pending_nip(String nip, String date) {
    return 'NIP: $nip • $date';
  }

  @override
  String get admin_overview_no_orders =>
      'Nie złożono jeszcze żadnych zamówień.';

  @override
  String get admin_overview_no_order_data => 'Brak danych o zamówieniach.';

  @override
  String admin_overview_orders_count(int count) {
    return '$count zamówień';
  }

  @override
  String get requests_tab_registrations => 'Rejestracje';

  @override
  String get requests_tab_go_live => 'Przejdź na żywo';

  @override
  String get requests_filter_pending => 'Aż do';

  @override
  String get requests_filter_approved => 'Zatwierdzony';

  @override
  String get requests_filter_active => 'Aktywny';

  @override
  String get requests_filter_rejected => 'Odrzucony';

  @override
  String get requests_filter_suspended => 'Zawieszony';

  @override
  String get requests_filter_all => 'Wszystko';

  @override
  String requests_empty_filtered(String status) {
    return 'Nie znaleziono $status żądań.';
  }

  @override
  String get requests_empty_all =>
      'Nie znaleziono żadnych próśb o rejestrację.';

  @override
  String get requests_go_live_empty => 'Nie znaleziono próśb o uruchomienie.';

  @override
  String get requests_go_live_section_pending => 'OCZEKUJĄCE NA PRZEGLĄD';

  @override
  String get requests_go_live_section_reviewed => 'PRZEGLĄDANE';

  @override
  String requests_go_live_requested(String timeAgo, String date) {
    return 'Poproszono $timeAgo ($date)';
  }

  @override
  String get requests_badge_activated => 'Aktywowany';

  @override
  String get requests_badge_declined => 'Odrzucony';

  @override
  String get requests_badge_pending_review => 'Oczekujące na przegląd';

  @override
  String requests_go_live_activated_on(String date) {
    return 'Aktywowano w dniu $date';
  }

  @override
  String requests_go_live_declined_on(String date) {
    return 'Odrzucono $date';
  }

  @override
  String get requests_check_logo => 'Logo';

  @override
  String get requests_check_banner => 'Transparent';

  @override
  String get requests_check_address => 'Adres';

  @override
  String get requests_check_iban => 'IBAN';

  @override
  String get requests_check_photo => 'Zdjęcie profilowe';

  @override
  String get requests_check_menu => 'Pozycje menu';

  @override
  String requests_setup_progress(int completed, int total) {
    return '$completed/$total Zadania konfiguracyjne';
  }

  @override
  String requests_submitted(String date) {
    return 'Wysłano $date';
  }

  @override
  String requests_copied(String id) {
    return 'Skopiowano ID: $id';
  }

  @override
  String get requests_confirm_approve_title => 'Zatwierdzić restaurację?';

  @override
  String get requests_confirm_approve_body =>
      'Umożliwi to sprzedawcy rozpoczęcie konfigurowania swoich menu i profilu.';

  @override
  String get requests_confirm_reject_title => 'Odrzucić wniosek?';

  @override
  String get requests_confirm_reject_body =>
      'Uniemożliwi to sprzedawcy dostęp do panelu. Zostanie on powiadomiony o odrzuceniu.';

  @override
  String get requests_confirm_suspend_title => 'Zawiesić restaurację?';

  @override
  String get requests_confirm_suspend_body =>
      'Spowoduje to natychmiastowe ukrycie restauracji i wszystkich jej pozycji na platformie.';

  @override
  String get requests_confirm_reinstate_title => 'Przywrócić restaurację?';

  @override
  String get requests_confirm_reinstate_body =>
      'Spowoduje to przywrócenie statusu restauracji „Aktywna” i ponowne udostępnienie jej klientom.';

  @override
  String get requests_action_copy_id => 'Skopiuj identyfikator restauracji';

  @override
  String requests_error_failed(String error) {
    return 'Operacja nie powiodła się: $error';
  }

  @override
  String get users_search_hint => 'Szukaj po nazwie lub adresie e-mail...';

  @override
  String get users_empty_filtered =>
      'Żaden użytkownik nie spełnia kryteriów filtrów.';

  @override
  String get users_empty_all => 'Nie znaleziono użytkowników w systemie.';

  @override
  String users_joined(String date) {
    return 'Dołączył $date';
  }

  @override
  String get users_detail_title => 'Szczegóły użytkownika';

  @override
  String get users_detail_id => 'Identyfikator użytkownika';

  @override
  String get users_detail_phone => 'Telefon';

  @override
  String get users_detail_joined => 'Dołączył';

  @override
  String get users_detail_role => 'Rola';

  @override
  String get users_ban_body =>
      'Czy jesteś pewien? Ten użytkownik zostanie natychmiast wylogowany i nie będzie mógł uzyskać dostępu do swojego konta.';

  @override
  String get users_unban_body =>
      'Spowoduje to przywrócenie użytkownikowi dostępu do platformy.';

  @override
  String get users_delete_title => 'Czy trwale usunąć użytkownika?';

  @override
  String get users_delete_body =>
      'Tej czynności nie można cofnąć. Wszystkie dane profilu użytkownika zostaną usunięte z bazy danych.';

  @override
  String get users_snack_banned => 'Użytkownik został zbanowany.';

  @override
  String get users_snack_unbanned => 'Dostęp użytkownika przywrócony.';

  @override
  String get users_snack_deleted =>
      'Konto użytkownika zostało pomyślnie usunięte.';

  @override
  String get users_filter_all => 'Wszystko';

  @override
  String get users_filter_restaurant => 'Restauracje';

  @override
  String get users_filter_admin => 'Administrator';

  @override
  String get users_filter_customer => 'Klienci';

  @override
  String get shell_nav_overview => 'Przegląd';

  @override
  String get shell_nav_orders => 'Święcenia';

  @override
  String get shell_nav_menus => 'Menu';

  @override
  String get shell_nav_promotions => 'Promocje';

  @override
  String get shell_nav_analytics => 'Analityka';

  @override
  String get shell_nav_settings => 'Ustawienia';

  @override
  String get shell_restaurant_not_found =>
      'Nie znaleziono danych dotyczących restauracji.';

  @override
  String get shell_finish_setup => 'Zakończ konfigurację';

  @override
  String get shell_my_account => 'Moje konto';

  @override
  String get shell_menu_support => 'Centrum wsparcia';

  @override
  String get shell_menu_sales => 'Kontakt handlowy';

  @override
  String get shell_menu_cookies => 'Polityka plików cookie';

  @override
  String get shell_menu_settings => 'Ustawienia aplikacji';

  @override
  String get shell_menu_logout => 'Wyloguj';

  @override
  String get shell_already_pending => 'Masz już oczekujące żądanie.';

  @override
  String get shell_go_live_submitted =>
      'Prośba o uruchomienie została wysłana!';

  @override
  String shell_error(String error) {
    return 'Błąd: $error';
  }

  @override
  String get shell_go_offline_title => 'Przejść do trybu offline?';

  @override
  String get shell_go_offline_body =>
      'Twoja restauracja nie będzie już widoczna dla klientów na platformie.';

  @override
  String get shell_go_offline_confirm => 'Tak, przejdź do trybu offline';

  @override
  String get shell_live_go_offline => 'Na żywo / Przejdź offline';

  @override
  String get shell_go_live_pending => 'Przeglądanie prośby';

  @override
  String get shell_go_live_declined => 'Odrzucono - Spróbuj ponownie';

  @override
  String get shell_request_go_live => 'Prośba o przejście na żywo';

  @override
  String get gate_pending_title => 'W trakcie przeglądu';

  @override
  String get gate_pending_message =>
      'Nasz zespół aktualnie weryfikuje Twój profil restauracji. Powiadomimy Cię, gdy zostanie zatwierdzony.';

  @override
  String get gate_rejected_title => 'Wniosek odrzucony';

  @override
  String get gate_rejected_message =>
      'Niestety, Twój wniosek nie został w tej chwili zatwierdzony. Skontaktuj się z działem wsparcia, aby uzyskać szczegółowe informacje.';

  @override
  String get gate_suspended_title => 'Konto zawieszone';

  @override
  String get gate_suspended_message =>
      'Twoje konto zostało zawieszone z powodu naruszenia zasad.';

  @override
  String get gate_default_title => 'Ograniczony dostęp';

  @override
  String get gate_default_message =>
      'Nie masz jeszcze uprawnień dostępu do tego pulpitu nawigacyjnego.';

  @override
  String get analytics_section_glance => 'W SKRÓCIE';

  @override
  String analytics_stat_revenue(int days) {
    return 'Przychód (${days}d)';
  }

  @override
  String analytics_stat_orders(int days) {
    return 'Zamówienia (${days}d)';
  }

  @override
  String get analytics_stat_today => 'Dzisiejsza sprzedaż';

  @override
  String get analytics_stat_avg => 'Średnia wartość zamówienia';

  @override
  String get analytics_section_revenue => 'TREND PRZYCHODÓW';

  @override
  String get analytics_no_revenue => 'Brak danych o przychodach za ten okres';

  @override
  String get analytics_section_status => 'ZESTAWIENIE STATUSU ZAMÓWIENIA';

  @override
  String get analytics_no_orders => 'Nie znaleziono zamówień na ten okres';

  @override
  String get analytics_section_popular => 'NAJPOPULARNIEJSZE PRZEDMIOTY';

  @override
  String get analytics_no_items => 'Brak danych o przedmiocie';

  @override
  String analytics_orders_count(int count) {
    return '$count zamówień';
  }

  @override
  String menus_error(String error) {
    return 'Nie można załadować menu: $error';
  }

  @override
  String get menus_empty_title => 'Twoje menu jest puste';

  @override
  String get menus_empty_subtitle =>
      'Utwórz kategorie takie jak „Dania główne” lub „Napoje”, aby rozpocząć organizację kuchni.';

  @override
  String get menus_field_title_hint => 'np. włoskie pizze';

  @override
  String get menus_field_desc_hint =>
      'Krótko opisz, co znajduje się w tej sekcji...';

  @override
  String get menus_image_browse => 'JPG lub PNG, zalecane 16:9';

  @override
  String get menus_created => 'Kategoria menu utworzona!';

  @override
  String get menus_updated => 'Kategoria menu została zaktualizowana.';

  @override
  String get menus_deleted => 'Kategoria menu została usunięta.';

  @override
  String get menus_image_cleanup_error =>
      'Menu zostało zapisane, ale starego baneru nie udało się usunąć z pamięci.';

  @override
  String get menus_error_missing_ids =>
      'Brak wymaganych identyfikatorów. Nie można usunąć.';

  @override
  String items_error(String error) {
    return 'Błąd ładowania elementów: $error';
  }

  @override
  String get items_empty_title => 'Jeszcze nie ma tu żadnych pozycji';

  @override
  String get items_empty_subtitle =>
      'Zacznij od dodania pierwszego dania do tego menu.';

  @override
  String get items_field_title_hint => 'np. Klasyczny Cheeseburger';

  @override
  String get items_field_info_hint =>
      'np. 200 g wołowiny, cheddar, ogórki kiszone';

  @override
  String get items_field_desc_hint =>
      'Opisz składniki i sposób przygotowania...';

  @override
  String get items_field_price_hint => '0,00';

  @override
  String get items_field_tags_hint => 'Wegańskie, pikantne, bezglutenowe...';

  @override
  String get items_tag_hint => 'Dodaj tagi (np. Popularne)';

  @override
  String get items_added => 'Element dodany pomyślnie';

  @override
  String get items_updated => 'Szczegóły przedmiotu zostały zapisane.';

  @override
  String get items_deleted => 'Pozycja została usunięta z menu.';

  @override
  String get items_error_no_image => 'Proszę najpierw przesłać obraz.';

  @override
  String get items_tag_error_empty => 'Tag nie może być pusty';

  @override
  String get items_tag_error_capitalize =>
      'Tag musi zaczynać się wielką literą';

  @override
  String get items_tag_error_letters => 'Dozwolone są tylko litery';

  @override
  String get items_tag_error_duplicate => 'Ten tag już istnieje';

  @override
  String get items_discount_info => 'np. 500 g, pikantne, wegańskie';

  @override
  String get image_cleanup_error =>
      'Element został zapisany, ale starego obrazu nie udało się usunąć z pamięci.';

  @override
  String overview_welcome(String name) {
    return 'Witamy ponownie, $name!';
  }

  @override
  String get overview_chef_fallback => 'Szef kuchni';

  @override
  String get overview_subtitle =>
      'Oto, co dzieje się dzisiaj w Twojej restauracji.';

  @override
  String get overview_setup_title => 'Zakończ konfigurację';

  @override
  String overview_setup_progress(int completed, int total) {
    return 'Wykonano$completed z $total kroków';
  }

  @override
  String get overview_task_logo_title => 'Prześlij logo';

  @override
  String get overview_task_logo_desc =>
      'Tożsamość Twojej marki w aplikacji klienta.';

  @override
  String get overview_task_banner_title => 'Baner restauracji';

  @override
  String get overview_task_banner_desc =>
      'Wysokiej jakości zdjęcie Twojego najlepszego dania.';

  @override
  String get overview_task_address_title => 'Adres firmy';

  @override
  String get overview_task_address_desc =>
      'Dzięki temu klienci będą wiedzieć, gdzie Cię znaleźć.';

  @override
  String get overview_task_photo_title => 'Zdjęcie profilowe';

  @override
  String get overview_task_photo_desc =>
      'Dodaj osobisty akcent do swojego konta.';

  @override
  String get overview_task_menu_title => 'Utwórz menu';

  @override
  String get overview_task_menu_desc =>
      'Dodaj co najmniej jedną kategorię menu i jedną pozycję.';

  @override
  String get overview_task_iban_title => 'Szczegóły wypłaty';

  @override
  String get overview_task_iban_desc =>
      'Podaj swój numer IBAN, aby otrzymywać cotygodniowe zarobki.';

  @override
  String get overview_stat_total_orders => 'Łączna liczba zamówień';

  @override
  String get overview_stat_pending => 'Aż do';

  @override
  String get overview_stat_completed => 'Zakończony';

  @override
  String get overview_stat_revenue => 'Całkowity przychód';

  @override
  String get promo_empty_title => 'Brak aktywnych promocji';

  @override
  String get promo_empty_subtitle =>
      'Utwórz pierwszą kampanię, aby zwiększyć widoczność swojej restauracji.';

  @override
  String get promo_field_title_hint => 'np. Letni Festiwal Burgerów';

  @override
  String get promo_field_desc_hint => 'Wyjaśnij ofertę swoim klientom...';

  @override
  String promo_items_linked(int count) {
    return '$count Powiązany element';
  }

  @override
  String promo_items_linked_plural(int count) {
    return '$count Powiązane elementy';
  }

  @override
  String get promo_date_order_error =>
      'Data zakończenia musi być późniejsza niż data rozpoczęcia';

  @override
  String get promo_no_dates => 'Proszę wybrać datę rozpoczęcia i zakończenia';

  @override
  String get promo_created => 'Promocja rozpoczęta pomyślnie!';

  @override
  String get promo_updated => 'Zaktualizowano szczegóły promocji.';

  @override
  String get promo_deleted => 'Promocja usunięta.';

  @override
  String get promo_banner_cleanup_error =>
      'Uwaga: Starego obrazu nie udało się usunąć z pamięci.';

  @override
  String get promo_error_no_image =>
      'W przypadku nowych promocji wymagany jest baner reklamowy.';

  @override
  String get promo_link_no_items => 'Nie znaleziono żadnych pozycji w menu.';

  @override
  String get promo_image_recommended => 'Zalecany stosunek 16:9';

  @override
  String get settings_error =>
      'Nie udało się załadować ustawień. Spróbuj ponownie.';

  @override
  String get settings_logo_recommended =>
      'Kwadratowy PNG lub JPG (min. 512x512px)';

  @override
  String get settings_logo_uploading => 'Przesyłanie...';

  @override
  String get settings_logo_updated => 'Zaktualizowano logo restauracji.';

  @override
  String get settings_banner_recommended =>
      'Zalecany szeroki format obrazu 16:9';

  @override
  String get settings_banner_updated => 'Zaktualizowano baner okładkowy.';

  @override
  String get settings_business_updated =>
      'Informacje o firmie zostały zapisane.';

  @override
  String get settings_profile_updated => 'Zmiany w profilu zostały zapisane.';

  @override
  String get settings_password_reset_sent =>
      'Link umożliwiający zresetowanie hasła został wysłany na Twój adres e-mail.';

  @override
  String get settings_delete_dialog_title => 'Czy jesteś absolutnie pewien?';

  @override
  String get settings_delete_dialog_body =>
      'Ta czynność jest nieodwracalna. Wszystkie Twoje menu, promocje i historia zostaną usunięte.';

  @override
  String get settings_address_set => 'Nie przypisano jeszcze żadnego adresu';

  @override
  String get settings_map_no_pick => 'Najpierw wybierz lokalizację na mapie.';

  @override
  String get settings_profile_name_hint => 'Pełne imię i nazwisko';

  @override
  String get build_user_experience =>
      'Zbuduj nową generację doświadczeń kulinarnych.';

  @override
  String get join_thousands =>
      'Dołącz do tysięcy restauracji rozwijających swój biznes dzięki naszej platformie.';

  @override
  String get sign_in_to_dashboard => 'Zaloguj się do Panelu sterowania';

  @override
  String get create_your_account => 'Utwórz swoje konto';

  @override
  String get new_to_the_platform => 'Nowość na platformie?';

  @override
  String get already_have_an_account => 'Masz już konto?';

  @override
  String get with_google => 'z Google';

  @override
  String get terms_of_service =>
      'Kontynuując, akceptujesz nasze Warunki korzystania z usługi i Politykę prywatności.';

  @override
  String get errorNoUserRecord =>
      'Nie znaleziono profilu użytkownika. Skontaktuj się z pomocą techniczną.';

  @override
  String get errorRestaurantAccountOnly =>
      'Portal jest przeznaczony wyłącznie dla kont restauracyjnych i administracyjnych.';

  @override
  String get errorNoRestaurantRecord =>
      'Nie znaleziono profilu restauracji dla tego konta.';

  @override
  String get hintEmail => 'Adres e-mail';

  @override
  String get hintPassword => 'Hasło';

  @override
  String get business => 'Biznes';

  @override
  String get business_name => 'Nazwa firmy';

  @override
  String get business_phone => 'Telefon służbowy';

  @override
  String get owner_full_name => 'Imię i nazwisko właściciela';

  @override
  String get owner_phone => 'Telefon właściciela';

  @override
  String get creating_partner_account => 'Tworzenie konta partnerskiego...';

  @override
  String get account_is_pending_approval =>
      'Rejestracja pomyślna! Twoje konto oczekuje na zatwierdzenie.';

  @override
  String get now_live_in => 'Teraz mieszkamy w Krakowie i Warszawie';

  @override
  String get put_your_restaurant_on =>
      'Umieść swoją restaurację na mapie cyfrowej.';

  @override
  String get manage_your_menu =>
      'Zarządzaj swoim menu, śledź bieżącą sprzedaż i powiększaj bazę klientów dzięki naszemu kompleksowemu panelowi sprzedawcy.';

  @override
  String get register_your_restaurant => 'Zarejestruj swoją restaurację';

  @override
  String get see_how_it_works => 'Zobacz jak to działa';

  @override
  String get live_platform_stats => 'STATYSTYKI PLATFORMY NA ŻYWO';

  @override
  String get restaurants_on_platform => 'Restauracje na peronie';

  @override
  String get orders_placed => 'Złożone zamówienia';

  @override
  String get menus_published => 'Opublikowane menu';

  @override
  String get items_available => 'Dostępne przedmioty';

  @override
  String get trusted_by_restaurants =>
      'ZAUFALI NAM PONAD 200 LOKALNYCH RESTAURACJI';

  @override
  String get digital_menu => 'Menu cyfrowe';

  @override
  String get your_menu_goes_live_instantly =>
      'Twoje menu będzie natychmiast dostępne na naszej platformie dla klientów.';

  @override
  String get custom_banners => 'Niestandardowe banery';

  @override
  String get full_creative_control =>
      'Pełna kontrola kreatywna nad identyfikacją wizualną Twojego sklepu.';

  @override
  String get sales_analytics => 'Analityka sprzedaży';

  @override
  String get track_peak_hours =>
      'Śledź godziny szczytu i najlepiej sprzedające się produkty w czasie rzeczywistym.';

  @override
  String get ready_to_grow => 'Gotowy na zwiększenie przychodów?';

  @override
  String get join_restaurants =>
      'Dołącz do restauracji, które już prosperują na naszej platformie.';

  @override
  String get hiw_title => 'Jak to działa';

  @override
  String get hiw_hero_badge => 'Proste wdrażanie';

  @override
  String get hiw_hero_title =>
      'Podłączenie kuchni do Internetu nigdy nie było prostsze.';

  @override
  String get hiw_hero_subtitle =>
      'Usprawniliśmy każdy krok – od rejestracji po złożenie pierwszego zamówienia – abyś mógł rozpocząć korzystanie z serwisu w ciągu kilku dni, a nie tygodni.';

  @override
  String get hiw_step1_title => 'Utwórz konto';

  @override
  String get hiw_step1_desc =>
      'Zarejestruj się podając dane swojej firmy (NIP/REGON) i informacje o właścicielu.';

  @override
  String get hiw_step2_title => 'Weryfikacja administratora';

  @override
  String get hiw_step2_desc =>
      'Nasz zespół przeanalizuje Twoją aplikację, aby zapewnić bezpieczeństwo platformy i wysokie standardy jakości.';

  @override
  String get hiw_step3_title => 'Skonfiguruj swój sklep';

  @override
  String get hiw_step3_desc =>
      'Prześlij swoje logo, ustaw godziny otwarcia i zdefiniuj strefy dostaw.';

  @override
  String get hiw_step4_title => 'Zbuduj swoje menu';

  @override
  String get hiw_step4_desc =>
      'Dodawaj kategorie, elementy i modyfikatory. Skorzystaj z naszych narzędzi AI, aby tworzyć wysokiej jakości opisy.';

  @override
  String get hiw_step5_title => 'Przejdź na żywo';

  @override
  String get hiw_step5_desc =>
      'Zmień swój status na aktywny i zacznij otrzymywać zamówienia od lokalnych klientów.';

  @override
  String get hiw_feature1_title => 'Synchronizacja w czasie rzeczywistym';

  @override
  String get hiw_feature1_desc =>
      'Aktualizacje menu są natychmiast widoczne w aplikacji klienta, bez żadnych opóźnień.';

  @override
  String get hiw_feature2_title => 'Szczegółowa analiza';

  @override
  String get hiw_feature2_desc =>
      'Śledź swoje bestsellery i godziny szczytu, aby zoptymalizować pracę personelu i zapasów.';

  @override
  String get hiw_feature3_title => 'Zarządzanie obrazami';

  @override
  String get hiw_feature3_desc =>
      'Zintegrowana pamięć masowa w chmurze dla wszystkich Twoich zdjęć kulinarnych w wysokiej rozdzielczości.';

  @override
  String get hiw_feature4_title => 'Dostęp oparty na rolach';

  @override
  String get hiw_feature4_desc =>
      'Bezpiecznie zarządzaj uprawnieniami właścicieli, menedżerów i personelu kuchennego.';

  @override
  String get hiw_feature5_title => 'Wiele urządzeń';

  @override
  String get hiw_feature5_desc =>
      'Zarządzaj swoją restauracją bezproblemowo z komputera stacjonarnego, tabletu lub telefonu komórkowego.';

  @override
  String get hiw_feature6_title => 'Wsparcie 24/7';

  @override
  String get hiw_feature6_desc =>
      'Nasz zespół ds. sukcesu sprzedawców jest zawsze dostępny, aby pomóc Ci się rozwijać.';

  @override
  String get hiw_cta_title => 'Gotowy na zwiększenie przychodów?';

  @override
  String get hiw_cta_subtitle =>
      'Dołącz już dziś do naszej społeczności odnoszących sukcesy restauracji.';

  @override
  String get hiw_cta_primary => 'Zacznij za darmo';

  @override
  String get hiw_cta_secondary => 'Zobacz ceny';

  @override
  String get pricing_title => 'Wycena';

  @override
  String get pricing_hero_badge => 'Przejrzyste opłaty';

  @override
  String get pricing_hero_title => 'Rozwijaj swój biznes bez stałych kosztów.';

  @override
  String get pricing_hero_subtitle =>
      'Osiągamy sukces tylko wtedy, gdy Ty odnosisz sukces. Bez opłat instalacyjnych, bez miesięcznych subskrypcji – tylko prosty procent od tego, co sprzedajesz.';

  @override
  String get pricing_step1_title => 'Zamówienia klientów';

  @override
  String get pricing_step1_desc =>
      'Zamówienia można składać za pośrednictwem naszej bezpiecznej platformy klienta.';

  @override
  String get pricing_step2_title => 'Ty się przygotowujesz';

  @override
  String get pricing_step2_desc =>
      'Zarządzaj kuchnią i zatrzymuj 100% napiwków.';

  @override
  String get pricing_step3_title => 'Tygodniowe wypłaty';

  @override
  String get pricing_step3_desc =>
      'Środki są deponowane po odliczeniu naszej niewielkiej prowizji.';

  @override
  String get pricing_calculator_title => 'Oszacuj swoje zarobki.';

  @override
  String get pricing_slider_orders_label => 'Zamówienia dziennie';

  @override
  String pricing_slider_orders_value(int count, int monthly) {
    return '$count zamówień ($monthly / miesiąc)';
  }

  @override
  String get pricing_slider_avg_label => 'Średnia wartość zamówienia';

  @override
  String pricing_tier_badge(String name, String pct) {
    return '$name Poziom ($pct)';
  }

  @override
  String pricing_tier_monthly(int count) {
    return '$count zamówień miesięcznych';
  }

  @override
  String get pricing_calc_revenue_label => 'Dzienny przychód';

  @override
  String get pricing_calc_revenue_sub => 'Sprzedaż brutto';

  @override
  String pricing_calc_fee_label(String pct) {
    return 'Opłata za platformę ($pct)';
  }

  @override
  String get pricing_calc_fee_sub => 'Nasza prowizja';

  @override
  String get pricing_calc_keep_label => 'Ty trzymasz';

  @override
  String get pricing_calc_disclaimer =>
      'Szacunki oparte na aktualnych stawkach progowych. Nie obejmują opłat za przetwarzanie płatności.';

  @override
  String get pricing_tiers_title => 'Im więcej sprzedajesz, tym mniej płacisz.';

  @override
  String get pricing_tiers_subtitle =>
      'Stawki prowizji są automatycznie dostosowywane na podstawie wolumenu zamówień z ostatnich 30 dni.';

  @override
  String get pricing_tier_starter_label => 'Rozrusznik';

  @override
  String get pricing_tier_starter_range => '0–100 zamówień';

  @override
  String get pricing_tier_starter_desc =>
      'Idealne dla nowych restauracji i tymczasowych kuchni.';

  @override
  String get pricing_tier_growing_label => 'Rozwój';

  @override
  String get pricing_tier_growing_range => '101–500 zamówień';

  @override
  String get pricing_tier_growing_desc =>
      'Dla lokalnych restauracji, które zaczynają zwiększać skalę dostaw.';

  @override
  String get pricing_tier_established_label => 'Przyjęty';

  @override
  String get pricing_tier_established_range => '501–1500 zamówień';

  @override
  String get pricing_tier_established_desc =>
      'Placówki o dużym obrocie i lojalnych klientach.';

  @override
  String get pricing_tier_partner_label => 'Partner';

  @override
  String get pricing_tier_partner_range => 'Ponad 1500 zamówień';

  @override
  String get pricing_tier_partner_desc =>
      'Głęboka integracja dla grup restauracyjnych działających w całym mieście.';

  @override
  String get pricing_faq1_q => 'Czy są jakieś ukryte opłaty miesięczne?';

  @override
  String get pricing_faq1_a =>
      'Nie. Nie ma miesięcznych opłat za utrzymanie ani abonamentu. Płacisz tylko prowizję od zrealizowanych zamówień.';

  @override
  String get pricing_faq2_q => 'Jak często otrzymuję wypłatę?';

  @override
  String get pricing_faq2_a =>
      'Wypłaty są realizowane co tydzień, w każdy wtorek, za wszystkie zamówienia zrealizowane w poprzednim tygodniu.';

  @override
  String get pricing_faq3_q => 'Czy płacę prowizję za anulowane zamówienia?';

  @override
  String get pricing_faq3_a =>
      'Nie. Jeśli zamówienie zostanie anulowane i klient otrzyma zwrot pieniędzy, prowizja nie zostanie naliczona.';

  @override
  String get pricing_faq4_q => 'Kto zajmuje się dostawą?';

  @override
  String get pricing_faq4_a =>
      'Ten plan zakłada, że zapewniasz własny personel dostawczy. My zapewniamy infrastrukturę cyfrową do zarządzania nim.';

  @override
  String get pricing_faq5_q => 'Czy mogę anulować w dowolnym momencie?';

  @override
  String get pricing_faq5_a =>
      'Tak. Nie ma umów długoterminowych. Możesz w dowolnym momencie ustawić swój sklep jako „Nieaktywny”.';

  @override
  String get pricing_cta_title => 'Żadnego ryzyka, sama nagroda.';

  @override
  String get pricing_cta_subtitle =>
      'Zacznij przyjmować zamówienia już dziś i płać tylko za wyniki.';

  @override
  String get pricing_cta_primary => 'Dołącz jako partner';

  @override
  String get admin_overview_review => 'Recenzja';

  @override
  String get admin_overview_status_pending => 'Aż do';

  @override
  String get admin_overview_status_processing => 'W toku';

  @override
  String get admin_overview_status_delivered => 'Dostarczony';

  @override
  String get admin_overview_status_cancelled => 'Odwołany';

  @override
  String get requests_action_activate => 'Aktywować';

  @override
  String get requests_action_decline => 'Spadek';

  @override
  String get requests_action_approve => 'Zatwierdzić';

  @override
  String get requests_action_reject => 'Odrzucić';

  @override
  String get requests_action_suspend => 'Wstrzymać';

  @override
  String get requests_action_reinstate => 'Przywracać na stanowisko';

  @override
  String get requests_status_approved => 'Zatwierdzony';

  @override
  String get requests_status_active => 'Aktywny';

  @override
  String get requests_status_rejected => 'Odrzucony';

  @override
  String get requests_status_suspended => 'Zawieszony';

  @override
  String get requests_status_pending => 'Aż do';

  @override
  String get users_banned_badge => 'ZAKAZANY';

  @override
  String get users_action_ban => 'Zablokuj użytkownika';

  @override
  String get users_action_unban => 'Odbanuj użytkownika';

  @override
  String get users_action_delete => 'Usuń użytkownika';

  @override
  String get users_confirm_cancel => 'Anulować';

  @override
  String get users_role_admin => 'Administrator platformy';

  @override
  String get users_role_restaurant => 'Właściciel restauracji';

  @override
  String get users_role_customer => 'Klient';

  @override
  String get users_copied => 'Wartość skopiowana do schowka';

  @override
  String get shell_confirm_cancel => 'Anulować';

  @override
  String get analytics_status_normal => 'Normalna';

  @override
  String get analytics_status_processing => 'Przetwarzanie';

  @override
  String get analytics_status_delivered => 'Dostarczony';

  @override
  String get analytics_status_cancelled => 'Odwołany';

  @override
  String get menus_fab => 'Utwórz menu';

  @override
  String get menus_sheet_title => 'Nowa kategoria menu';

  @override
  String get menus_image_upload_label => 'Baner kategorii';

  @override
  String get menus_field_title_label => 'Nazwa kategorii';

  @override
  String get menus_field_title_required => 'Imię jest wymagane';

  @override
  String get menus_field_desc_label => 'Opis';

  @override
  String get menus_field_desc_required => 'Opis jest wymagany';

  @override
  String get menus_no_image => 'Proszę wybrać obraz banera';

  @override
  String get menus_submit => 'Dodaj kategorię';

  @override
  String get menus_design_view_items => 'Wyświetl elementy';

  @override
  String get menus_design_edit_button => 'Redagować';

  @override
  String get menus_design_edit_sheet_title => 'Edytuj menu';

  @override
  String get menus_design_delete_button => 'Usuwać';

  @override
  String get menus_design_change_image_hint =>
      'Kliknij, aby zmienić obraz banera';

  @override
  String get menus_design_field_title_label => 'Tytuł menu';

  @override
  String get menus_design_field_title_required => 'Proszę wpisać tytuł';

  @override
  String get menus_design_field_desc_label => 'Opis';

  @override
  String get menus_design_field_desc_required => 'Proszę wpisać opis';

  @override
  String get menus_design_save_changes => 'Zapisz zmiany';

  @override
  String get menus_design_saved => 'Menu zaktualizowano pomyślnie';

  @override
  String get menus_design_banner_cleanup_error =>
      'Uwaga: Menu zostało zaktualizowane, ale starego obrazu nie udało się usunąć.';

  @override
  String get menus_design_delete_dialog_title => 'Usunąć menu?';

  @override
  String get menus_design_delete_dialog_body =>
      'Jesteś pewien? To spowoduje trwałe usunięcie tego menu i wszystkich powiązanych z nim danych.';

  @override
  String get menus_design_delete_cancel => 'Anulować';

  @override
  String get menus_design_delete_confirm => 'Usuń trwale';

  @override
  String get menus_design_delete_missing_id =>
      'Błąd: Brak identyfikatorów. Nie można usunąć.';

  @override
  String get menus_design_deleted => 'Menu usunięte';

  @override
  String get items_app_bar_fallback => 'Pozycje menu';

  @override
  String get items_fab => 'Dodaj element';

  @override
  String get items_sheet_title => 'Dodaj nowy element';

  @override
  String get items_image_upload_label => 'Zdjęcie przedmiotu';

  @override
  String get items_image_browse => 'Kliknij, aby przeglądać obrazy';

  @override
  String get items_field_title_label => 'Nazwa przedmiotu';

  @override
  String get items_field_info_label => 'Krótkie informacje';

  @override
  String get items_field_desc_label => 'Pełny opis';

  @override
  String get items_field_price_label => 'Cena bazowa';

  @override
  String get items_field_price_required => 'Cena jest wymagana';

  @override
  String get items_field_price_invalid => 'Wprowadź prawidłową cenę';

  @override
  String get items_field_tags_label => 'Tagi';

  @override
  String get items_discount_label => 'Procent rabatu';

  @override
  String get items_discount_required => 'Wprowadź kwotę rabatu';

  @override
  String get items_discount_invalid => 'Wprowadź 1-100';

  @override
  String get items_no_image => 'Proszę najpierw przesłać obraz';

  @override
  String get items_submit => 'Utwórz element';

  @override
  String get items_design_edit_button => 'Redagować';

  @override
  String get items_design_image_cleanup_error =>
      'Element został zaktualizowany, ale poprzedniego obrazu nie można było usunąć z pamięci.';

  @override
  String get items_design_saved => 'Element zaktualizowany pomyślnie';

  @override
  String get items_design_deleted => 'Element został usunięty';

  @override
  String get items_design_delete_dialog_title => 'Usunąć element?';

  @override
  String get items_design_delete_dialog_body =>
      'Czy na pewno chcesz usunąć ten element? Tej czynności nie można cofnąć.';

  @override
  String get items_design_delete_cancel => 'Anulować';

  @override
  String get items_design_delete_confirm => 'Usuwać';

  @override
  String get items_design_edit_sheet_title => 'Edytuj element';

  @override
  String get items_design_delete_button => 'Usuwać';

  @override
  String get items_design_change_image_hint => 'Kliknij obraz, aby go zmienić';

  @override
  String get items_design_field_title_label => 'Nazwa przedmiotu';

  @override
  String get items_field_title_required => 'Imię jest wymagane';

  @override
  String get items_design_field_info_label => 'Krótkie informacje';

  @override
  String get items_design_field_info_hint => 'np. 500 g, pikantne, wegańskie';

  @override
  String get items_field_info_required =>
      'Wymagane jest podanie krótkich informacji';

  @override
  String get items_design_field_desc_label => 'Opis';

  @override
  String get items_field_desc_required => 'Opis jest wymagany';

  @override
  String get items_design_field_price_label => 'Cena bazowa';

  @override
  String get items_design_field_price_required => 'Cena jest wymagana';

  @override
  String get items_design_field_price_invalid => 'Wprowadź prawidłową cenę';

  @override
  String get items_design_field_tags_label => 'Tagi';

  @override
  String get items_design_field_tags_hint => 'Dodaj tagi (np. Popularne)';

  @override
  String get items_discount_toggle => 'Zaoferuj zniżkę';

  @override
  String get items_design_discount_label => 'Procent rabatu';

  @override
  String get items_design_discount_required => 'Wartość rabatu jest wymagana';

  @override
  String get items_design_discount_invalid => 'Wprowadź wartość od 1 do 100';

  @override
  String get overview_section_glance => 'W SKRÓCIE';

  @override
  String get overview_section_orders => 'Ostatnie zamówienia';

  @override
  String get overview_task_done => 'Zrobione';

  @override
  String get overview_task_setup => 'Organizować coś';

  @override
  String get promo_fab => 'Utwórz promocję';

  @override
  String get promo_badge_live => 'NA ŻYWO';

  @override
  String get promo_badge_inactive => 'NIEAKTYWNY';

  @override
  String get promo_edit_button => 'Zarządzać';

  @override
  String get promo_sheet_add_title => 'Nowa promocja';

  @override
  String get promo_sheet_edit_title => 'Edytuj promocję';

  @override
  String get promo_field_title_label => 'Tytuł kampanii';

  @override
  String get promo_field_title_required => 'Proszę wpisać tytuł';

  @override
  String get promo_field_desc_label => 'Krótki opis';

  @override
  String get promo_field_desc_required => 'Opis jest wymagany';

  @override
  String get promo_date_start => 'Data rozpoczęcia';

  @override
  String get promo_date_end => 'Data zakończenia';

  @override
  String get promo_date_pick => 'Wybierz datę';

  @override
  String get promo_active_toggle => 'Pokaż klientom promocję';

  @override
  String get promo_image_upload_hint => 'Kliknij, aby przesłać baner kampanii';

  @override
  String get promo_image_change_hint => 'Kliknij, aby zmienić baner';

  @override
  String get promo_delete_title => 'Usunąć promocję?';

  @override
  String get promo_delete_body =>
      'Spowoduje to trwałe usunięcie kampanii i jej baneru. Tej czynności nie można cofnąć.';

  @override
  String get promo_delete_cancel => 'Zachowaj to';

  @override
  String get promo_delete_confirm => 'Usuwać';

  @override
  String get promo_no_image =>
      'Do nowych promocji wymagany jest obraz banerowy';

  @override
  String get promo_link_section_label => 'Elementy linku';

  @override
  String get promo_link_section_hint => 'Wybierz produkty objęte tą promocją.';

  @override
  String get promo_image_upload_label => 'Obraz promocyjny';

  @override
  String get promo_save_changes => 'Zapisz zmiany';

  @override
  String get promo_create => 'Promocja wprowadzenia na rynek';

  @override
  String get settings_section_business => 'Szczegóły firmy';

  @override
  String get settings_section_business_sub =>
      'Zarządzaj publiczną tożsamością swojej restauracji.';

  @override
  String get settings_section_profile => 'Profil konta';

  @override
  String get settings_section_profile_sub => 'Twoje dane kontaktowe.';

  @override
  String get settings_section_danger => 'Strefa zagrożenia';

  @override
  String get settings_section_danger_sub =>
      'Nieodwracalne działania na koncie.';

  @override
  String get settings_logo_title => 'Logo restauracji';

  @override
  String get settings_logo_status_staged => 'Wybrano nowe logo';

  @override
  String get settings_logo_status_exists => 'Logo zostało przesłane';

  @override
  String get settings_logo_status_none => 'Brak zestawu logo';

  @override
  String get settings_logo_choose => 'Wybierz obraz';

  @override
  String get settings_logo_upload => 'Zapisz logo';

  @override
  String get settings_logo_success => 'Logo zaktualizowano pomyślnie!';

  @override
  String get settings_banner_title => 'Baner okładkowy';

  @override
  String get settings_banner_choose => 'Kliknij, aby wybrać zdjęcie na okładkę';

  @override
  String get settings_banner_upload => 'Zapisz baner';

  @override
  String get settings_banner_success =>
      'Baner został pomyślnie zaktualizowany!';

  @override
  String get settings_business_title => 'Informacje o sklepie';

  @override
  String get settings_address_pick => 'Przypnij na mapie';

  @override
  String get settings_address_change => 'Zmiana';

  @override
  String get settings_business_saved => 'Zaktualizowano informacje biznesowe!';

  @override
  String get settings_profile_title => 'Właściciel konta';

  @override
  String get settings_profile_photo_ready => 'Nowe zdjęcie gotowe do zapisania';

  @override
  String get settings_profile_phone_label => 'Telefon kontaktowy';

  @override
  String get settings_save_changes => 'Zapisz zmiany';

  @override
  String get settings_cancel => 'Anulować';

  @override
  String get settings_danger_reset_title => 'Zresetuj hasło';

  @override
  String get settings_danger_reset_sub =>
      'Wyślij link umożliwiający zresetowanie hasła na swój adres e-mail.';

  @override
  String get settings_danger_reset_button => 'Nastawić';

  @override
  String get settings_danger_reset_sent =>
      'E-mail z resetem został wysłany! Sprawdź skrzynkę odbiorczą.';

  @override
  String get settings_danger_delete_title => 'Usuń konto';

  @override
  String get settings_danger_delete_sub =>
      'Trwale usuń swoją restaurację i wszystkie dane.';

  @override
  String get settings_danger_delete_button => 'Usuwać';

  @override
  String get settings_danger_delete_dialog_title =>
      'Czy jesteś absolutnie pewien?';

  @override
  String get settings_danger_delete_dialog_body =>
      'Ta czynność jest nieodwracalna. Wszystkie Twoje menu, promocje i historia zostaną usunięte.';

  @override
  String get settings_map_dialog_title => 'Wybierz lokalizację';

  @override
  String get settings_map_no_location =>
      'Nie wybrano jeszcze żadnej lokalizacji.';

  @override
  String get settings_map_open => 'Otwórz mapę';

  @override
  String get settings_map_change => 'Zmień lokalizację';

  @override
  String get settings_map_confirm => 'Potwierdź lokalizację';

  @override
  String get settings_profile_saved => 'Zmiany zostały zapisane';

  @override
  String get how_it_works => 'Jak to działa';

  @override
  String get pricing => 'Wycena';

  @override
  String get getStarted => 'Rozpocznij';

  @override
  String get tapToUploadImage => 'Kliknij, aby przesłać obraz';

  @override
  String get sign_up => 'Zapisać się';

  @override
  String get log_in => 'Zaloguj się';

  @override
  String get sign_in => 'Zalogować się';

  @override
  String get errorEnterEmailOrPassword =>
      'Proszę podać swój adres e-mail i hasło.';

  @override
  String get errorLoginFailed =>
      'Logowanie nieudane. Sprawdź połączenie i dane logowania.';

  @override
  String get error_no_user_record_found =>
      'Nie znaleziono profilu użytkownika. Skontaktuj się z pomocą techniczną.';

  @override
  String get permission_restaurant_accounts_only =>
      'Portal jest przeznaczony wyłącznie dla kont restauracyjnych i administracyjnych.';

  @override
  String get error_no_restaurant_record_found =>
      'Nie znaleziono profilu restauracji dla tego konta.';

  @override
  String get admin_profile => 'Profil administratora';

  @override
  String get info_continue => 'Kontynuować';

  @override
  String get hintConfPassword => 'Potwierdź hasło';

  @override
  String get errorNoMatchPasswords => 'Hasła nie są takie same.';

  @override
  String get orders_today => 'Zamówienia dzisiaj';

  @override
  String get total_orders => 'Łączna liczba zamówień';

  @override
  String get menu_items => 'Pozycje menu';

  @override
  String get upper_features => 'Cechy';

  @override
  String get register_now => 'Zarejestruj się teraz';

  @override
  String get hiw_section_process => 'Proces';

  @override
  String get hiw_section_features => 'Wszystko, czego potrzebujesz';

  @override
  String get hiw_features_title => 'Potężne narzędzia do nowoczesnych kuchni.';
}
