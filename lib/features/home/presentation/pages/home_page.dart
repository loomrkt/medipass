import 'package:flutter/material.dart';
import '../widgets/home_header_widget.dart'; // Vérifie bien le nom du fichier
import '../widgets/section_card.dart';      // Convention snake_case recommandée

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      body: Stack(
        children: [
          // Fond dégradé
          Container(
            height: 300,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.6, 1.0],
                colors: [
                  Color(0xFF2B88F0), // Radiant blue from the images
                  Color(0xFFB1D8FB), // Lighter blue transition
                  Colors.white,      // Fades completely into white
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Remplacement de _buildHeader() par le Widget
                  const HomeHeaderWidget(), 
                  
                  SectionCard(
                    title: "Mes Tickets",
                    children: [
                      _buildTicketItem("Mal au ventre", "Hospital", "il y a 2h", Colors.green),
                      const Divider(),
                      _buildTicketItem("Infection bucale", "Hospital", "il y a 2 mois", Colors.red),
                    ],
                  ),

                  SectionCard(
                    title: "Mes discussion IA",
                    children: [
                      _buildTicketItem("Mal au ventre", null, "il y a 2h", null),
                      const Divider(),
                      _buildTicketItem("Infection bucale", null, "il y a 2 mois", null),
                    ],
                  ),

                  _buildMedicalCenterSearch(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Garde ces méthodes ici pour l'instant, ou transforme les aussi en widgets 
  // dans le dossier /widgets pour une Clean Arch parfaite !
  Widget _buildTicketItem(String title, String? hospital, String time, Color? statusColor) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: statusColor != null 
          ? Icon(Icons.circle, color: statusColor, size: 12) 
          : null,
      title: Text("Ticket - $title", style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text("${hospital != null ? '$hospital | ' : ''}Mis à jour $time"),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  Widget _buildMedicalCenterSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Rechercher un centre médical", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(color: Colors.grey[300], width: 50, height: 50),
              ),
              title: const Text("Salfa Andohalo"),
              subtitle: const Text("Izahay mitsabo, jesosy manasitran"),
              trailing: const Icon(Icons.location_on_outlined),
            ),
          ),
        ],
      ),
    );
  }
}