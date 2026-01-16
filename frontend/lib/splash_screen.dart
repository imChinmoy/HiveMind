import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/config/routes/app_router.dart';
import 'package:frontend/config/themes/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (AppRouter.isLoggedIn) {
      context.go('/home');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/hivemind_loader.json',
              width: 160,
              repeat: true,
            ),

            const SizedBox(height: 24),

            const Text(
              'HiveMind',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Think together. Chat in real time.',
              style: TextStyle(fontSize: 14, color: AppColors.textMuted),
            ),
            const Positioned(
              bottom: 24,
              child: Text(
                'v0.1.0',
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
