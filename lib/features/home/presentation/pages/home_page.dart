import 'package:flutter/material.dart';
import '../widgets/home_header_widget.dart';
import '../../../../core/widgets/medical_list_section.dart';
import '../widgets/ActivitySection.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  // Données simulées
  final List<Map<String, dynamic>> ticketsData = [
    {
      "title": "Mal au ventre",
      "subtitlePrefix": "Hospital",
      "time": "il y a 2h",
      "statusColor": Colors.green,
    },
    {
      "title": "Infection bucale",
      "subtitlePrefix": "Hospital",
      "time": "il y a 2 mois",
      "statusColor": Colors.red,
    },
    {
      "title": "Infection bucale",
      "subtitlePrefix": "Hospital",
      "time": "il y a 2 mois",
      "statusColor": Colors.red,
    },
  ];

  final List<Map<String, dynamic>> iaData = [
    {
      "title": "Mal au ventre",
    },
    {
      "title": "Consultation IA - Symptômes",
    },
  ];

  final List<Map<String, dynamic>> centresData = [
    {
      "name": "Salfa Andohalo",
      "slogan": "Izahay mitsabo, jesosy manasitran",
      "time": "10:30am - 5:30pm",
      "showButton": true,
    },
    {
      "name": "Salfa Andohalo",
      "slogan": "Izahay mitsabo, jesosy manasitran",
      "time": "10:30am - 5:30pm",
      "showButton": true,
    },
  ];

  final List<Map<String, dynamic>> labosData = [
    {
      "name": "Salfa Andohalo",
      "slogan": "Izahay mitsabo, jesosy manasitran",
      "time": "10:30am - 5:30pm",
      "showButton": false,
    },
    {
      "name": "Salfa Andohalo",
      "slogan": "Izahay mitsabo, jesosy manasitran",
      "time": "10:30am - 5:30pm",
      "showButton": false,
    },
  ];

@override
Widget build(BuildContext context) {
  return Scaffold(
    // On enlève le Stack ici
    body: SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Container(
        // Le dégradé est appliqué ici
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9F9), 
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.2, 0.4, 1.0], 
            colors: [
              Color(0xFF2B88F0), // Bleu vif
              Color(0xFFB1D8FB), // Bleu clair
              Color(0xFFF9F9F9), // Transition vers blanc cassé
              Color(0xFFF9F9F9), // Maintien du blanc cassé jusqu'en bas
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const HomeHeaderWidget(),
              ActivitySection(title: "Mes Tickets", data: ticketsData),
              ActivitySection(title: "Mes discussions IA", data: iaData),
              const SizedBox(height: 10),
              MedicalListSection(
                title: "Rechercher un centre",
                onSeeAllPressed: () {},
                items: centresData,
                activedTitle: true,
              ),
              const SizedBox(height: 10),
              MedicalListSection(
                title: "Rechercher un laboratoire",
                onSeeAllPressed: () {},
                items: labosData,
                activedTitle: true,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ),
  );
}

}