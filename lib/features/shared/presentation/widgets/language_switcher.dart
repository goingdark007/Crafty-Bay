import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/providers/localization_provider.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
        builder: (context, localeProvider, child) {
          return DropdownMenu<Locale>(
            initialSelection: localeProvider.locale,
            dropdownMenuEntries: localeProvider.supportedLocales.map((locale){

              return DropdownMenuEntry<Locale>(
                  value: locale,
                  label: locale.languageCode.toUpperCase()
              );

            }).toList(),

            onSelected: (Locale? selectedLocale){

              if(selectedLocale != null){
                localeProvider.changeLocal(selectedLocale);
              }

            },
          );
        }
    );
  }
}