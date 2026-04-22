import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class TicketItemWidget extends StatelessWidget {
  final String title;
  final String? subtitlePrefix;
  final String? time;
  final Color? statusColor;

  const TicketItemWidget({
    super.key,
    required this.title,
    this.subtitlePrefix,
    this.time,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    // 1. On vérifie si on a au moins une info à afficher
    final hasSubtitle = subtitlePrefix != null || time != null;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: statusColor != null
          ? Icon(Icons.circle, color: statusColor, size: 12)
          : null,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      // 2. Si pas de données, on passe null pour masquer l'espace
      subtitle: hasSubtitle 
          ? Text("${subtitlePrefix ?? ''}${subtitlePrefix != null && time != null ? ' | ' : ''}${time != null ? 'Mis à jour $time' : ''}")
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        GoRouter.of(context).go("/conversation/${statusColor == Colors.blue ? 'ia' : 'ticket'}/$title");
      },
    );
  }
}