import 'package:flutter/material.dart';

class MedicalItemCard extends StatelessWidget {
  final String name;
  final String slogan;
  final String time;
  final bool showAppointmentButton;

  const MedicalItemCard({
    super.key,
    required this.name,
    required this.slogan,
    required this.time,
    this.showAppointmentButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(color: Colors.grey[200], width: 50, height: 50),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(slogan, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.location_on_outlined, color: Colors.black54),
            ],
          ),
          if (showAppointmentButton) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE3F2FD),
                  foregroundColor: Colors.blue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Prendre rendez-vous"),
              ),
            ),
          ]
        ],
      ),
    );
  }
}