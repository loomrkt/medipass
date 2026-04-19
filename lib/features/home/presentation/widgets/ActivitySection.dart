import 'package:flutter/material.dart';
import 'section_card.dart';
import 'ticket_item_widget.dart';
import 'empty_section.dart';

class ActivitySection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> data;

  const ActivitySection({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return EmptySection(title: title);

    return SectionCard(
      title: title,
      children: List.generate(
        data.length,
        (index) {
          final item = data[index];
          return Column(
            children: [
              TicketItemWidget(
                title: item['title'],
                subtitlePrefix: item['subtitlePrefix'] ?? '',
                time: item['time'],
                statusColor: item['statusColor'] ?? Colors.grey,
              ),
              if (index < data.length - 1) const Divider(),
            ],
          );
        },
      ),
    );
  }
}