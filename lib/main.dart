import 'package:bac_helper_sc/provider/app_themes.dart';
import 'package:bac_helper_sc/provider/dark_mode.dart';
import 'package:bac_helper_sc/screens/splash_screen.dart';
import 'package:bac_helper_sc/screens/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'BAC App',
          theme: themeNotifier.isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme,
          home:  SplashScreen(),
          routes: {
            'timer' :(context) => TimerScreen(),
          },

        );
      }
    );
  }
}


