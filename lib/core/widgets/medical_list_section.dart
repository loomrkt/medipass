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
    if (items.isEmpty) return EmptySection(title: title, noBackground: true );

    return Column(
      children: [
        // Header de la section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (activedTitle) ...{
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (onSeeAllPressed != null)
                  TextButton(
                    onPressed: onSeeAllPressed,
                    child: const Text("Voir tout", style: TextStyle(color: Colors.blue)),
                  )
              }
            ],
          ),
        ),
        // Liste des items
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = items[index];
            return MedicalItemCard(
              name: item['name'],
              slogan: item['slogan'],
              time: item['time'],
              showAppointmentButton: item['showButton'] ?? false,
            );
          },
        ),
      ],
    );
  }
}