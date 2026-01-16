import 'package:flutter/material.dart';
import 'package:frontend/config/routes/app_router.dart';
import 'package:frontend/config/themes/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const HiveMindApp()));
}

class HiveMindApp extends StatelessWidget {
  const HiveMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
