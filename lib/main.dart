import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'shared/theme/app_theme.dart';

void main() {
  runApp(const MediPassApp());
}

class MediPassApp extends StatelessWidget {
  const MediPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MediPass',
      theme: AppTheme.light,
      routerConfig: AppRouter.router,
    );
  }
}