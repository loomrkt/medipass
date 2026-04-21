import 'package:flutter/material.dart';
import '../../../../core/widgets/section_card.dart';
import '../../../../core/widgets/ticket_item_widget.dart';
import '../../../../core/widgets/empty_section.dart';

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
                subtitlePrefix: item['subtitlePrefix'] ?? null,
                time: item['time'] ?? null,
                statusColor: item['statusColor'] ?? null,
              ),
              if (index < data.length - 1) const Divider(),
            ],
          );
        },
      ),
    );
  }
}