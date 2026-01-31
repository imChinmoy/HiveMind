import 'package:flutter/material.dart';
import 'package:frontend/config/routes/app_router.dart';
import 'package:frontend/config/themes/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/home/presentation/screens/home_screen.dart';
import 'package:frontend/features/home/presentation/screens/main_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('user');

  runApp(const ProviderScope(child: HiveMindApp()));
}

class HiveMindApp extends ConsumerWidget {
  const HiveMindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: router,
    );

    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: AppTheme.darkTheme,
    //   home: MainNavigationScreen(),
    // );
  }
}
