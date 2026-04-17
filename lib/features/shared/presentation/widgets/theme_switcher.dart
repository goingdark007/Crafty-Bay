import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../app/providers/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return DropdownMenu<ThemeMode>(
            initialSelection: themeProvider.themeMode,
            dropdownMenuEntries: themeProvider.supportedThemes.map((themeMode){

              return DropdownMenuEntry<ThemeMode>(
                  value: themeMode,
                  label: themeMode.name.toUpperCase()
              );

            }).toList(),

            onSelected: (ThemeMode? selectedThemeMode){

              if(selectedThemeMode != null){
                themeProvider.changeTheme(selectedThemeMode);
              }

            },
          );
        }
    );
  }
}