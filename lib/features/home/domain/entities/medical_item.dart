// domain/entities/medical_item.dart
class MedicalItem {
  final String title;
  final String? subtitle;
  final String time;
  final dynamic statusColor; // Utiliser un code Hex ou String pour rester pur

  MedicalItem({required this.title, this.subtitle, required this.time, this.statusColor});
}

// domain/entities/medical_center.dart
class MedicalCenter {
  final String name;
  final String slogan;
  final String time;
  final bool showButton;

  MedicalCenter({required this.name, required this.slogan, required this.time, this.showButton = false});
}