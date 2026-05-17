import 'package:flutter/material.dart';

class ActivitySection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;

  const ActivitySection({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    final bool isIA = title.toLowerCase().contains("ia");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 20, 25, 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return _buildActivityCard(context, item, isIA);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActivityCard(BuildContext context, Map<String, dynamic> item, bool isIA) {
    final theme = Theme.of(context);

    return Container(
      width: 220,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: theme.cardColor, // Gris clair/Anthracite en mode sombre
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(theme.brightness == Brightness.dark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Icône avec cercle de fond pour le contraste
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isIA ? Colors.purple.withOpacity(0.1) : const Color(0xFF2B88F0).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isIA ? Icons.auto_awesome : Icons.confirmation_number_outlined,
                  size: 18,
                  color: isIA ? Colors.purple : const Color(0xFF2B88F0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item['time'] ?? "En cours",
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              // Badge de statut amélioré
              if (item['statusColor'] != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (item['statusColor'] as Color).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item['statusColor'] == Colors.green ? "Validé" : "Urgent",
                    style: TextStyle(
                      color: item['statusColor'],
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}