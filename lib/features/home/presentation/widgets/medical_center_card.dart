import 'package:flutter/material.dart';

class MedicalCenterCard extends StatelessWidget {
  final String name;
  final String slogan;
  final String? imageUrl;

  const MedicalCenterCard({
    super.key,
    required this.name,
    required this.slogan,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Rechercher un centre médical",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.grey[300],
                width: 50,
                height: 50,
                child: imageUrl != null 
                    ? Image.network(imageUrl!, fit: BoxFit.cover)
                    : const Icon(Icons.local_hospital, color: Colors.blue),
              ),
            ),
            title: Text(name),
            subtitle: Text(slogan),
            trailing: const Icon(Icons.location_on_outlined, color: Colors.blue),
          ),
        ),
      ],
    );
  }
}