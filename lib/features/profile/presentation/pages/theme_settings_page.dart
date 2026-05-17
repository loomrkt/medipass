import 'package:flutter/material.dart';
import '../../../../core/services/theme_service.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres du thème"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildThemeOption(
              context,
              title: "Mode Clair",
              icon: Icons.light_mode_outlined,
              mode: ThemeMode.light,
            ),
            const SizedBox(height: 15),
            _buildThemeOption(
              context,
              title: "Mode Sombre",
              icon: Icons.dark_mode_outlined,
              mode: ThemeMode.dark,
            ),
            const SizedBox(height: 15),
            _buildThemeOption(
              context,
              title: "Thème Personnalisé (Système)",
              icon: Icons.palette_outlined,
              mode: ThemeMode.system,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, {
    required String title,
    required IconData icon,
    required ThemeMode mode,
  }) {
    bool isSelected = ThemeService.instance.themeMode == mode;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        border: isSelected ? Border.all(color: const Color(0xFF2B88F0), width: 2) : null,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? const Color(0xFF2B88F0) : null),
        title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        trailing: isSelected ? const Icon(Icons.check_circle, color: Color(0xFF2B88F0)) : null,
        onTap: () => ThemeService.instance.setTheme(mode),
      ),
    );
  }
}