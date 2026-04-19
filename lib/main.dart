import 'dart:ui';

import 'package:crafty_bay/features/shared/presentation/providers/category_list_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/crafty_bay_app.dart';
import 'app/providers/localization_provider.dart';
import 'app/providers/theme_provider.dart';
import 'app/providers/timer_provider.dart';
import 'features/home/presentation/providers/home_slider_provider.dart';
import 'features/shared/presentation/providers/main_nav_provider.dart';
import 'firebase_options.dart';

/// Check list for this project
// Firebase set up ✅
// Crashlytics set up ✅
// Analytics set up ✅
// Provider set up
// Localization set up✅
// Architecture Design✅ SoC (Separation of Concern)
// Theming set up 5️⃣0️⃣✅

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Pass all uncaught "fatal" errors form the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LocalizationProvider()..loadLocale()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
          ChangeNotifierProvider(create: (_) => TimerProvider()),
          ChangeNotifierProvider(create: (_) => MainNavProvider()),
          ChangeNotifierProvider(create: (_) => HomeSliderProvider(),),
          ChangeNotifierProvider(create: (_) => CategoryListProvider())
        ],
        child: const MyApp()
      )
  );
}

/// We'll create a pipeline for API caller
// Class -> API call -> ApiCaller -> NetworkCaller

