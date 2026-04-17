import 'package:crafty_bay/app/providers/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../l10n/app_localizations.dart';
import 'app_theme.dart';
import 'providers/theme_provider.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {

    final LocalizationProvider localeProvider = context.watch<LocalizationProvider>();
    final ThemeProvider themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(

      title: 'Crafty Bay',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: Routes.onGenerateRoute,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: localeProvider.supportedLocales,
      // To set the default localization language
      locale: localeProvider.locale,

    );
  }
}