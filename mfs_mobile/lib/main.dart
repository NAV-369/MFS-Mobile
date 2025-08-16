import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize router
    final appRouterInstance = AppRouter().router; // renamed variable

    return MaterialApp.router(
      title: 'MFS Mobile',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouterInstance,
    );
  }
}