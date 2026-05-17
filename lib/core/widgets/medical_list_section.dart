import 'package:flutter/material.dart';
import 'medical_item_card.dart';
import 'empty_section.dart';

class MedicalListSection extends StatelessWidget {
  final String title;
  final bool activedTitle;
  final VoidCallback? onSeeAllPressed;
  final List<Map<String, dynamic>> items; // Données des centres/labos

  const MedicalListSection({
    super.key,
    required this.title,
    this.activedTitle = false,
    this.onSeeAllPressed,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    // Si la liste est vide, on affiche la section vide
    if (items.isEmpty) return EmptySection(title: title, noBackground: true);

    final theme = Theme.of(context);

    return Column(
      children: [
        // --- HEADER DE LA SECTION ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (activedTitle) ...[
                // Titre dynamique (Blanc en sombre, Noir en clair)
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                if (onSeeAllPressed != null)
                  TextButton(
                    onPressed: onSeeAllPressed,
                    child: Text(
                      "Voir tout",
                      style: TextStyle(
                        color: Colors.blue.shade400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
              ]
            ],
          ),
        ),

        // --- LISTE DES ITEMS ---
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final itemData = items[index];

            // CORRECTION ICI : On passe l'objet entier 'itemData' au paramètre 'item'
            return MedicalItemCard(
              item: itemData,
            );
          },
        ),
      ],
    );
  }
}