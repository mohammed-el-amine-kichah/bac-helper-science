
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bac_helper_sc/screens/home_page.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: const Color(0xFFFBFBFB),
      splash: Column(
        children: [
          Expanded(
            child: Center(
              child: LottieBuilder.asset(
                'assets/animation/bac_splash.json',
              ),
            ),
          ),
          const SizedBox(height: 15,),
          const Text('رفيق البكالوريا',
              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color : Colors.black)),
          const SizedBox(height: 10,),
          const Text('شعبة علوم تجريبية',
              style: TextStyle(fontSize: 35,color : Colors.black)),

        ],

      ),
      nextScreen:  const HomePage(),
      splashIconSize: 500, // Adjusted size
    );


  }
}
