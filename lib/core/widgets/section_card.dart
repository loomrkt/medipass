import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool noBackground; // Correction du nom (Background avec deux 'g')

  // On ajoute noBackground ici avec false par défaut
  const SectionCard({
    super.key, 
    required this.title, 
    required this.children, 
    this.noBackground = false, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      // Si noBackground est vrai, on met la décoration à null
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text("Voir tout")),
            ],
          ),
          ...children,
        ],
      ),
    );
  }
}