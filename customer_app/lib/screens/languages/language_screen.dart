import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/providers/locale_provider.dart';
import 'package:shared_assets/models/language.dart';
import 'package:country_flags/country_flags.dart';
import 'package:user_app/widgets/ui/unified_app_bar.dart';
import 'package:shared_assets/extensions/extensions.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final common = context.l10nCommon;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: UnifiedAppBar(
        title: common.changeLanguage, 
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new, 
            color: Colors.white,
            size: 28,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 24),
        itemCount: Language.languageList.length,
        itemBuilder: (context, index) {
          final lang = Language.languageList[index];
          final isSelected = localeProvider.locale.languageCode == lang.code;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(16), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1), 
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                leading: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CountryFlag.fromCountryCode(
                    lang.countryCode,
                    theme: const ImageTheme(
                      height: 32,
                      width: 32,
                      shape: Circle(),
                    ),
                  ),
                ),
                title: Text(
                  lang.name,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
                  ),
                ),
                trailing: isSelected 
                    ? Icon(
                        Icons.check_circle, 
                        color: Theme.of(context).primaryColor, 
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 6,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ) 
                    : null,
                onTap: () async {
                  await localeProvider.setLocale(Locale(lang.code));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}