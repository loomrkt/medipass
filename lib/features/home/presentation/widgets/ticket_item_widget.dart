import 'package:flutter/material.dart';

class TicketItemWidget extends StatelessWidget {
  final String title;
  final String? subtitlePrefix;
  final String time;
  final Color? statusColor;

  const TicketItemWidget({
    super.key,
    required this.title,
    this.subtitlePrefix,
    required this.time,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: statusColor != null
          ? Icon(Icons.circle, color: statusColor, size: 12)
          : null,
      title: Text(
        "Ticket - $title",
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        "${subtitlePrefix != null ? '$subtitlePrefix | ' : ''}Mis à jour $time",
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}