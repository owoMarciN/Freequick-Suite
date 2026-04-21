// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'merchant_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class MerchantLocalizationsUk extends MerchantLocalizations {
  MerchantLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get admin_panel => 'Панель адміністратора';

  @override
  String get join_requests => 'Запити на приєднання';

  @override
  String get edit_sheet_title => 'Редагувати аркуш';

  @override
  String get admin_notifications_tab_send => 'Надіслати';

  @override
  String get admin_notifications_tab_history => 'Історія';

  @override
  String get admin_notifications_target_audience => 'Цільова аудиторія';

  @override
  String get admin_notifications_audience_all => 'Усі користувачі';

  @override
  String get admin_notifications_audience_restaurants => 'Ресторани';

  @override
  String get admin_notifications_audience_specific => 'Конкретні користувачі';

  @override
  String get admin_notifications_search_hint =>
      'Пошук користувачів за іменем або електронною поштою...';

  @override
  String get admin_notifications_search_hint_more =>
      'Додати ще одного користувача...';

  @override
  String get admin_notifications_title_label => 'Заголовок сповіщення';

  @override
  String get admin_notifications_title_hint => 'Введіть назву';

  @override
  String get admin_notifications_body_label => 'Текст повідомлення';

  @override
  String get admin_notifications_body_hint => 'Введіть повідомлення';

  @override
  String get admin_notifications_required => 'Це поле обов\'язкове';

  @override
  String get admin_notifications_sending => 'Надсилання...';

  @override
  String get admin_notifications_send_button => 'Надіслати сповіщення';

  @override
  String get admin_notifications_select_user =>
      'Будь ласка, виберіть принаймні одного користувача';

  @override
  String get admin_notifications_sent_one => 'Сповіщення успішно надіслано';

  @override
  String admin_notifications_sent_many(int count) {
    return 'Сповіщення надіслано $count користувачам';
  }

  @override
  String get admin_notifications_history_empty =>
      'Історії сповіщень поки що немає';

  @override
  String get admin_notifications_history_sent_badge => 'НАДІСЛАНО';

  @override
  String admin_notifications_history_sent_count(int count) {
    return '$count надіслано';
  }

  @override
  String get admin_overview_platform_glance => 'Огляд платформи';

  @override
  String get admin_overview_revenue_30d => 'Дохід (останні 30 днів)';

  @override
  String get admin_overview_pending_requests =>
      'Запити на приєднання, що очікують на розгляд';

  @override
  String get admin_overview_view_all => 'Переглянути всі';

  @override
  String get admin_overview_order_status => 'Статус замовлення';

  @override
  String get admin_overview_top_restaurants => 'Найкращі ресторани';

  @override
  String get admin_overview_stat_restaurants => 'Всього ресторанів';

  @override
  String admin_overview_stat_restaurants_sub(int active) {
    return '$active активний';
  }

  @override
  String get admin_overview_stat_orders => 'Загальна кількість замовлень';

  @override
  String admin_overview_stat_orders_sub(int today) {
    return '$today сьогодні';
  }

  @override
  String get admin_overview_stat_revenue => 'Загальний дохід';

  @override
  String admin_overview_stat_revenue_sub(String last7d) {
    return '$last7d PLN за останні 7 днів';
  }

  @override
  String get admin_overview_stat_avg => 'Середня вартість замовлення';

  @override
  String admin_overview_stat_avg_sub(int menus, int items) {
    return '$menus меню • $items пункти';
  }

  @override
  String get admin_overview_revenue_no_data => 'Дані про доходи недоступні.';

  @override
  String get admin_overview_no_pending =>
      'Немає запитів на приєднання, що очікують на розгляд.';

  @override
  String admin_overview_pending_nip(String nip, String date) {
    return 'Національний ідентифікаційний номер: $nip • $date';
  }

  @override
  String get admin_overview_no_orders => 'Замовлень поки що немає.';

  @override
  String get admin_overview_no_order_data => 'Дані замовлення недоступні.';

  @override
  String admin_overview_orders_count(int count) {
    return '$count замовлень';
  }

  @override
  String get requests_tab_registrations => 'Реєстрації';

  @override
  String get requests_tab_go_live => 'Вихід в ефір';

  @override
  String get requests_filter_pending => 'Очікує на розгляд';

  @override
  String get requests_filter_approved => 'Схвалено';

  @override
  String get requests_filter_active => 'Активний';

  @override
  String get requests_filter_rejected => 'Відхилено';

  @override
  String get requests_filter_suspended => 'Призупинено';

  @override
  String get requests_filter_all => 'Усі';

  @override
  String requests_empty_filtered(String status) {
    return 'Не знайдено жодних $status запитів.';
  }

  @override
  String get requests_empty_all => 'Запитів на реєстрацію не знайдено.';

  @override
  String get requests_go_live_empty => 'Запитів на активацію не знайдено.';

  @override
  String get requests_go_live_section_pending => 'ОЧІКУЄ НА РОЗГЛЯД';

  @override
  String get requests_go_live_section_reviewed => 'ПЕРЕГЛЯНУТО';

  @override
  String requests_go_live_requested(String timeAgo, String date) {
    return 'Запит надіслано $timeAgo ($date)';
  }

  @override
  String get requests_badge_activated => 'Активовано';

  @override
  String get requests_badge_declined => 'Відхилено';

  @override
  String get requests_badge_pending_review => 'Очікує розгляду';

  @override
  String requests_go_live_activated_on(String date) {
    return 'Активовано $date';
  }

  @override
  String requests_go_live_declined_on(String date) {
    return 'Відхилено $date';
  }

  @override
  String get requests_check_logo => 'Логотип';

  @override
  String get requests_check_banner => 'Банер';

  @override
  String get requests_check_address => 'Адреса';

  @override
  String get requests_check_iban => 'IBAN';

  @override
  String get requests_check_photo => 'Фотографія профілю';

  @override
  String get requests_check_menu => 'Пункти меню';

  @override
  String requests_setup_progress(int completed, int total) {
    return '$completed/$total Завдання налаштування';
  }

  @override
  String requests_submitted(String date) {
    return 'Надіслано $date';
  }

  @override
  String requests_copied(String id) {
    return 'Ідентифікатор скопійовано: $id';
  }

  @override
  String get requests_confirm_approve_title => 'Схвалити ресторан?';

  @override
  String get requests_confirm_approve_body =>
      'Це дозволить продавцю розпочати налаштування своїх меню та профілю.';

  @override
  String get requests_confirm_reject_title => 'Відхилити заявку?';

  @override
  String get requests_confirm_reject_body =>
      'Це заборонить продавцю доступ до панелі керування. Його буде повідомлено про відхилення.';

  @override
  String get requests_confirm_suspend_title => 'Призупинити роботу ресторану?';

  @override
  String get requests_confirm_suspend_body =>
      'Це одразу приховає ресторан та всі його страви з платформи.';

  @override
  String get requests_confirm_reinstate_title => 'Відновити ресторан?';

  @override
  String get requests_confirm_reinstate_body =>
      'Це відновить статус ресторану «Активний» і зробить його знову видимим для клієнтів.';

  @override
  String get requests_action_copy_id => 'Скопіювати ідентифікатор ресторану';

  @override
  String requests_error_failed(String error) {
    return 'Операція не вдалася: $error';
  }

  @override
  String get users_search_hint => 'Пошук за іменем або електронною поштою...';

  @override
  String get users_empty_filtered =>
      'Немає користувачів, які відповідають вашим фільтрам.';

  @override
  String get users_empty_all => 'У системі не знайдено користувачів.';

  @override
  String users_joined(String date) {
    return 'Приєднався до $date';
  }

  @override
  String get users_detail_title => 'Відомості про користувача';

  @override
  String get users_detail_id => 'Ідентифікатор користувача';

  @override
  String get users_detail_phone => 'Телефон';

  @override
  String get users_detail_joined => 'Приєднався';

  @override
  String get users_detail_role => 'Роль';

  @override
  String get users_ban_body =>
      'Ви впевнені? Цей користувач буде негайно виведений із системи та не матиме доступу до свого облікового запису.';

  @override
  String get users_unban_body =>
      'Це відновить доступ користувача до платформи.';

  @override
  String get users_delete_title => 'Видалити користувача назавжди?';

  @override
  String get users_delete_body =>
      'Цю дію неможливо скасувати. Усі дані профілю користувача будуть видалені з бази даних.';

  @override
  String get users_snack_banned => 'Користувача забанено.';

  @override
  String get users_snack_unbanned => 'Доступ користувача відновлено.';

  @override
  String get users_snack_deleted =>
      'Обліковий запис користувача успішно видалено.';

  @override
  String get users_filter_all => 'Усі';

  @override
  String get users_filter_restaurant => 'Ресторани';

  @override
  String get users_filter_admin => 'Адміністратор';

  @override
  String get users_filter_customer => 'Клієнти';

  @override
  String get shell_nav_overview => 'Огляд';

  @override
  String get shell_nav_orders => 'Замовлення';

  @override
  String get shell_nav_menus => 'Меню';

  @override
  String get shell_nav_promotions => 'Акції';

  @override
  String get shell_nav_analytics => 'Аналітика';

  @override
  String get shell_nav_settings => 'Налаштування';

  @override
  String get shell_restaurant_not_found => 'Дані ресторану не знайдено.';

  @override
  String get shell_finish_setup => 'Завершити налаштування';

  @override
  String get shell_my_account => 'Мій обліковий запис';

  @override
  String get shell_menu_support => 'Центр підтримки';

  @override
  String get shell_menu_sales => 'Контактна особа з продажу';

  @override
  String get shell_menu_cookies => 'Політика щодо файлів cookie';

  @override
  String get shell_menu_settings => 'Налаштування програми';

  @override
  String get shell_menu_logout => 'Вийти';

  @override
  String get shell_already_pending =>
      'У вас вже є запит, що очікує на розгляд.';

  @override
  String get shell_go_live_submitted => 'Запит на активацію надіслано!';

  @override
  String shell_error(String error) {
    return 'Помилка: $error';
  }

  @override
  String get shell_go_offline_title => 'Вийти в офлайн?';

  @override
  String get shell_go_offline_body =>
      'Ваш ресторан більше не буде видимим для клієнтів на платформі.';

  @override
  String get shell_go_offline_confirm => 'Так, вийти в офлайн';

  @override
  String get shell_live_go_offline => 'Живий ефір / Вихід офлайн';

  @override
  String get shell_go_live_pending => 'Запит на перевірку';

  @override
  String get shell_go_live_declined => 'Відхилено – спробуйте ще раз';

  @override
  String get shell_request_go_live => 'Запит на публікацію';

  @override
  String get gate_pending_title => 'На розгляді';

  @override
  String get gate_pending_message =>
      'Наша команда зараз перевіряє ваш профіль ресторану. Ми повідомимо вас, щойно його буде схвалено.';

  @override
  String get gate_rejected_title => 'Заявку відхилено';

  @override
  String get gate_rejected_message =>
      'На жаль, вашу заявку наразі не схвалено. Зверніться до служби підтримки для отримання детальної інформації.';

  @override
  String get gate_suspended_title => 'Обліковий запис призупинено';

  @override
  String get gate_suspended_message =>
      'Ваш обліковий запис призупинено через порушення політики.';

  @override
  String get gate_default_title => 'Обмежений доступ';

  @override
  String get gate_default_message =>
      'У вас ще немає дозволу на доступ до цієї панелі інструментів.';

  @override
  String get analytics_section_glance => 'КОРОТКИЙ ПОГЛЯД';

  @override
  String analytics_stat_revenue(int days) {
    return 'Дохід ($daysдн.)';
  }

  @override
  String analytics_stat_orders(int days) {
    return 'Замовлення (${days}d)';
  }

  @override
  String get analytics_stat_today => 'Сьогоднішні продажі';

  @override
  String get analytics_stat_avg => 'Середня вартість замовлення';

  @override
  String get analytics_section_revenue => 'ТЕНДЕНЦІЯ ДОХОДІВ';

  @override
  String get analytics_no_revenue => 'Немає даних про доходи за цей період';

  @override
  String get analytics_section_status => 'РОЗБИВКА СТАНУ ЗАМОВЛЕННЯ';

  @override
  String get analytics_no_orders => 'За цей період замовлень не знайдено';

  @override
  String get analytics_section_popular => 'НАЙПОПУЛЯРНІШІ ТОВАРИ';

  @override
  String get analytics_no_items => 'Дані про товар недоступні';

  @override
  String analytics_orders_count(int count) {
    return '$count замовлень';
  }

  @override
  String menus_error(String error) {
    return 'Не вдалося завантажити меню: $error';
  }

  @override
  String get menus_empty_title => 'Ваше меню порожнє';

  @override
  String get menus_empty_subtitle =>
      'Створіть категорії, такі як «Основні страви» або «Напої», щоб почати організовувати свою кухню.';

  @override
  String get menus_field_title_hint => 'наприклад, італійська піца';

  @override
  String get menus_field_desc_hint =>
      'Коротко опишіть, що міститься в цьому розділі...';

  @override
  String get menus_image_browse => 'JPG або PNG, рекомендовано 16:9';

  @override
  String get menus_created => 'Категорію меню створено!';

  @override
  String get menus_updated => 'Категорію меню оновлено.';

  @override
  String get menus_deleted => 'Категорію меню видалено.';

  @override
  String get menus_image_cleanup_error =>
      'Меню збережено, але старий банер не вдалося видалити зі сховища.';

  @override
  String get menus_error_missing_ids =>
      'Відсутні необхідні ідентифікатори. Неможливо видалити.';

  @override
  String items_error(String error) {
    return 'Помилка завантаження елементів: $error';
  }

  @override
  String get items_empty_title => 'Тут ще немає товарів';

  @override
  String get items_empty_subtitle =>
      'Почніть з додавання своєї першої страви до цього меню.';

  @override
  String get items_field_title_hint => 'наприклад, класичний чізбургер';

  @override
  String get items_field_info_hint =>
      'наприклад, 200 г яловичини, чеддер, мариновані огірки';

  @override
  String get items_field_desc_hint => 'Опишіть інгредієнти та приготування...';

  @override
  String get items_field_price_hint => '0,00';

  @override
  String get items_field_tags_hint => 'Веганський, Гострий, Безглютеновий...';

  @override
  String get items_tag_hint => 'Додати теги (наприклад, Популярні)';

  @override
  String get items_added => 'Елемент успішно додано';

  @override
  String get items_updated => 'Відомості про товар збережено.';

  @override
  String get items_deleted => 'Пункт видалено з вашого меню.';

  @override
  String get items_error_no_image =>
      'Будь ласка, спочатку завантажте зображення.';

  @override
  String get items_tag_error_empty => 'Тег не може бути порожнім';

  @override
  String get items_tag_error_capitalize =>
      'Тег має починатися з великої літери';

  @override
  String get items_tag_error_letters => 'Дозволено використовувати лише літери';

  @override
  String get items_tag_error_duplicate => 'Цей тег вже існує';

  @override
  String get items_discount_info => 'наприклад, 500 г, гострий, веганський';

  @override
  String get image_cleanup_error =>
      'Елемент збережено, але старе зображення не вдалося видалити зі сховища.';

  @override
  String overview_welcome(String name) {
    return 'Ласкаво просимо назад, $name!';
  }

  @override
  String get overview_chef_fallback => 'Шеф-кухар';

  @override
  String get overview_subtitle =>
      'Ось що відбувається з вашим рестораном сьогодні.';

  @override
  String get overview_setup_title => 'Завершіть налаштування';

  @override
  String overview_setup_progress(int completed, int total) {
    return 'Виконано [_11 з $total кроків';
  }

  @override
  String get overview_task_logo_title => 'Завантажити логотип';

  @override
  String get overview_task_logo_desc =>
      'Ідентичність вашого бренду в клієнтському додатку.';

  @override
  String get overview_task_banner_title => 'Банер ресторану';

  @override
  String get overview_task_banner_desc =>
      'Високоякісне фото вашої найкращої страви.';

  @override
  String get overview_task_address_title => 'Адреса компанії';

  @override
  String get overview_task_address_desc => 'Тож клієнти знають, де вас знайти.';

  @override
  String get overview_task_photo_title => 'Фотографія профілю';

  @override
  String get overview_task_photo_desc =>
      'Додайте особистого шарму до свого облікового запису.';

  @override
  String get overview_task_menu_title => 'Створення меню';

  @override
  String get overview_task_menu_desc =>
      'Додайте принаймні одну категорію меню та один пункт.';

  @override
  String get overview_task_iban_title => 'Деталі виплати';

  @override
  String get overview_task_iban_desc =>
      'Введіть свій IBAN, щоб отримувати щотижневий дохід.';

  @override
  String get overview_stat_total_orders => 'Загальна кількість замовлень';

  @override
  String get overview_stat_pending => 'Очікує на розгляд';

  @override
  String get overview_stat_completed => 'Завершено';

  @override
  String get overview_stat_revenue => 'Загальний дохід';

  @override
  String get promo_empty_title => 'Немає активних рекламних акцій';

  @override
  String get promo_empty_subtitle =>
      'Створіть свою першу кампанію для підвищення видимості вашого ресторану.';

  @override
  String get promo_field_title_hint => 'наприклад, Літній фестиваль бургерів';

  @override
  String get promo_field_desc_hint => 'Поясніть пропозицію своїм клієнтам...';

  @override
  String promo_items_linked(int count) {
    return '$count Елемент пов’язано';
  }

  @override
  String promo_items_linked_plural(int count) {
    return '$count Пов’язані елементи';
  }

  @override
  String get promo_date_order_error =>
      'Дата завершення має бути після дати початку';

  @override
  String get promo_no_dates =>
      'Будь ласка, виберіть дату початку та дату завершення';

  @override
  String get promo_created => 'Акція успішно розпочата!';

  @override
  String get promo_updated => 'Деталі акції оновлено.';

  @override
  String get promo_deleted => 'Акцію видалено.';

  @override
  String get promo_banner_cleanup_error =>
      'Примітка: Старе зображення не вдалося видалити зі сховища.';

  @override
  String get promo_error_no_image =>
      'Для нових рекламних акцій потрібне зображення банера.';

  @override
  String get promo_link_no_items =>
      'У вашому меню не знайдено жодного елемента.';

  @override
  String get promo_image_recommended => 'Рекомендоване співвідношення 16:9';

  @override
  String get settings_error =>
      'Не вдалося завантажити налаштування. Спробуйте ще раз.';

  @override
  String get settings_logo_recommended =>
      'Квадратний PNG або JPG (мін. 512x512 пікселів)';

  @override
  String get settings_logo_uploading => 'Завантаження...';

  @override
  String get settings_logo_updated => 'Логотип ресторану оновлено.';

  @override
  String get settings_banner_recommended =>
      'Рекомендовано ширококутний формат 16:9';

  @override
  String get settings_banner_updated => 'Обкладинку оновлено.';

  @override
  String get settings_business_updated => 'Інформацію про компанію збережено.';

  @override
  String get settings_profile_updated => 'Зміни профілю збережено.';

  @override
  String get settings_password_reset_sent =>
      'Посилання для скидання пароля було надіслано на вашу електронну адресу.';

  @override
  String get settings_delete_dialog_title => 'Ви абсолютно впевнені?';

  @override
  String get settings_delete_dialog_body =>
      'Цю дію неможливо скасувати. Усі ваші меню, рекламні акції та історію буде видалено.';

  @override
  String get settings_address_set => 'Адреси ще немає';

  @override
  String get settings_map_no_pick =>
      'Будь ласка, спочатку виберіть місце на карті.';

  @override
  String get settings_profile_name_hint => 'Повне ім\'я';

  @override
  String get build_user_experience =>
      'Створіть наступне покоління гастрономічних вражень.';

  @override
  String get join_thousands =>
      'Приєднуйтесь до тисяч ресторанів, які розвивають свій бізнес за допомогою нашої платформи.';

  @override
  String get sign_in_to_dashboard => 'Увійти в інформаційну панель';

  @override
  String get create_your_account => 'Створіть свій обліковий запис';

  @override
  String get new_to_the_platform => 'Вперше на платформі?';

  @override
  String get already_have_an_account => 'Вже маєте обліковий запис?';

  @override
  String get with_google => 'з Google';

  @override
  String get terms_of_service =>
      'Продовжуючи, ви погоджуєтеся з нашими Умовами надання послуг та Політикою конфіденційності.';

  @override
  String get errorNoUserRecord =>
      'Профіль користувача не знайдено. Зверніться до служби підтримки.';

  @override
  String get errorRestaurantAccountOnly =>
      'Цей портал призначений лише для облікових записів ресторанів та адміністраторів.';

  @override
  String get errorNoRestaurantRecord =>
      'Для цього облікового запису не знайдено профілю ресторанного бізнесу.';

  @override
  String get hintEmail => 'Адреса електронної пошти';

  @override
  String get hintPassword => 'Пароль';

  @override
  String get business => 'Бізнес';

  @override
  String get business_name => 'Назва компанії';

  @override
  String get business_phone => 'Робочий телефон';

  @override
  String get owner_full_name => 'Повне ім\'я власника';

  @override
  String get owner_phone => 'Телефон власника';

  @override
  String get creating_partner_account =>
      'Створення партнерського облікового запису...';

  @override
  String get account_is_pending_approval =>
      'Реєстрація успішна! Ваш обліковий запис очікує на схвалення.';

  @override
  String get now_live_in => 'Зараз живуть у Кракові та Варшаві';

  @override
  String get put_your_restaurant_on =>
      'Розмістіть свій ресторан на цифровій карті.';

  @override
  String get manage_your_menu =>
      'Керуйте своїм меню, відстежуйте продажі в реальному часі та розширюйте свою клієнтську базу за допомогою нашої універсальної панелі керування продавцем.';

  @override
  String get register_your_restaurant => 'Зареєструйте свій ресторан';

  @override
  String get see_how_it_works => 'Дивіться, як це працює';

  @override
  String get live_platform_stats => 'СТАТИСТИКА ПЛАТФОРМИ В ПРЯМОМУ ЕФІРІ';

  @override
  String get restaurants_on_platform => 'Ресторани на платформі';

  @override
  String get orders_placed => 'Розміщених замовлень';

  @override
  String get menus_published => 'Меню опубліковано';

  @override
  String get items_available => 'Доступні товари';

  @override
  String get trusted_by_restaurants =>
      'НАМ ДОВІРЯЮТЬ ПОНАД 200 МІСЦЕВИХ РЕСТОРАНІВ';

  @override
  String get digital_menu => 'Цифрове меню';

  @override
  String get your_menu_goes_live_instantly =>
      'Ваше меню миттєво публікується на нашій клієнтській платформі.';

  @override
  String get custom_banners => 'Власні банери';

  @override
  String get full_creative_control =>
      'Повний творчий контроль над візуальною ідентичністю вашого магазину.';

  @override
  String get sales_analytics => 'Аналітика продажів';

  @override
  String get track_peak_hours =>
      'Відстежуйте години пік та товари з найвищим рівнем продажів у режимі реального часу.';

  @override
  String get ready_to_grow => 'Готові збільшити свій дохід?';

  @override
  String get join_restaurants =>
      'Приєднуйтесь до ресторанів, які вже процвітають на нашій платформі.';

  @override
  String get hiw_title => 'Як це працює';

  @override
  String get hiw_hero_badge => 'Простий адаптаційний процес';

  @override
  String get hiw_hero_title =>
      'Замовити кухню онлайн ще ніколи не було так просто.';

  @override
  String get hiw_hero_subtitle =>
      'Від реєстрації до вашого першого замовлення, ми спростили кожен крок, щоб ви могли розпочати роботу за лічені дні, а не тижні.';

  @override
  String get hiw_step1_title => 'Створити обліковий запис';

  @override
  String get hiw_step1_desc =>
      'Зареєструйтесь, використовуючи дані про вашу компанію (NIP/REGON) та інформацію про власника.';

  @override
  String get hiw_step2_title => 'Перевірка адміністратора';

  @override
  String get hiw_step2_desc =>
      'Наша команда перевіряє вашу заявку, щоб забезпечити безпеку платформи та стандарти якості.';

  @override
  String get hiw_step3_title => 'Налаштуйте свій магазин';

  @override
  String get hiw_step3_desc =>
      'Завантажте свій логотип, встановіть години роботи та визначте зони доставки.';

  @override
  String get hiw_step4_title => 'Створіть своє меню';

  @override
  String get hiw_step4_desc =>
      'Додавайте категорії, елементи та модифікатори. Використовуйте наші інструменти штучного інтелекту для створення високоякісних описів.';

  @override
  String get hiw_step5_title => 'Вихід в ефір';

  @override
  String get hiw_step5_desc =>
      'Змініть свій статус на активний та почніть отримувати замовлення від місцевих клієнтів.';

  @override
  String get hiw_feature1_title => 'Синхронізація в реальному часі';

  @override
  String get hiw_feature1_desc =>
      'Оновлення меню миттєво відображаються в додатку клієнта без затримки.';

  @override
  String get hiw_feature2_title => 'Детальна аналітика';

  @override
  String get hiw_feature2_desc =>
      'Відстежуйте свої бестселери та години пік, щоб оптимізувати свій персонал та запаси.';

  @override
  String get hiw_feature3_title => 'Керування зображеннями';

  @override
  String get hiw_feature3_desc =>
      'Інтегроване хмарне сховище для всіх ваших фотографій їжі високої роздільної здатності.';

  @override
  String get hiw_feature4_title => 'Доступ на основі ролей';

  @override
  String get hiw_feature4_desc =>
      'Безпечно керуйте дозволами для власників, менеджерів та кухонного персоналу.';

  @override
  String get hiw_feature5_title => 'Багатопристроєвий';

  @override
  String get hiw_feature5_desc =>
      'Керуйте своїм рестораном без проблем з комп\'ютера, планшета або мобільного телефону.';

  @override
  String get hiw_feature6_title => 'Підтримка 24/7';

  @override
  String get hiw_feature6_desc =>
      'Наша команда з питань успіху продавців завжди готова допомогти вам розвиватися.';

  @override
  String get hiw_cta_title => 'Готові збільшити свій дохід?';

  @override
  String get hiw_cta_subtitle =>
      'Приєднуйтесь до нашої спільноти успішних ресторанів вже сьогодні.';

  @override
  String get hiw_cta_primary => 'Почніть безкоштовно';

  @override
  String get hiw_cta_secondary => 'Переглянути ціни';

  @override
  String get pricing_title => 'Ціноутворення';

  @override
  String get pricing_hero_badge => 'Прозорі збори';

  @override
  String get pricing_hero_title =>
      'Розвивайте свій бізнес без постійних витрат.';

  @override
  String get pricing_hero_subtitle =>
      'Ми досягаємо успіху лише тоді, коли це робите ви. Ніяких плати за налаштування, жодних щомісячних підписок — лише простий відсоток від того, що ви продаєте.';

  @override
  String get pricing_step1_title => 'Замовлення клієнтів';

  @override
  String get pricing_step1_desc =>
      'Замовлення розміщуються через нашу захищену платформу для клієнтів.';

  @override
  String get pricing_step2_title => 'Ви готуєтеся';

  @override
  String get pricing_step2_desc =>
      'Керуйте кухнею та залишайте собі 100% чайових.';

  @override
  String get pricing_step3_title => 'Щотижневі виплати';

  @override
  String get pricing_step3_desc =>
      'Кошти вносяться за вирахуванням нашої невеликої комісії.';

  @override
  String get pricing_calculator_title => 'Оцініть свій заробіток.';

  @override
  String get pricing_slider_orders_label => 'Замовлень на день';

  @override
  String pricing_slider_orders_value(int count, int monthly) {
    return '$count замовлень ($monthly / місяць)';
  }

  @override
  String get pricing_slider_avg_label => 'Середня вартість замовлення';

  @override
  String pricing_tier_badge(String name, String pct) {
    return '$name Рівень ($pct)';
  }

  @override
  String pricing_tier_monthly(int count) {
    return '$count щомісячних замовлень';
  }

  @override
  String get pricing_calc_revenue_label => 'Щоденний дохід';

  @override
  String get pricing_calc_revenue_sub => 'Валовий обсяг продажів';

  @override
  String pricing_calc_fee_label(String pct) {
    return 'Платформний збір ($pct)';
  }

  @override
  String get pricing_calc_fee_sub => 'Наша комісія';

  @override
  String get pricing_calc_keep_label => 'Ви тримаєте';

  @override
  String get pricing_calc_disclaimer =>
      'Оцінки базуються на поточних тарифах рівнів. Не включає комісії за обробку платежів.';

  @override
  String get pricing_tiers_title => 'Чим більше продаєте, тим менше платите.';

  @override
  String get pricing_tiers_subtitle =>
      'Комісійні ставки автоматично коригуються на основі обсягу ваших замовлень за попередні 30 днів.';

  @override
  String get pricing_tier_starter_label => 'Стартер';

  @override
  String get pricing_tier_starter_range => '0–100 замовлень';

  @override
  String get pricing_tier_starter_desc =>
      'Ідеально підходить для нових ресторанів та тимчасових кухонь.';

  @override
  String get pricing_tier_growing_label => 'Зростання';

  @override
  String get pricing_tier_growing_range => '101–500 замовлень';

  @override
  String get pricing_tier_growing_desc =>
      'Для місцевих фаворитів, які починають масштабувати свою доставку.';

  @override
  String get pricing_tier_established_label => 'Засновано';

  @override
  String get pricing_tier_established_range => '501–1500 замовлень';

  @override
  String get pricing_tier_established_desc =>
      'Заклади з великою кількістю відвідувачів та лояльною аудиторією.';

  @override
  String get pricing_tier_partner_label => 'Партнер';

  @override
  String get pricing_tier_partner_range => '1500+ замовлень';

  @override
  String get pricing_tier_partner_desc =>
      'Глибока інтеграція для загальноміських ресторанних груп.';

  @override
  String get pricing_faq1_q => 'Чи є якісь приховані щомісячні платежі?';

  @override
  String get pricing_faq1_a =>
      'Ні. Щомісячної плати за обслуговування чи підписку немає. Ви сплачуєте комісію лише за виконані замовлення.';

  @override
  String get pricing_faq2_q => 'Як часто мені виплачують гроші?';

  @override
  String get pricing_faq2_a =>
      'Виплати обробляються щотижня, щовівторка, за всі замовлення, виконані за попередній тиждень.';

  @override
  String get pricing_faq3_q => 'Чи сплачую я комісію за скасовані замовлення?';

  @override
  String get pricing_faq3_a =>
      'Ні. Якщо замовлення скасовано, а клієнту повернуто кошти, комісія не стягується.';

  @override
  String get pricing_faq4_q => 'Хто займається доставкою?';

  @override
  String get pricing_faq4_a =>
      'Цей план передбачає, що ви надаєте власний персонал доставки. Ми забезпечуємо цифрову інфраструктуру для їх управління.';

  @override
  String get pricing_faq5_q => 'Чи можу я скасувати замовлення будь-коли?';

  @override
  String get pricing_faq5_a =>
      'Так. Довгострокових контрактів немає. Ви можете будь-коли зробити свій магазин неактивним.';

  @override
  String get pricing_cta_title => 'Без ризику, одні винагороди.';

  @override
  String get pricing_cta_subtitle =>
      'Почніть отримувати замовлення вже сьогодні та платіть лише за результат.';

  @override
  String get pricing_cta_primary => 'Приєднатися як партнер';

  @override
  String get admin_overview_review => 'Огляд';

  @override
  String get admin_overview_status_pending => 'Очікує на розгляд';

  @override
  String get admin_overview_status_processing => 'У процесі';

  @override
  String get admin_overview_status_delivered => 'Доставлено';

  @override
  String get admin_overview_status_cancelled => 'Скасовано';

  @override
  String get requests_action_activate => 'Активувати';

  @override
  String get requests_action_decline => 'Відхилення';

  @override
  String get requests_action_approve => 'Схвалити';

  @override
  String get requests_action_reject => 'Відхилити';

  @override
  String get requests_action_suspend => 'Призупинити';

  @override
  String get requests_action_reinstate => 'Відновити';

  @override
  String get requests_status_approved => 'Схвалено';

  @override
  String get requests_status_active => 'Активний';

  @override
  String get requests_status_rejected => 'Відхилено';

  @override
  String get requests_status_suspended => 'Призупинено';

  @override
  String get requests_status_pending => 'Очікує на розгляд';

  @override
  String get users_banned_badge => 'ЗАБОРОНЕНО';

  @override
  String get users_action_ban => 'Забанити користувача';

  @override
  String get users_action_unban => 'Розблокувати користувача';

  @override
  String get users_action_delete => 'Видалити користувача';

  @override
  String get users_confirm_cancel => 'Скасувати';

  @override
  String get users_role_admin => 'Адміністратор платформи';

  @override
  String get users_role_restaurant => 'Власник ресторану';

  @override
  String get users_role_customer => 'Клієнт';

  @override
  String get users_copied => 'Значення скопійовано в буфер обміну';

  @override
  String get shell_confirm_cancel => 'Скасувати';

  @override
  String get analytics_status_normal => 'Звичайний';

  @override
  String get analytics_status_processing => 'Обробка';

  @override
  String get analytics_status_delivered => 'Доставлено';

  @override
  String get analytics_status_cancelled => 'Скасовано';

  @override
  String get menus_fab => 'Створити меню';

  @override
  String get menus_sheet_title => 'Нова категорія меню';

  @override
  String get menus_image_upload_label => 'Банер категорії';

  @override
  String get menus_field_title_label => 'Назва категорії';

  @override
  String get menus_field_title_required => 'Ім\'я обов\'язкове';

  @override
  String get menus_field_desc_label => 'Опис';

  @override
  String get menus_field_desc_required => 'Опис обов\'язковий';

  @override
  String get menus_no_image => 'Будь ласка, виберіть зображення банера';

  @override
  String get menus_submit => 'Додати категорію';

  @override
  String get menus_design_view_items => 'Переглянути елементи';

  @override
  String get menus_design_edit_button => 'Редагувати';

  @override
  String get menus_design_edit_sheet_title => 'Меню редагування';

  @override
  String get menus_design_delete_button => 'Видалити';

  @override
  String get menus_design_change_image_hint =>
      'Натисніть, щоб змінити зображення банера';

  @override
  String get menus_design_field_title_label => 'Назва меню';

  @override
  String get menus_design_field_title_required =>
      'Будь ласка, введіть заголовок';

  @override
  String get menus_design_field_desc_label => 'Опис';

  @override
  String get menus_design_field_desc_required => 'Будь ласка, введіть опис';

  @override
  String get menus_design_save_changes => 'Зберегти зміни';

  @override
  String get menus_design_saved => 'Меню успішно оновлено';

  @override
  String get menus_design_banner_cleanup_error =>
      'Примітка: Меню оновлено, але старе зображення видалити не вдалося.';

  @override
  String get menus_design_delete_dialog_title => 'Видалити меню?';

  @override
  String get menus_design_delete_dialog_body =>
      'Ви впевнені? Це назавжди видалить це меню та всі пов’язані з ним дані.';

  @override
  String get menus_design_delete_cancel => 'Скасувати';

  @override
  String get menus_design_delete_confirm => 'Видалити назавжди';

  @override
  String get menus_design_delete_missing_id =>
      'Помилка: Відсутні ідентифікатори. Неможливо видалити.';

  @override
  String get menus_design_deleted => 'Меню видалено';

  @override
  String get items_app_bar_fallback => 'Пункти меню';

  @override
  String get items_fab => 'Додати елемент';

  @override
  String get items_sheet_title => 'Додати новий елемент';

  @override
  String get items_image_upload_label => 'Фото товару';

  @override
  String get items_image_browse => 'Натисніть, щоб переглянути зображення';

  @override
  String get items_field_title_label => 'Назва елемента';

  @override
  String get items_field_info_label => 'Коротка інформація';

  @override
  String get items_field_desc_label => 'Повний опис';

  @override
  String get items_field_price_label => 'Базова ціна';

  @override
  String get items_field_price_required => 'Ціна обов\'язкова';

  @override
  String get items_field_price_invalid => 'Введіть дійсну ціну';

  @override
  String get items_field_tags_label => 'Теги';

  @override
  String get items_discount_label => 'Відсоток знижки';

  @override
  String get items_discount_required => 'Введіть суму знижки';

  @override
  String get items_discount_invalid => 'Введіть числа від 1 до 100';

  @override
  String get items_no_image => 'Будь ласка, спочатку завантажте зображення';

  @override
  String get items_submit => 'Створити елемент';

  @override
  String get items_design_edit_button => 'Редагувати';

  @override
  String get items_design_image_cleanup_error =>
      'Елемент оновлено, але попереднє зображення не вдалося видалити з пам\'яті.';

  @override
  String get items_design_saved => 'Елемент успішно оновлено';

  @override
  String get items_design_deleted => 'Елемент видалено';

  @override
  String get items_design_delete_dialog_title => 'Видалити елемент?';

  @override
  String get items_design_delete_dialog_body =>
      'Ви впевнені, що хочете видалити цей елемент? Цю дію не можна скасувати.';

  @override
  String get items_design_delete_cancel => 'Скасувати';

  @override
  String get items_design_delete_confirm => 'Видалити';

  @override
  String get items_design_edit_sheet_title => 'Редагувати елемент';

  @override
  String get items_design_delete_button => 'Видалити';

  @override
  String get items_design_change_image_hint =>
      'Торкніться зображення, щоб змінити його';

  @override
  String get items_design_field_title_label => 'Назва елемента';

  @override
  String get items_field_title_required => 'Ім\'я обов\'язкове';

  @override
  String get items_design_field_info_label => 'Коротка інформація';

  @override
  String get items_design_field_info_hint =>
      'наприклад, 500 г, гострий, веганський';

  @override
  String get items_field_info_required => 'Потрібна коротка інформація';

  @override
  String get items_design_field_desc_label => 'Опис';

  @override
  String get items_field_desc_required => 'Опис обов\'язковий';

  @override
  String get items_design_field_price_label => 'Базова ціна';

  @override
  String get items_design_field_price_required => 'Ціна обов\'язкова';

  @override
  String get items_design_field_price_invalid => 'Введіть дійсну ціну';

  @override
  String get items_design_field_tags_label => 'Теги';

  @override
  String get items_design_field_tags_hint =>
      'Додати теги (наприклад, Популярні)';

  @override
  String get items_discount_toggle => 'Запропонуйте знижку';

  @override
  String get items_design_discount_label => 'Відсоток знижки';

  @override
  String get items_design_discount_required => 'Введіть значення знижки';

  @override
  String get items_design_discount_invalid => 'Введіть значення від 1 до 100';

  @override
  String get overview_section_glance => 'КОРОТКИЙ ПОГЛЯД';

  @override
  String get overview_section_orders => 'ОСТАННІ ЗАМОВЛЕННЯ';

  @override
  String get overview_task_done => 'Готово';

  @override
  String get overview_task_setup => 'Налаштування';

  @override
  String get promo_fab => 'Створити рекламну акцію';

  @override
  String get promo_badge_live => 'ПРЯМИЙ ЕФІР';

  @override
  String get promo_badge_inactive => 'НЕАКТИВНИЙ';

  @override
  String get promo_edit_button => 'Керувати';

  @override
  String get promo_sheet_add_title => 'Нова акція';

  @override
  String get promo_sheet_edit_title => 'Редагувати рекламну акцію';

  @override
  String get promo_field_title_label => 'Назва кампанії';

  @override
  String get promo_field_title_required => 'Будь ласка, введіть заголовок';

  @override
  String get promo_field_desc_label => 'Короткий опис';

  @override
  String get promo_field_desc_required => 'Опис обов\'язковий';

  @override
  String get promo_date_start => 'Дата початку';

  @override
  String get promo_date_end => 'Дата завершення';

  @override
  String get promo_date_pick => 'Виберіть дату';

  @override
  String get promo_active_toggle => 'Показати акцію клієнтам';

  @override
  String get promo_image_upload_hint =>
      'Натисніть, щоб завантажити банер кампанії';

  @override
  String get promo_image_change_hint => 'Натисніть, щоб змінити банер';

  @override
  String get promo_delete_title => 'Видалити рекламну акцію?';

  @override
  String get promo_delete_body =>
      'Це назавжди видалить кампанію та її банер. Цю дію не можна скасувати.';

  @override
  String get promo_delete_cancel => 'Тримай це';

  @override
  String get promo_delete_confirm => 'Видалити';

  @override
  String get promo_no_image =>
      'Для нових рекламних акцій потрібне зображення банера';

  @override
  String get promo_link_section_label => 'Посилання на елементи';

  @override
  String get promo_link_section_hint =>
      'Виберіть товари, які належать до цієї акції.';

  @override
  String get promo_image_upload_label => 'Зображення реклами';

  @override
  String get promo_save_changes => 'Зберегти зміни';

  @override
  String get promo_create => 'Запуск рекламної акції';

  @override
  String get settings_section_business => 'Деталі бізнесу';

  @override
  String get settings_section_business_sub =>
      'Керуйте публічною ідентичністю вашого ресторану.';

  @override
  String get settings_section_profile => 'Профіль облікового запису';

  @override
  String get settings_section_profile_sub =>
      'Ваша особиста контактна інформація.';

  @override
  String get settings_section_danger => 'НЕБЕЗПЕЧНА ЗОНА';

  @override
  String get settings_section_danger_sub =>
      'Незворотні дії з обліковим записом.';

  @override
  String get settings_logo_title => 'Логотип ресторану';

  @override
  String get settings_logo_status_staged => 'Вибрано новий логотип';

  @override
  String get settings_logo_status_exists => 'Логотип завантажено';

  @override
  String get settings_logo_status_none => 'Логотип не встановлено';

  @override
  String get settings_logo_choose => 'Виберіть зображення';

  @override
  String get settings_logo_upload => 'Зберегти логотип';

  @override
  String get settings_logo_success => 'Логотип успішно оновлено!';

  @override
  String get settings_banner_title => 'Обкладинка-банер';

  @override
  String get settings_banner_choose => 'Натисніть, щоб вибрати обкладинку';

  @override
  String get settings_banner_upload => 'Зберегти банер';

  @override
  String get settings_banner_success => 'Банер успішно оновлено!';

  @override
  String get settings_business_title => 'Інформація про магазин';

  @override
  String get settings_address_pick => 'Закріпити на карті';

  @override
  String get settings_address_change => 'Зміна';

  @override
  String get settings_business_saved => 'Інформацію про бізнес оновлено!';

  @override
  String get settings_profile_title => 'Власник облікового запису';

  @override
  String get settings_profile_photo_ready => 'Нове фото готове до збереження';

  @override
  String get settings_profile_phone_label => 'Контактний телефон';

  @override
  String get settings_save_changes => 'Зберегти зміни';

  @override
  String get settings_cancel => 'Скасувати';

  @override
  String get settings_danger_reset_title => 'Скинути пароль';

  @override
  String get settings_danger_reset_sub =>
      'Надіслати посилання для скидання пароля на вашу електронну пошту.';

  @override
  String get settings_danger_reset_button => 'Скинути';

  @override
  String get settings_danger_reset_sent =>
      'Скинутий електронний лист надіслано! Будь ласка, перевірте свою поштову скриньку.';

  @override
  String get settings_danger_delete_title => 'Видалити обліковий запис';

  @override
  String get settings_danger_delete_sub =>
      'Видаліть свій ресторан та всі дані назавжди.';

  @override
  String get settings_danger_delete_button => 'Видалити';

  @override
  String get settings_danger_delete_dialog_title => 'Ви абсолютно впевнені?';

  @override
  String get settings_danger_delete_dialog_body =>
      'Цю дію неможливо скасувати. Усі ваші меню, рекламні акції та історію буде видалено.';

  @override
  String get settings_map_dialog_title => 'Виберіть місцезнаходження';

  @override
  String get settings_map_no_location => 'Місцезнаходження ще не вибрано.';

  @override
  String get settings_map_open => 'Відкрити карту';

  @override
  String get settings_map_change => 'Змінити місцезнаходження';

  @override
  String get settings_map_confirm => 'Підтвердити місцезнаходження';

  @override
  String get settings_profile_saved => 'Зміни збережено';

  @override
  String get how_it_works => 'Як це працює';

  @override
  String get pricing => 'Ціноутворення';

  @override
  String get getStarted => 'Почати';

  @override
  String get tapToUploadImage => 'Натисніть, щоб завантажити зображення';

  @override
  String get sign_up => 'Зареєструватися';

  @override
  String get log_in => 'Увійти';

  @override
  String get sign_in => 'Увійти';

  @override
  String get errorEnterEmailOrPassword =>
      'Будь ласка, введіть свою електронну адресу та пароль.';

  @override
  String get errorLoginFailed =>
      'Не вдалося ввійти. Будь ласка, перевірте своє з’єднання або облікові дані.';

  @override
  String get error_no_user_record_found =>
      'Профіль користувача не знайдено. Зверніться до служби підтримки.';

  @override
  String get permission_restaurant_accounts_only =>
      'Цей портал призначений лише для облікових записів ресторанів та адміністраторів.';

  @override
  String get error_no_restaurant_record_found =>
      'Для цього облікового запису не знайдено профілю ресторанного бізнесу.';

  @override
  String get admin_profile => 'Профіль адміністратора';

  @override
  String get info_continue => 'Продовжити';

  @override
  String get hintConfPassword => 'Підтвердьте пароль';

  @override
  String get errorNoMatchPasswords => 'Паролі не збігаються.';

  @override
  String get orders_today => 'Замовлення сьогодні';

  @override
  String get total_orders => 'Загальна кількість замовлень';

  @override
  String get menu_items => 'Пункти меню';

  @override
  String get upper_features => 'Особливості';

  @override
  String get register_now => 'Зареєструватися зараз';

  @override
  String get hiw_section_process => 'Процес';

  @override
  String get hiw_section_features => 'Все, що вам потрібно';

  @override
  String get hiw_features_title => 'Потужні інструменти для сучасних кухонь.';
}
