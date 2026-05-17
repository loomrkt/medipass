import 'package:flutter/material.dart';

// --- WIDGET 1 : LA SECTION (La liste) ---
class MedicalListSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final VoidCallback onSeeAllPressed;
  final bool activedTitle;

  const MedicalListSection({
    super.key,
    required this.title,
    required this.items,
    required this.onSeeAllPressed,
    this.activedTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête de section (Titre + Voir tout)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              if (activedTitle)
                TextButton(
                  onPressed: onSeeAllPressed,
                  child: Text(
                    "Voir tout",
                    style: TextStyle(
                        color: Colors.blue.shade400,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          // Liste des cartes générées dynamiquement
          Column(
            children: items.map((item) => MedicalItemCard(item: item)).toList(),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET 2 : LA CARTE INDIVIDUELLE (Correction Mode Sombre) ---
class MedicalItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const MedicalItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // cardColor : Blanc en light, Gris anthracite (0xFF2A2A2A) en dark
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        // Bordure subtile pour le relief en mode sombre
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Zone Image / Icône
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.05) : const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.local_hospital_outlined,
                  color: isDark ? Colors.blue.shade300 : const Color(0xFF2B88F0),
                ),
              ),
              const SizedBox(width: 16),
              // Textes (Nom, Slogan, Horaire)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['name'] ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['slogan'] ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: Colors.blue.shade300),
                        const SizedBox(width: 4),
                        Text(
                          item['time'] ?? '',
                          style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Icône localisation
              Icon(Icons.location_on_outlined, color: Colors.blue.shade300, size: 20),
            ],
          ),

          // Bouton "Prendre rendez-vous" (s'il est activé)
          if (item['showButton'] == true) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  // En mode sombre, on utilise un bleu très doux avec opacité
                  backgroundColor: isDark
                      ? Colors.blue.withOpacity(0.15)
                      : const Color(0xFFEBF4FF),
                  foregroundColor: const Color(0xFF2B88F0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  "Prendre rendez-vous",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}