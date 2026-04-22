import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool noBackground;
  final String? seeAllRoute; // Paramètre pour la navigation

  const SectionCard({
    super.key,
    required this.title,
    required this.children,
    this.noBackground = false,
    this.seeAllRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: noBackground
          ? null
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
              ],
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (seeAllRoute != null)
                TextButton(
                  onPressed: () => GoRouter.of(context).go(seeAllRoute!),
                  child: const Text("Voir tout"),
                ),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}