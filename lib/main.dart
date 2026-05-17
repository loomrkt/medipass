import 'package:flutter/material.dart';
import 'core/services/supabase_service.dart';
import 'core/services/theme_service.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  await ThemeService.instance.init();
  runApp(const MediPassApp());
}

class MediPassApp extends StatelessWidget {
  const MediPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeService.instance,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'MediPass',
          themeMode: ThemeService.instance.themeMode,

          // ===================================================================
          // --- THÈME CLAIR (NavBar Blanche, Icônes Grises/Bleues) ---
          // ===================================================================
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            primaryColor: const Color(0xFF2B88F0),
            scaffoldBackgroundColor: const Color(0xFFF5F7FA),
            cardColor: Colors.white,

            // Correction NavBar Mode Clair
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Color(0xFF2B88F0),
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed, // Indispensable pour éviter les disparitions
              elevation: 20,
            ),
          ),

          // ===================================================================
          // --- THÈME SOMBRE (NavBar Anthracite, Icônes Blanches/Bleues) ---
          // ===================================================================
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            primaryColor: const Color(0xFF2B88F0),
            scaffoldBackgroundColor: const Color(0xFF121212),
            cardColor: const Color(0xFF2A2A2A),

            // Correction NavBar Mode Sombre
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF1E1E1E), // Gris foncé (pas noir pur)
              selectedItemColor: Color(0xFF53A3FF),
              unselectedItemColor: Colors.white60, // Blanc cassé pour visibilité
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              elevation: 20,
            ),
          ),
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}