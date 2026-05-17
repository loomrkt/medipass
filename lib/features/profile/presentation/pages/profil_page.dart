import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/supabase_service.dart';
import '../controllers/profile_controller.dart';
import 'security_page.dart';
import 'edit_profile_page.dart';
import 'theme_settings_page.dart'; // Import ajouté

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileController _controller;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _controller = ProfileController();
    _controller.loadUserProfile();
  }

  Future<void> _changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (image != null) {
        setState(() => _isUploading = true);
        final url = await SupabaseService.instance.uploadAvatar(File(image.path));
        if (url != null) setState(() {});
      }
    } catch (e) {
      debugPrint("Erreur upload photo: $e");
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String currentUserName = SupabaseService.instance.userName;
    final String? currentAvatarUrl = SupabaseService.instance.avatarUrl;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Utilisation du thème
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context, currentAvatarUrl),
                const SizedBox(height: 15),
                _buildUserInfo(currentUserName),
                const SizedBox(height: 30),

                _buildMenuSection([
                  _buildMenuItem(
                    Icons.badge_outlined,
                    "Modifier le profil",
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EditProfilePage()),
                      );
                      if (result == true) setState(() {});
                    },
                  ),
                  _buildMenuItem(Icons.notifications_none, "Notifications", trailing: "ON"),
                ]),

                _buildMenuSection([
                  _buildMenuItem(
                    Icons.lock_outline,
                    "Sécurité",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SecurityPage()));
                    },
                  ),
                  _buildMenuItem(
                    Icons.palette_outlined,
                    "Paramètres du thème",
                    onTap: () {
                      // NAVIGATION VERS LES PARAMÈTRES DU THÈME
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeSettingsPage()));
                    },
                  ),
                ]),

                _buildMenuSection([
                  _buildMenuItem(
                    Icons.logout,
                    "Déconnexion",
                    color: Colors.redAccent,
                    onTap: () => _handleLogout(context),
                  ),
                ]),
                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- LOGIQUE DE DÉCONNEXION ---
  Future<void> _handleLogout(BuildContext context) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Déconnexion"),
        content: const Text("Voulez-vous vraiment vous déconnecter ?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Annuler")),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Déconnecter", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    ) ?? false;

    if (confirm) {
      await SupabaseService.instance.signOut();
      if (mounted) context.go('/login-email');
    }
  }

  // --- WIDGETS UI ---

  Widget _buildHeader(BuildContext context, String? avatarUrl) {
    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0, left: 0, right: 0,
            child: Container(
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF2B88F0), Color(0xFF53A3FF)]),
                borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(200, 30)),
              ),
              child: const Center(
                child: Text("MediPass", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Positioned(
            top: 130,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
                child: _isUploading
                    ? const CircularProgressIndicator(color: Color(0xFF2B88F0))
                    : (avatarUrl == null ? const Icon(Icons.person, size: 60, color: Colors.grey) : null),
              ),
            ),
          ),
          Positioned(
            top: 200,
            right: MediaQuery.of(context).size.width / 2 - 65,
            child: GestureDetector(
              onTap: _isUploading ? null : _changeProfilePicture,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(color: Color(0xFF2B88F0), shape: BoxShape.circle),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(String name) {
    return Column(
      children: [
        Text(name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
        const SizedBox(height: 5),
        Text(SupabaseService.instance.userEmail, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

  Widget _buildMenuSection(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {String? trailing, Color? color, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: color ?? const Color(0xFF2D3142)),
      title: Text(title, style: TextStyle(color: color ?? Theme.of(context).textTheme.bodyLarge?.color, fontWeight: FontWeight.w500)),
      trailing: trailing != null
          ? Text(trailing, style: const TextStyle(color: Color(0xFF2B88F0), fontWeight: FontWeight.bold))
          : const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}