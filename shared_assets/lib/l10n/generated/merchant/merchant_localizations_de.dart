// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'merchant_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class MerchantLocalizationsDe extends MerchantLocalizations {
  MerchantLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get admin_panel => 'Admin-Panel';

  @override
  String get join_requests => 'Beitrittsanfragen';

  @override
  String get edit_sheet_title => 'Bearbeitungsblatt';

  @override
  String get admin_notifications_tab_send => 'Schicken';

  @override
  String get admin_notifications_tab_history => 'Geschichte';

  @override
  String get admin_notifications_target_audience => 'Zielgruppe';

  @override
  String get admin_notifications_audience_all => 'Alle Benutzer';

  @override
  String get admin_notifications_audience_restaurants => 'Restaurants';

  @override
  String get admin_notifications_audience_specific => 'Bestimmte Benutzer';

  @override
  String get admin_notifications_search_hint =>
      'Benutzer anhand des Namens oder der E-Mail-Adresse suchen...';

  @override
  String get admin_notifications_search_hint_more =>
      'Einen weiteren Benutzer hinzufügen...';

  @override
  String get admin_notifications_title_label => 'Benachrichtigungstitel';

  @override
  String get admin_notifications_title_hint => 'Titel eingeben';

  @override
  String get admin_notifications_body_label => 'Nachrichtentext';

  @override
  String get admin_notifications_body_hint => 'Nachricht eingeben';

  @override
  String get admin_notifications_required => 'Dieses Feld ist erforderlich';

  @override
  String get admin_notifications_sending => 'Senden...';

  @override
  String get admin_notifications_send_button => 'Benachrichtigung senden';

  @override
  String get admin_notifications_select_user =>
      'Bitte wählen Sie mindestens einen Benutzer aus.';

  @override
  String get admin_notifications_sent_one =>
      'Benachrichtigung erfolgreich gesendet';

  @override
  String admin_notifications_sent_many(int count) {
    return 'Benachrichtigungen an $count Benutzer gesendet';
  }

  @override
  String get admin_notifications_history_empty =>
      'Bisher keine Benachrichtigungshistorie';

  @override
  String get admin_notifications_history_sent_badge => 'GESENDET';

  @override
  String admin_notifications_history_sent_count(int count) {
    return '$count gesendet';
  }

  @override
  String get admin_overview_platform_glance => 'Plattform im Überblick';

  @override
  String get admin_overview_revenue_30d => 'Umsatz (letzte 30 Tage)';

  @override
  String get admin_overview_pending_requests => 'Ausstehende Beitrittsanfragen';

  @override
  String get admin_overview_view_all => 'Alle anzeigen';

  @override
  String get admin_overview_order_status => 'Bestellstatus';

  @override
  String get admin_overview_top_restaurants => 'Top-Restaurants';

  @override
  String get admin_overview_stat_restaurants => 'Gesamtzahl der Restaurants';

  @override
  String admin_overview_stat_restaurants_sub(int active) {
    return '$active aktiv';
  }

  @override
  String get admin_overview_stat_orders => 'Gesamtbestellungen';

  @override
  String admin_overview_stat_orders_sub(int today) {
    return '$today heute';
  }

  @override
  String get admin_overview_stat_revenue => 'Gesamtertrag';

  @override
  String admin_overview_stat_revenue_sub(String last7d) {
    return '$last7d PLN letzte 7 Tage';
  }

  @override
  String get admin_overview_stat_avg => 'Durchschnittlicher Bestellwert';

  @override
  String admin_overview_stat_avg_sub(int menus, int items) {
    return '$menus Menüs • $items Gerichte';
  }

  @override
  String get admin_overview_revenue_no_data =>
      'Es liegen keine Umsatzdaten vor.';

  @override
  String get admin_overview_no_pending =>
      'Keine ausstehenden Beitrittsanfragen.';

  @override
  String admin_overview_pending_nip(String nip, String date) {
    return 'NIP: $nip • $date';
  }

  @override
  String get admin_overview_no_orders => 'Noch keine Bestellungen.';

  @override
  String get admin_overview_no_order_data =>
      'Es sind keine Bestelldaten verfügbar.';

  @override
  String admin_overview_orders_count(int count) {
    return '$count Bestellungen';
  }

  @override
  String get requests_tab_registrations => 'Anmeldungen';

  @override
  String get requests_tab_go_live => 'Live gehen';

  @override
  String get requests_filter_pending => 'Ausstehend';

  @override
  String get requests_filter_approved => 'Genehmigt';

  @override
  String get requests_filter_active => 'Aktiv';

  @override
  String get requests_filter_rejected => 'Abgelehnt';

  @override
  String get requests_filter_suspended => 'Ausgesetzt';

  @override
  String get requests_filter_all => 'Alle';

  @override
  String requests_empty_filtered(String status) {
    return 'Keine $status Anfragen gefunden.';
  }

  @override
  String get requests_empty_all =>
      'Es wurden keine Registrierungsanfragen gefunden.';

  @override
  String get requests_go_live_empty =>
      'Es wurden keine Go-Live-Anfragen gefunden.';

  @override
  String get requests_go_live_section_pending => 'ÜBERPRÜFUNG AUSSTEHEND';

  @override
  String get requests_go_live_section_reviewed => 'ÜBERPRÜFT';

  @override
  String requests_go_live_requested(String timeAgo, String date) {
    return 'Angefordert $timeAgo ($date)';
  }

  @override
  String get requests_badge_activated => 'Aktiviert';

  @override
  String get requests_badge_declined => 'Abgelehnt';

  @override
  String get requests_badge_pending_review => 'Prüfung ausstehend';

  @override
  String requests_go_live_activated_on(String date) {
    return 'Aktiviert am $date';
  }

  @override
  String requests_go_live_declined_on(String date) {
    return 'Abgelehnt am $date';
  }

  @override
  String get requests_check_logo => 'Logo';

  @override
  String get requests_check_banner => 'Banner';

  @override
  String get requests_check_address => 'Adresse';

  @override
  String get requests_check_iban => 'IBAN';

  @override
  String get requests_check_photo => 'Profilfoto';

  @override
  String get requests_check_menu => 'Menüpunkte';

  @override
  String requests_setup_progress(int completed, int total) {
    return '$completed/$total Setup-Aufgaben';
  }

  @override
  String requests_submitted(String date) {
    return 'Eingereicht $date';
  }

  @override
  String requests_copied(String id) {
    return 'Kopierte ID: $id';
  }

  @override
  String get requests_confirm_approve_title => 'Restaurant genehmigen?';

  @override
  String get requests_confirm_approve_body =>
      'Dies ermöglicht es dem Händler, mit der Einrichtung seiner Menüs und seines Profils zu beginnen.';

  @override
  String get requests_confirm_reject_title => 'Antrag ablehnen?';

  @override
  String get requests_confirm_reject_body =>
      'Dadurch wird dem Händler der Zugriff auf das Dashboard verwehrt. Er wird über die Ablehnung benachrichtigt.';

  @override
  String get requests_confirm_suspend_title => 'Restaurant schließen?';

  @override
  String get requests_confirm_suspend_body =>
      'Dadurch werden das Restaurant und alle seine Artikel sofort von der Plattform ausgeblendet.';

  @override
  String get requests_confirm_reinstate_title => 'Restaurant wieder eröffnen?';

  @override
  String get requests_confirm_reinstate_body =>
      'Dadurch wird das Restaurant wieder in den Status „Aktiv“ versetzt und ist für die Kunden wieder sichtbar.';

  @override
  String get requests_action_copy_id => 'Restaurant-ID kopieren';

  @override
  String requests_error_failed(String error) {
    return 'Vorgang fehlgeschlagen: $error';
  }

  @override
  String get users_search_hint => 'Suche nach Name oder E-Mail-Adresse...';

  @override
  String get users_empty_filtered =>
      'Es wurden keine Benutzer gefunden, die Ihren Filtern entsprechen.';

  @override
  String get users_empty_all => 'Im System wurden keine Benutzer gefunden.';

  @override
  String users_joined(String date) {
    return 'Beigetreten $date';
  }

  @override
  String get users_detail_title => 'Benutzerdetails';

  @override
  String get users_detail_id => 'Benutzer-ID';

  @override
  String get users_detail_phone => 'Telefon';

  @override
  String get users_detail_joined => 'Beigetreten';

  @override
  String get users_detail_role => 'Rolle';

  @override
  String get users_ban_body =>
      'Sind Sie sicher? Dieser Benutzer wird sofort abgemeldet und kann nicht mehr auf sein Konto zugreifen.';

  @override
  String get users_unban_body =>
      'Dadurch wird der Zugriff des Benutzers auf die Plattform wiederhergestellt.';

  @override
  String get users_delete_title => 'Benutzer endgültig löschen?';

  @override
  String get users_delete_body =>
      'Diese Aktion kann nicht rückgängig gemacht werden. Alle Benutzerprofildaten werden aus der Datenbank gelöscht.';

  @override
  String get users_snack_banned => 'Der Benutzer wurde gesperrt.';

  @override
  String get users_snack_unbanned => 'Benutzerzugriff wiederhergestellt.';

  @override
  String get users_snack_deleted => 'Benutzerkonto erfolgreich gelöscht.';

  @override
  String get users_filter_all => 'Alle';

  @override
  String get users_filter_restaurant => 'Restaurants';

  @override
  String get users_filter_admin => 'Administrator';

  @override
  String get users_filter_customer => 'Kunden';

  @override
  String get shell_nav_overview => 'Überblick';

  @override
  String get shell_nav_orders => 'Bestellungen';

  @override
  String get shell_nav_menus => 'Menüs';

  @override
  String get shell_nav_promotions => 'Werbeaktionen';

  @override
  String get shell_nav_analytics => 'Analysen';

  @override
  String get shell_nav_settings => 'Einstellungen';

  @override
  String get shell_restaurant_not_found => 'Restaurantdaten nicht gefunden.';

  @override
  String get shell_finish_setup => 'Einrichtung abschließen';

  @override
  String get shell_my_account => 'Mein Konto';

  @override
  String get shell_menu_support => 'Support-Center';

  @override
  String get shell_menu_sales => 'Vertriebskontakt';

  @override
  String get shell_menu_cookies => 'Cookie-Richtlinie';

  @override
  String get shell_menu_settings => 'App-Einstellungen';

  @override
  String get shell_menu_logout => 'Abmelden';

  @override
  String get shell_already_pending =>
      'Sie haben bereits eine ausstehende Anfrage.';

  @override
  String get shell_go_live_submitted => 'Go-Live-Anfrage eingereicht!';

  @override
  String shell_error(String error) {
    return 'Fehler: $error';
  }

  @override
  String get shell_go_offline_title => 'Offline gehen?';

  @override
  String get shell_go_offline_body =>
      'Ihr Restaurant wird für Kunden auf der Plattform nicht mehr sichtbar sein.';

  @override
  String get shell_go_offline_confirm => 'Ja, offline gehen';

  @override
  String get shell_live_go_offline => 'Live / Offline gehen';

  @override
  String get shell_go_live_pending => 'Anfrage prüfen';

  @override
  String get shell_go_live_declined => 'Abgelehnt – Versuchen Sie es erneut.';

  @override
  String get shell_request_go_live => 'Anfrage zum Livegang';

  @override
  String get gate_pending_title => 'Wird derzeit geprüft';

  @override
  String get gate_pending_message =>
      'Unser Team prüft derzeit Ihr Restaurantprofil. Wir benachrichtigen Sie, sobald es freigegeben wurde.';

  @override
  String get gate_rejected_title => 'Antrag abgelehnt';

  @override
  String get gate_rejected_message =>
      'Leider konnte Ihr Antrag dieses Mal nicht genehmigt werden. Bitte kontaktieren Sie den Support für weitere Informationen.';

  @override
  String get gate_suspended_title => 'Konto gesperrt';

  @override
  String get gate_suspended_message =>
      'Ihr Konto wurde aufgrund eines Verstoßes gegen die Richtlinien gesperrt.';

  @override
  String get gate_default_title => 'Beschränkter Zugriff';

  @override
  String get gate_default_message =>
      'Sie haben noch keine Berechtigung, auf dieses Dashboard zuzugreifen.';

  @override
  String get analytics_section_glance => 'AUF EINEN BLICK';

  @override
  String analytics_stat_revenue(int days) {
    return 'Umsatz (${days}d)';
  }

  @override
  String analytics_stat_orders(int days) {
    return 'Bestellungen (${days}d)';
  }

  @override
  String get analytics_stat_today => 'Heutige Angebote';

  @override
  String get analytics_stat_avg => 'Durchschnittlicher Bestellwert';

  @override
  String get analytics_section_revenue => 'Umsatztrend';

  @override
  String get analytics_no_revenue =>
      'Für diesen Zeitraum liegen keine Umsatzdaten vor.';

  @override
  String get analytics_section_status => 'AUFLEITUNG DES BESTELLSTATUS';

  @override
  String get analytics_no_orders =>
      'Für diesen Zeitraum wurden keine Bestellungen gefunden.';

  @override
  String get analytics_section_popular => 'BELIEBTESTE ARTIKEL';

  @override
  String get analytics_no_items => 'Keine Artikeldaten verfügbar';

  @override
  String analytics_orders_count(int count) {
    return '$count Bestellungen';
  }

  @override
  String menus_error(String error) {
    return 'Menüs konnten nicht geladen werden: $error';
  }

  @override
  String get menus_empty_title => 'Ihr Menü ist leer';

  @override
  String get menus_empty_subtitle =>
      'Erstellen Sie Kategorien wie „Hauptgerichte“ oder „Getränke“, um Ihre Küche zu organisieren.';

  @override
  String get menus_field_title_hint => 'z.B. italienische Pizzen';

  @override
  String get menus_field_desc_hint =>
      'Beschreiben Sie kurz, was in diesem Abschnitt enthalten ist...';

  @override
  String get menus_image_browse =>
      'JPG oder PNG, empfohlenes Seitenverhältnis 16:9';

  @override
  String get menus_created => 'Menükategorie erstellt!';

  @override
  String get menus_updated => 'Die Menükategorie wurde aktualisiert.';

  @override
  String get menus_deleted => 'Die Menükategorie wurde entfernt.';

  @override
  String get menus_image_cleanup_error =>
      'Das Menü wurde gespeichert, aber das alte Banner konnte nicht aus dem Speicher entfernt werden.';

  @override
  String get menus_error_missing_ids =>
      'Erforderliche IDs fehlen. Löschen nicht möglich.';

  @override
  String items_error(String error) {
    return 'Fehler beim Laden der Elemente: $error';
  }

  @override
  String get items_empty_title => 'Hier sind noch keine Artikel.';

  @override
  String get items_empty_subtitle =>
      'Beginnen Sie damit, Ihr erstes Gericht zu dieser Speisekarte hinzuzufügen.';

  @override
  String get items_field_title_hint => 'z. B. Klassischer Cheeseburger';

  @override
  String get items_field_info_hint =>
      'z. B. 200 g Rindfleisch, Cheddar, Essiggurken';

  @override
  String get items_field_desc_hint =>
      'Beschreiben Sie die Zutaten und die Zubereitung...';

  @override
  String get items_field_price_hint => '0,00';

  @override
  String get items_field_tags_hint => 'Vegan, scharf, glutenfrei...';

  @override
  String get items_tag_hint => 'Schlagwörter hinzufügen (z. B. Beliebt)';

  @override
  String get items_added => 'Artikel erfolgreich hinzugefügt';

  @override
  String get items_updated => 'Die Artikeldetails wurden gespeichert.';

  @override
  String get items_deleted => 'Dieser Artikel wurde aus Ihrem Menü entfernt.';

  @override
  String get items_error_no_image => 'Bitte laden Sie zuerst ein Bild hoch.';

  @override
  String get items_tag_error_empty => 'Das Tag darf nicht leer sein.';

  @override
  String get items_tag_error_capitalize =>
      'Der Tag muss mit einem Großbuchstaben beginnen';

  @override
  String get items_tag_error_letters => 'Nur Buchstaben sind erlaubt';

  @override
  String get items_tag_error_duplicate => 'Dieses Tag existiert bereits.';

  @override
  String get items_discount_info => 'z. B. 500 g, scharf, vegan';

  @override
  String get image_cleanup_error =>
      'Das Element wurde gespeichert, aber das alte Bild konnte nicht aus dem Speicher entfernt werden.';

  @override
  String overview_welcome(String name) {
    return 'Willkommen zurück, $name!';
  }

  @override
  String get overview_chef_fallback => 'Küchenchef';

  @override
  String get overview_subtitle =>
      'Hier erfahren Sie, was heute in Ihrem Restaurant passiert.';

  @override
  String get overview_setup_title => 'Schließen Sie die Einrichtung ab.';

  @override
  String overview_setup_progress(int completed, int total) {
    return '11 von 10 Schritten abgeschlossen';
  }

  @override
  String get overview_task_logo_title => 'Logo hochladen';

  @override
  String get overview_task_logo_desc =>
      'Ihre Markenidentität in der Kunden-App.';

  @override
  String get overview_task_banner_title => 'Restaurantbanner';

  @override
  String get overview_task_banner_desc =>
      'Ein hochwertiges Foto Ihres besten Gerichts.';

  @override
  String get overview_task_address_title => 'Geschäftsadresse';

  @override
  String get overview_task_address_desc =>
      'Damit Ihre Kunden wissen, wo sie Sie finden können.';

  @override
  String get overview_task_photo_title => 'Profilfoto';

  @override
  String get overview_task_photo_desc =>
      'Verleihen Sie Ihrem Konto eine persönliche Note.';

  @override
  String get overview_task_menu_title => 'Menüs erstellen';

  @override
  String get overview_task_menu_desc =>
      'Fügen Sie mindestens eine Menükategorie und einen Menüpunkt hinzu.';

  @override
  String get overview_task_iban_title => 'Auszahlungsdetails';

  @override
  String get overview_task_iban_desc =>
      'Geben Sie Ihre IBAN ein, um Ihre wöchentlichen Auszahlungen zu erhalten.';

  @override
  String get overview_stat_total_orders => 'Gesamtbestellungen';

  @override
  String get overview_stat_pending => 'Ausstehend';

  @override
  String get overview_stat_completed => 'Vollendet';

  @override
  String get overview_stat_revenue => 'Gesamtertrag';

  @override
  String get promo_empty_title => 'Keine aktiven Werbeaktionen';

  @override
  String get promo_empty_subtitle =>
      'Erstellen Sie Ihre erste Kampagne, um die Sichtbarkeit Ihres Restaurants zu steigern.';

  @override
  String get promo_field_title_hint => 'z.B. Sommerburgerfest';

  @override
  String get promo_field_desc_hint =>
      'Erklären Sie Ihren Kunden das Angebot...';

  @override
  String promo_items_linked(int count) {
    return '$count Verknüpfter Artikel';
  }

  @override
  String promo_items_linked_plural(int count) {
    return '$count Verlinkte Elemente';
  }

  @override
  String get promo_date_order_error =>
      'Das Enddatum muss nach dem Startdatum liegen.';

  @override
  String get promo_no_dates =>
      'Bitte wählen Sie sowohl das Start- als auch das Enddatum aus.';

  @override
  String get promo_created => 'Die Werbeaktion wurde erfolgreich gestartet!';

  @override
  String get promo_updated => 'Die Aktionsdetails wurden aktualisiert.';

  @override
  String get promo_deleted => 'Werbeaktion entfernt.';

  @override
  String get promo_banner_cleanup_error =>
      'Hinweis: Das alte Image konnte nicht aus dem Speicher entfernt werden.';

  @override
  String get promo_error_no_image =>
      'Für neue Werbeaktionen wird ein Bannerbild benötigt.';

  @override
  String get promo_link_no_items =>
      'In Ihren Menüs wurden keine Artikel gefunden.';

  @override
  String get promo_image_recommended => 'Empfohlenes Verhältnis 16:9';

  @override
  String get settings_error =>
      'Die Einstellungen konnten nicht geladen werden. Bitte versuchen Sie es erneut.';

  @override
  String get settings_logo_recommended =>
      'Quadratisches PNG oder JPG (mind. 512x512px)';

  @override
  String get settings_logo_uploading => 'Wird hochgeladen...';

  @override
  String get settings_logo_updated => 'Das Restaurantlogo wurde aktualisiert.';

  @override
  String get settings_banner_recommended =>
      'Breites 16:9-Seitenverhältnis empfohlen';

  @override
  String get settings_banner_updated => 'Das Titelbild wurde aktualisiert.';

  @override
  String get settings_business_updated =>
      'Die Geschäftsinformationen wurden gespeichert.';

  @override
  String get settings_profile_updated => 'Profiländerungen wurden gespeichert.';

  @override
  String get settings_password_reset_sent =>
      'Ein Link zum Zurücksetzen Ihres Passworts wurde an Ihre E-Mail-Adresse gesendet.';

  @override
  String get settings_delete_dialog_title => 'Sind Sie sich absolut sicher?';

  @override
  String get settings_delete_dialog_body =>
      'Diese Aktion ist unumkehrbar. Sämtliche Menüs, Werbeaktionen und der gesamte Verlauf werden gelöscht.';

  @override
  String get settings_address_set => 'Noch keine Adresse festgelegt';

  @override
  String get settings_map_no_pick =>
      'Bitte wählen Sie zuerst einen Ort auf der Karte aus.';

  @override
  String get settings_profile_name_hint => 'Vollständiger Name';

  @override
  String get build_user_experience =>
      'Gestalten Sie die nächste Generation von kulinarischen Erlebnissen.';

  @override
  String get join_thousands =>
      'Schließen Sie sich Tausenden von Restaurants an, die ihr Geschäft mit unserer Plattform ausbauen.';

  @override
  String get sign_in_to_dashboard => 'Im Dashboard anmelden';

  @override
  String get create_your_account => 'Erstellen Sie Ihr Konto';

  @override
  String get new_to_the_platform => 'Neu auf der Plattform?';

  @override
  String get already_have_an_account => 'Sie haben bereits ein Konto?';

  @override
  String get with_google => 'mit Google';

  @override
  String get terms_of_service =>
      'Indem Sie fortfahren, stimmen Sie unseren Nutzungsbedingungen und Datenschutzbestimmungen zu.';

  @override
  String get errorNoUserRecord =>
      'Es wurde kein Benutzerprofil gefunden. Bitte wenden Sie sich an den Support.';

  @override
  String get errorRestaurantAccountOnly =>
      'Dieses Portal ist ausschließlich für Restaurant- und Administratorkonten bestimmt.';

  @override
  String get errorNoRestaurantRecord =>
      'Für dieses Konto wurde kein Restaurant-Unternehmensprofil gefunden.';

  @override
  String get hintEmail => 'E-Mail-Adresse';

  @override
  String get hintPassword => 'Passwort';

  @override
  String get business => 'Geschäft';

  @override
  String get business_name => 'Firmenname';

  @override
  String get business_phone => 'Geschäftstelefon';

  @override
  String get owner_full_name => 'Vollständiger Name des Eigentümers';

  @override
  String get owner_phone => 'Inhaber-Telefonnummer';

  @override
  String get creating_partner_account => 'Partnerkonto wird erstellt...';

  @override
  String get account_is_pending_approval =>
      'Registrierung erfolgreich! Ihr Konto wartet nun auf Genehmigung.';

  @override
  String get now_live_in => 'Ich lebe jetzt in Krakau und Warschau.';

  @override
  String get put_your_restaurant_on =>
      'Tragen Sie Ihr Restaurant in die digitale Karte ein.';

  @override
  String get manage_your_menu =>
      'Verwalten Sie Ihre Speisekarte, verfolgen Sie Live-Verkäufe und erweitern Sie Ihren Kundenstamm mit unserem All-in-One-Händler-Dashboard.';

  @override
  String get register_your_restaurant => 'Registrieren Sie Ihr Restaurant';

  @override
  String get see_how_it_works => 'So funktioniert es';

  @override
  String get live_platform_stats => 'LIVE-PLATTFORMSTATISTIKEN';

  @override
  String get restaurants_on_platform => 'Restaurants auf dem Bahnsteig';

  @override
  String get orders_placed => 'Bestellungen aufgegeben';

  @override
  String get menus_published => 'veröffentlichte Menüs';

  @override
  String get items_available => 'Verfügbare Artikel';

  @override
  String get trusted_by_restaurants =>
      'VON MEHR ALS 200 LOKALEN RESTAURANTS VERTRAUT';

  @override
  String get digital_menu => 'Digitales Menü';

  @override
  String get your_menu_goes_live_instantly =>
      'Ihre Speisekarte wird sofort auf unserer Kundenplattform veröffentlicht.';

  @override
  String get custom_banners => 'Individuelle Banner';

  @override
  String get full_creative_control =>
      'Volle kreative Kontrolle über die visuelle Identität Ihres Geschäfts.';

  @override
  String get sales_analytics => 'Vertriebsanalyse';

  @override
  String get track_peak_hours =>
      'Verfolgen Sie Spitzenzeiten und Verkaufsschlager in Echtzeit.';

  @override
  String get ready_to_grow => 'Bereit für Umsatzwachstum?';

  @override
  String get join_restaurants =>
      'Schließen Sie sich den Restaurants an, die bereits auf unserer Plattform erfolgreich sind.';

  @override
  String get hiw_title => 'So funktioniert es';

  @override
  String get hiw_hero_badge => 'Einfaches Onboarding';

  @override
  String get hiw_hero_title =>
      'Noch nie war es einfacher, Ihre Küche online zu stellen.';

  @override
  String get hiw_hero_subtitle =>
      'Von der Registrierung bis zu Ihrer ersten Bestellung haben wir jeden Schritt optimiert, damit Sie innerhalb von Tagen, nicht Wochen, startklar sind.';

  @override
  String get hiw_step1_title => 'Benutzerkonto erstellen';

  @override
  String get hiw_step1_desc =>
      'Registrieren Sie sich mit Ihren Geschäftsdaten (NIP/REGON) und den Informationen zum Inhaber.';

  @override
  String get hiw_step2_title => 'Administratorverifizierung';

  @override
  String get hiw_step2_desc =>
      'Unser Team prüft Ihre Bewerbung, um die Sicherheit und die Einhaltung der Qualitätsstandards der Plattform zu gewährleisten.';

  @override
  String get hiw_step3_title => 'Richten Sie Ihren Shop ein';

  @override
  String get hiw_step3_desc =>
      'Laden Sie Ihr Logo hoch, legen Sie Ihre Öffnungszeiten fest und definieren Sie Ihre Liefergebiete.';

  @override
  String get hiw_step4_title => 'Stellen Sie Ihr Menü zusammen';

  @override
  String get hiw_step4_desc =>
      'Fügen Sie Kategorien, Artikel und Modifikatoren hinzu. Nutzen Sie unsere KI-Tools für hochwertige Beschreibungen.';

  @override
  String get hiw_step5_title => 'Live gehen';

  @override
  String get hiw_step5_desc =>
      'Stellen Sie Ihren Status auf aktiv und erhalten Sie Bestellungen von Kunden aus Ihrer Umgebung.';

  @override
  String get hiw_feature1_title => 'Echtzeit-Synchronisierung';

  @override
  String get hiw_feature1_desc =>
      'Menüaktualisierungen werden ohne Verzögerung sofort in der Kunden-App angezeigt.';

  @override
  String get hiw_feature2_title => 'Detaillierte Analysen';

  @override
  String get hiw_feature2_desc =>
      'Verfolgen Sie Ihre Bestseller und Spitzenzeiten, um Ihren Personal- und Lagerbestand zu optimieren.';

  @override
  String get hiw_feature3_title => 'Bildverwaltung';

  @override
  String get hiw_feature3_desc =>
      'Integrierter Cloud-Speicher für all Ihre hochauflösenden Food-Fotografien.';

  @override
  String get hiw_feature4_title => 'Rollenbasierter Zugriff';

  @override
  String get hiw_feature4_desc =>
      'Berechtigungen für Eigentümer, Manager und Küchenpersonal sicher verwalten.';

  @override
  String get hiw_feature5_title => 'Mehrere Geräte';

  @override
  String get hiw_feature5_desc =>
      'Verwalten Sie Ihr Restaurant nahtlos von einem Desktop-Computer, Tablet oder Mobiltelefon aus.';

  @override
  String get hiw_feature6_title => '24/7-Support';

  @override
  String get hiw_feature6_desc =>
      'Unser Händlererfolgsteam steht Ihnen jederzeit zur Verfügung, um Sie beim Wachstum zu unterstützen.';

  @override
  String get hiw_cta_title => 'Bereit für Umsatzwachstum?';

  @override
  String get hiw_cta_subtitle =>
      'Werden Sie noch heute Teil unserer Gemeinschaft erfolgreicher Restaurants.';

  @override
  String get hiw_cta_primary => 'Kostenlos starten';

  @override
  String get hiw_cta_secondary => 'Preise ansehen';

  @override
  String get pricing_title => 'Preisgestaltung';

  @override
  String get pricing_hero_badge => 'Transparente Gebühren';

  @override
  String get pricing_hero_title => 'Erweitern Sie Ihr Geschäft ohne Fixkosten.';

  @override
  String get pricing_hero_subtitle =>
      'Unser Erfolg hängt von Ihrem Erfolg ab. Keine Einrichtungsgebühren, keine monatlichen Abonnements – nur eine einfache Provision auf Ihre Umsätze.';

  @override
  String get pricing_step1_title => 'Kundenbestellungen';

  @override
  String get pricing_step1_desc =>
      'Bestellungen werden über unsere sichere Kundenplattform aufgegeben.';

  @override
  String get pricing_step2_title => 'Sie bereiten sich vor';

  @override
  String get pricing_step2_desc =>
      'Leite die Küche und behalte 100 % des Trinkgelds.';

  @override
  String get pricing_step3_title => 'Wöchentliche Auszahlungen';

  @override
  String get pricing_step3_desc =>
      'Die Gelder werden abzüglich unserer geringen Bearbeitungsgebühr eingezahlt.';

  @override
  String get pricing_calculator_title => 'Schätzen Sie Ihren Verdienst.';

  @override
  String get pricing_slider_orders_label => 'Bestellungen pro Tag';

  @override
  String pricing_slider_orders_value(int count, int monthly) {
    return '$count Bestellungen ($monthly / Monat)';
  }

  @override
  String get pricing_slider_avg_label => 'Durchschnittlicher Bestellwert';

  @override
  String pricing_tier_badge(String name, String pct) {
    return '$name Stufe ($pct)';
  }

  @override
  String pricing_tier_monthly(int count) {
    return '$count monatliche Bestellungen';
  }

  @override
  String get pricing_calc_revenue_label => 'Tageseinnahmen';

  @override
  String get pricing_calc_revenue_sub => 'Bruttoumsatz';

  @override
  String pricing_calc_fee_label(String pct) {
    return 'Plattformgebühr ($pct)';
  }

  @override
  String get pricing_tier_starter_range => '0–100 Bestellungen';

  @override
  String get pricing_tier_growing_range => '101–500 Bestellungen';

  @override
  String get pricing_tier_established_range => '501–1500 Bestellungen';

  @override
  String get pricing_tier_partner_range => 'Mehr als 1500 Bestellungen';

  @override
  String get pricing_calc_fee_sub => 'Unsere Provision';

  @override
  String get pricing_calc_keep_label => 'Du behältst';

  @override
  String get pricing_calc_disclaimer =>
      'Schätzungen basieren auf den aktuellen Tarifen. Zahlungsabwicklungsgebühren sind nicht enthalten.';

  @override
  String get pricing_tiers_title =>
      'Je mehr Sie verkaufen, desto weniger zahlen Sie.';

  @override
  String get pricing_tiers_subtitle =>
      'Die Provisionssätze werden automatisch auf Basis Ihres Bestellvolumens der letzten 30 Tage angepasst.';

  @override
  String get pricing_tier_starter_label => 'Anlasser';

  @override
  String get pricing_tier_starter_desc =>
      'Perfekt für neue Restaurants und Pop-up-Küchen.';

  @override
  String get pricing_tier_growing_label => 'Anbau';

  @override
  String get pricing_tier_growing_desc =>
      'Für lokale Favoriten, die ihren Lieferservice ausweiten.';

  @override
  String get pricing_tier_established_label => 'Gegründet';

  @override
  String get pricing_tier_established_desc =>
      'Etablissements mit hohem Besucheraufkommen und einer treuen Anhängerschaft.';

  @override
  String get pricing_tier_partner_label => 'Partner';

  @override
  String get pricing_tier_partner_desc =>
      'Tiefe Integration für stadtweite Restaurantketten.';

  @override
  String get pricing_faq1_q => 'Gibt es versteckte monatliche Gebühren?';

  @override
  String get pricing_faq1_a =>
      'Nein. Es fallen keine monatlichen Wartungs- oder Abonnementgebühren an. Sie zahlen lediglich eine Provision auf abgeschlossene Bestellungen.';

  @override
  String get pricing_faq2_q => 'Wie oft werde ich bezahlt?';

  @override
  String get pricing_faq2_a =>
      'Die Auszahlungen erfolgen wöchentlich dienstags für alle in der Vorwoche abgeschlossenen Bestellungen.';

  @override
  String get pricing_faq3_q =>
      'Muss ich für stornierte Bestellungen eine Provision zahlen?';

  @override
  String get pricing_faq3_a =>
      'Nein. Wenn eine Bestellung storniert und dem Kunden der Betrag zurückerstattet wird, wird keine Provision erhoben.';

  @override
  String get pricing_faq4_q => 'Wer übernimmt die Auslieferung?';

  @override
  String get pricing_faq4_a =>
      'Dieser Plan setzt voraus, dass Sie Ihr eigenes Lieferpersonal stellen. Wir stellen die digitale Infrastruktur für dessen Verwaltung bereit.';

  @override
  String get pricing_faq5_q => 'Kann ich jederzeit kündigen?';

  @override
  String get pricing_faq5_a =>
      'Ja. Es gibt keine langfristigen Verträge. Sie können Ihren Shop jederzeit auf „Inaktiv“ stellen.';

  @override
  String get pricing_cta_title => 'Kein Risiko, nur Gewinn.';

  @override
  String get pricing_cta_subtitle =>
      'Erhalten Sie noch heute Bestellungen und zahlen Sie nur für Ergebnisse.';

  @override
  String get pricing_cta_primary => 'Werden Sie Partner';

  @override
  String get admin_overview_review => 'Rezension';

  @override
  String get admin_overview_status_pending => 'Ausstehend';

  @override
  String get admin_overview_status_processing => 'Im Gange';

  @override
  String get admin_overview_status_delivered => 'Geliefert';

  @override
  String get admin_overview_status_cancelled => 'Abgesagt';

  @override
  String get requests_action_activate => 'Aktivieren';

  @override
  String get requests_action_decline => 'Abfall';

  @override
  String get requests_action_approve => 'Genehmigen';

  @override
  String get requests_action_reject => 'Ablehnen';

  @override
  String get requests_action_suspend => 'Aussetzen';

  @override
  String get requests_action_reinstate => 'Wiedereinsetzen';

  @override
  String get requests_status_approved => 'Genehmigt';

  @override
  String get requests_status_active => 'Aktiv';

  @override
  String get requests_status_rejected => 'Abgelehnt';

  @override
  String get requests_status_suspended => 'Ausgesetzt';

  @override
  String get requests_status_pending => 'Ausstehend';

  @override
  String get users_banned_badge => 'VERBOTEN';

  @override
  String get users_action_ban => 'Benutzer sperren';

  @override
  String get users_action_unban => 'Benutzer entsperren';

  @override
  String get users_action_delete => 'Benutzer löschen';

  @override
  String get users_confirm_cancel => 'Stornieren';

  @override
  String get users_role_admin => 'Plattformadministrator';

  @override
  String get users_role_restaurant => 'Restaurantbesitzer';

  @override
  String get users_role_customer => 'Kunde';

  @override
  String get users_copied => 'Wert in die Zwischenablage kopiert';

  @override
  String get shell_confirm_cancel => 'Stornieren';

  @override
  String get analytics_status_normal => 'Normal';

  @override
  String get analytics_status_processing => 'Verarbeitung';

  @override
  String get analytics_status_delivered => 'Geliefert';

  @override
  String get analytics_status_cancelled => 'Abgesagt';

  @override
  String get menus_fab => 'Menü erstellen';

  @override
  String get menus_sheet_title => 'Neue Menükategorie';

  @override
  String get menus_image_upload_label => 'Kategoriebanner';

  @override
  String get menus_field_title_label => 'Kategoriename';

  @override
  String get menus_field_title_required => 'Name erforderlich';

  @override
  String get menus_field_desc_label => 'Beschreibung';

  @override
  String get menus_field_desc_required => 'Eine Beschreibung ist erforderlich.';

  @override
  String get menus_no_image => 'Bitte wählen Sie ein Bannerbild aus.';

  @override
  String get menus_submit => 'Kategorie hinzufügen';

  @override
  String get menus_design_view_items => 'Artikel ansehen';

  @override
  String get menus_design_edit_button => 'Bearbeiten';

  @override
  String get menus_design_edit_sheet_title => 'Menü bearbeiten';

  @override
  String get menus_design_delete_button => 'Löschen';

  @override
  String get menus_design_change_image_hint =>
      'Tippen Sie hier, um das Bannerbild zu ändern.';

  @override
  String get menus_design_field_title_label => 'Menütitel';

  @override
  String get menus_design_field_title_required =>
      'Bitte geben Sie einen Titel ein.';

  @override
  String get menus_design_field_desc_label => 'Beschreibung';

  @override
  String get menus_design_field_desc_required =>
      'Bitte geben Sie eine Beschreibung ein';

  @override
  String get menus_design_save_changes => 'Änderungen speichern';

  @override
  String get menus_design_saved => 'Menü erfolgreich aktualisiert';

  @override
  String get menus_design_banner_cleanup_error =>
      'Hinweis: Das Menü wurde aktualisiert, das alte Bild konnte jedoch nicht entfernt werden.';

  @override
  String get menus_design_delete_dialog_title => 'Menü löschen?';

  @override
  String get menus_design_delete_dialog_body =>
      'Sind Sie sicher? Dadurch werden dieses Menü und alle zugehörigen Daten endgültig gelöscht.';

  @override
  String get menus_design_delete_cancel => 'Stornieren';

  @override
  String get menus_design_delete_confirm => 'Endgültig löschen';

  @override
  String get menus_design_delete_missing_id =>
      'Fehler: Fehlende IDs. Kann nicht gelöscht werden.';

  @override
  String get menus_design_deleted => 'Menü gelöscht';

  @override
  String get items_app_bar_fallback => 'Menüpunkte';

  @override
  String get items_fab => 'Artikel hinzufügen';

  @override
  String get items_sheet_title => 'Neuen Artikel hinzufügen';

  @override
  String get items_image_upload_label => 'Artikelfoto';

  @override
  String get items_image_browse => 'Tippen Sie, um Bilder anzusehen';

  @override
  String get items_field_title_label => 'Artikelname';

  @override
  String get items_field_info_label => 'Kurzinfo';

  @override
  String get items_field_desc_label => 'Vollständige Beschreibung';

  @override
  String get items_field_price_label => 'Grundpreis';

  @override
  String get items_field_price_required => 'Preis erforderlich';

  @override
  String get items_field_price_invalid => 'Geben Sie einen gültigen Preis ein';

  @override
  String get items_field_tags_label => 'Tags';

  @override
  String get items_discount_label => 'Rabattprozentsatz';

  @override
  String get items_discount_required => 'Geben Sie den Rabattbetrag ein';

  @override
  String get items_discount_invalid => 'Geben Sie 1-100 ein';

  @override
  String get items_no_image => 'Bitte laden Sie zuerst ein Bild hoch.';

  @override
  String get items_submit => 'Element erstellen';

  @override
  String get items_design_edit_button => 'Bearbeiten';

  @override
  String get items_design_image_cleanup_error =>
      'Der Artikel wurde aktualisiert, aber das vorherige Bild konnte nicht aus dem Speicher gelöscht werden.';

  @override
  String get items_design_saved => 'Artikel erfolgreich aktualisiert';

  @override
  String get items_design_deleted => 'Der Artikel wurde entfernt.';

  @override
  String get items_design_delete_dialog_title => 'Element löschen?';

  @override
  String get items_design_delete_dialog_body =>
      'Sind Sie sicher, dass Sie diesen Eintrag löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get items_design_delete_cancel => 'Stornieren';

  @override
  String get items_design_delete_confirm => 'Löschen';

  @override
  String get items_design_edit_sheet_title => 'Element bearbeiten';

  @override
  String get items_design_delete_button => 'Löschen';

  @override
  String get items_design_change_image_hint =>
      'Tippe auf das Bild, um es zu ändern.';

  @override
  String get items_design_field_title_label => 'Artikelname';

  @override
  String get items_field_title_required => 'Name erforderlich';

  @override
  String get items_design_field_info_label => 'Kurzinfo';

  @override
  String get items_design_field_info_hint => 'z. B. 500 g, scharf, vegan';

  @override
  String get items_field_info_required => 'Kurze Informationen genügen.';

  @override
  String get items_design_field_desc_label => 'Beschreibung';

  @override
  String get items_field_desc_required => 'Eine Beschreibung ist erforderlich.';

  @override
  String get items_design_field_price_label => 'Grundpreis';

  @override
  String get items_design_field_price_required => 'Preis erforderlich';

  @override
  String get items_design_field_price_invalid =>
      'Geben Sie einen gültigen Preis ein';

  @override
  String get items_design_field_tags_label => 'Tags';

  @override
  String get items_design_field_tags_hint =>
      'Schlagwörter hinzufügen (z. B. Beliebt)';

  @override
  String get items_discount_toggle => 'Bieten Sie einen Rabatt an';

  @override
  String get items_design_discount_label => 'Rabattprozentsatz';

  @override
  String get items_design_discount_required => 'Der Rabattwert wird benötigt';

  @override
  String get items_design_discount_invalid =>
      'Geben Sie einen Wert zwischen 1 und 100 ein.';

  @override
  String get overview_section_glance => 'AUF EINEN BLICK';

  @override
  String get overview_section_orders => 'Aktuelle Bestellungen';

  @override
  String get overview_task_done => 'Erledigt';

  @override
  String get overview_task_setup => 'Aufstellen';

  @override
  String get promo_fab => 'Aktion erstellen';

  @override
  String get promo_badge_live => 'LIVE';

  @override
  String get promo_badge_inactive => 'INAKTIV';

  @override
  String get promo_edit_button => 'Verwalten';

  @override
  String get promo_sheet_add_title => 'Neue Aktion';

  @override
  String get promo_sheet_edit_title => 'Aktion bearbeiten';

  @override
  String get promo_field_title_label => 'Kampagnentitel';

  @override
  String get promo_field_title_required => 'Bitte geben Sie einen Titel ein.';

  @override
  String get promo_field_desc_label => 'Kurzbeschreibung';

  @override
  String get promo_field_desc_required => 'Eine Beschreibung ist erforderlich.';

  @override
  String get promo_date_start => 'Startdatum';

  @override
  String get promo_date_end => 'Enddatum';

  @override
  String get promo_date_pick => 'Datum auswählen';

  @override
  String get promo_active_toggle => 'Werbeaktion den Kunden präsentieren';

  @override
  String get promo_image_upload_hint =>
      'Tippen Sie hier, um ein Kampagnenbanner hochzuladen.';

  @override
  String get promo_image_change_hint =>
      'Tippen Sie hier, um das Banner zu ändern.';

  @override
  String get promo_delete_title => 'Werbeaktion löschen?';

  @override
  String get promo_delete_body =>
      'Die Kampagne und ihr Banner werden dadurch dauerhaft entfernt. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get promo_delete_cancel => 'Behalte es';

  @override
  String get promo_delete_confirm => 'Löschen';

  @override
  String get promo_no_image =>
      'Für neue Werbeaktionen wird ein Bannerbild benötigt.';

  @override
  String get promo_link_section_label => 'Link-Elemente';

  @override
  String get promo_link_section_hint =>
      'Wählen Sie die Artikel aus, die zu dieser Werbeaktion gehören.';

  @override
  String get promo_image_upload_label => 'Werbebild';

  @override
  String get promo_save_changes => 'Änderungen speichern';

  @override
  String get promo_create => 'Einführungsaktion';

  @override
  String get settings_section_business => 'Geschäftsdetails';

  @override
  String get settings_section_business_sub =>
      'Verwalten Sie die öffentliche Identität Ihres Restaurants.';

  @override
  String get settings_section_profile => 'Kontoprofil';

  @override
  String get settings_section_profile_sub => 'Ihre persönlichen Kontaktdaten.';

  @override
  String get settings_section_danger => 'Gefahrenzone';

  @override
  String get settings_section_danger_sub => 'Unwiderrufliche Kontoaktionen.';

  @override
  String get settings_logo_title => 'Restaurantlogo';

  @override
  String get settings_logo_status_staged => 'Neues Logo ausgewählt';

  @override
  String get settings_logo_status_exists => 'Logo hochgeladen';

  @override
  String get settings_logo_status_none => 'Kein Logo festgelegt';

  @override
  String get settings_logo_choose => 'Bild auswählen';

  @override
  String get settings_logo_upload => 'Logo speichern';

  @override
  String get settings_logo_success => 'Logo erfolgreich aktualisiert!';

  @override
  String get settings_banner_title => 'Titelbanner';

  @override
  String get settings_banner_choose =>
      'Tippen Sie hier, um ein Titelbild auszuwählen.';

  @override
  String get settings_banner_upload => 'Banner speichern';

  @override
  String get settings_banner_success => 'Banner erfolgreich aktualisiert!';

  @override
  String get settings_business_title => 'Informationen speichern';

  @override
  String get settings_address_pick => 'Auf Karte markieren';

  @override
  String get settings_address_change => 'Ändern';

  @override
  String get settings_business_saved => 'Geschäftsinformationen aktualisiert!';

  @override
  String get settings_profile_title => 'Kontoinhaber';

  @override
  String get settings_profile_photo_ready => 'Neues Foto zum Speichern bereit';

  @override
  String get settings_profile_phone_label => 'Telefonnummer';

  @override
  String get settings_save_changes => 'Änderungen speichern';

  @override
  String get settings_cancel => 'Stornieren';

  @override
  String get settings_danger_reset_title => 'Passwort zurücksetzen';

  @override
  String get settings_danger_reset_sub =>
      'Senden Sie einen Link zum Zurücksetzen Ihres Passworts an Ihre E-Mail-Adresse.';

  @override
  String get settings_danger_reset_button => 'Zurücksetzen';

  @override
  String get settings_danger_reset_sent =>
      'E-Mail mit dem Reset-Link wurde gesendet! Bitte überprüfen Sie Ihren Posteingang.';

  @override
  String get settings_danger_delete_title => 'Konto löschen';

  @override
  String get settings_danger_delete_sub =>
      'Ihr Restaurant und alle zugehörigen Daten werden dauerhaft entfernt.';

  @override
  String get settings_danger_delete_button => 'Löschen';

  @override
  String get settings_danger_delete_dialog_title =>
      'Sind Sie sich absolut sicher?';

  @override
  String get settings_danger_delete_dialog_body =>
      'Diese Aktion ist unumkehrbar. Sämtliche Menüs, Werbeaktionen und der gesamte Verlauf werden gelöscht.';

  @override
  String get settings_map_dialog_title => 'Standort auswählen';

  @override
  String get settings_map_no_location =>
      'Es wurde noch kein Standort ausgewählt.';

  @override
  String get settings_map_open => 'Karte öffnen';

  @override
  String get settings_map_change => 'Standort ändern';

  @override
  String get settings_map_confirm => 'Standort bestätigen';

  @override
  String get settings_profile_saved => 'Die Änderungen wurden gespeichert';

  @override
  String get how_it_works => 'So funktioniert es';

  @override
  String get pricing => 'Preisgestaltung';

  @override
  String get getStarted => 'Los geht\'s';

  @override
  String get tapToUploadImage => 'Tippen Sie hier, um ein Bild hochzuladen.';

  @override
  String get sign_up => 'Melden Sie sich an';

  @override
  String get log_in => 'Einloggen';

  @override
  String get sign_in => 'anmelden';

  @override
  String get errorEnterEmailOrPassword =>
      'Bitte geben Sie Ihre E-Mail-Adresse und Ihr Passwort ein.';

  @override
  String get errorLoginFailed =>
      'Anmeldung fehlgeschlagen. Bitte überprüfen Sie Ihre Verbindung oder Ihre Zugangsdaten.';

  @override
  String get error_no_user_record_found =>
      'Es wurde kein Benutzerprofil gefunden. Bitte wenden Sie sich an den Support.';

  @override
  String get permission_restaurant_accounts_only =>
      'Dieses Portal ist ausschließlich für Restaurant- und Administratorkonten bestimmt.';

  @override
  String get error_no_restaurant_record_found =>
      'Für dieses Konto wurde kein Restaurant-Unternehmensprofil gefunden.';

  @override
  String get admin_profile => 'Administratorprofil';

  @override
  String get info_continue => 'Weitermachen';

  @override
  String get hintConfPassword => 'Passwort bestätigen';

  @override
  String get errorNoMatchPasswords => 'Die Passwörter stimmen nicht überein.';

  @override
  String get orders_today => 'Heute bestellen';

  @override
  String get total_orders => 'Gesamtbestellungen';

  @override
  String get menu_items => 'Menüpunkte';

  @override
  String get upper_features => 'Merkmale';

  @override
  String get register_now => 'Jetzt registrieren';

  @override
  String get hiw_section_process => 'Der Prozess';

  @override
  String get hiw_section_features => 'Alles, was Sie brauchen';

  @override
  String get hiw_features_title => 'Leistungsstarke Geräte für moderne Küchen.';
}
