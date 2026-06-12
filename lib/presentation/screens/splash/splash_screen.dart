import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const LoginScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.background,
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [

              Image.asset(
                'assets/logo/feedbee_logo1.png',
                height: 130,
              ),

              const SizedBox(height: 24),

              const Text(
                'FeedBee',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight:
                      FontWeight.w800,
                  color:
                      AppColors.textPrimary,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Collect. Improve. Grow.',
                textAlign:
                    TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 50),

              const SizedBox(
                width: 30,
                height: 30,
                child:
                    CircularProgressIndicator(
                  strokeWidth: 3,
                  color:
                      AppColors.primary,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Powered by FeedBee',
                style: TextStyle(
                  color:
                      AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}