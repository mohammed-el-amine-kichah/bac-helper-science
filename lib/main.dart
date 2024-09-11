import 'package:bac_helper_sc/provider/app_themes.dart';
import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:bac_helper_sc/screens/average_calculator.dart';
import 'package:bac_helper_sc/screens/splash_screen.dart';
import 'package:bac_helper_sc/screens/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FirebaseAuth.instance.signInAnonymously();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'BAC App',
          theme: themeNotifier.isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme,
          home:  const SplashScreen(),
          routes: {
            'timer' :(context) => const TimerScreen(),
            'calculator' : (context) => const AverageCalculator(),
          },

        );
      }
    );
  }
}


