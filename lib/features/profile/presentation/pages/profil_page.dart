import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 15),
            _buildUserInfo(),
            const SizedBox(height: 30),
            _buildMenuSection([
              _buildMenuItem(Icons.badge_outlined, "Edit profile information"),
              _buildMenuItem(Icons.notifications_none, "Notifications", trailing: "ON"),
              _buildMenuItem(Icons.translate, "Language", trailing: "English"),
            ]),
            _buildMenuSection([
              _buildMenuItem(Icons.admin_panel_settings_outlined, "Security"),
              _buildMenuItem(Icons.lock_outline, "Theme Settings"), // Changé pour éviter le doublon "Security"
            ]),
            _buildMenuSection([
              _buildMenuItem(Icons.person_search_outlined, "Help & Support"),
              _buildMenuItem(Icons.chat_bubble_outline, "Contact us"),
              _buildMenuItem(Icons.privacy_tip_outlined, "Privacy policy"),
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Fond dégradé avec courbe
        Container(
          height: 220,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2B88F0), Color(0xFF53A3FF)],
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(200, 30),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://i.postimg.cc/mrh98v9R/logo-medipass.png', // Remplace par ton asset
                    height: 40,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.add_box, color: Colors.white, size: 40),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "MediPass",
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        // Photo de profil
        Positioned(
          bottom: -50,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: const CircleAvatar(
                  radius: 65,
                  backgroundImage: NetworkImage('https://placeholder.com/profile_image'), // Ton image
                ),
              ),
              Positioned(
                bottom: 0,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: const Icon(Icons.edit_outlined, size: 20, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Column(
        children: [
          const Text(
            "RAKOTONDRAZAKA Nameno F.",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF2D3142)),
          ),
          const SizedBox(height: 5),
          Text(
            "youremail@domain.com",
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
          ),
          Text(
            "+261 234 567 89",
            style: TextStyle(fontSize: 15, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {String? trailing}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87, size: 24),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF2D3142)),
      ),
      trailing: trailing != null
          ? Text(
              trailing,
              style: const TextStyle(color: Color(0xFF2B88F0), fontWeight: FontWeight.bold),
            )
          : null,
      onTap: () {},
    );
  }
}