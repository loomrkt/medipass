import 'package:flutter/material.dart';
import '../../../../core/services/supabase_service.dart';
// Correction du chemin d'importation (ajout d'un ../ supplémentaire)
import '../../../profile/presentation/pages/profil_page.dart';

class HomeHeaderWidget extends StatelessWidget {
  final VoidCallback onProfileReturn;
  const HomeHeaderWidget({super.key, required this.onProfileReturn});

  @override
  Widget build(BuildContext context) {
    final String userName = SupabaseService.instance.userName;
    final String? avatarUrl = SupabaseService.instance.avatarUrl;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Bonjour,",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              ).then((_) => onProfileReturn());
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white24,
              backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
              child: avatarUrl == null
                  ? const Icon(Icons.person, color: Colors.white)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}