import 'package:flutter/material.dart';
import 'section_card.dart';

class EmptySection extends StatelessWidget {
  final String title;
  final bool noBackground;

  const EmptySection({super.key, required this.title, this.noBackground=false});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      noBackground: noBackground,
      title: title,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            children: [
              Icon(Icons.inbox_outlined, size: 48, color: Colors.grey[400]),
              const SizedBox(height: 12),
              Text(
                'Aucun élément',
                style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                'Vous n\'avez rien dans cette section pour le moment.',
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}