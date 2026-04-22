import 'package:flutter/material.dart';
import '../widgets/home_header_widget.dart';
import '../../../../core/widgets/medical_list_section.dart';
import '../widgets/ActivitySection.dart';
import 'package:go_router/go_router.dart';

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
    {"title": "Analyse des symptômes : Mal de ventre", "time": "Aujourd'hui"},
    {"title": "Conseils nutritionnels", "time": "Hier"},
    {"title": "Interprétation de résultat de prise de sang", "time": "12 Oct."},
    {"title": "Questions sur le traitement Hypertension", "time": "05 Oct."},
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
              const SizedBox(height: 10),
              const HomeHeaderWidget(),
              ActivitySection(title: "Mes Tickets", data: ticketsData, seeAllRoute: "/tickets"),
              ActivitySection(title: "Mes discussions IA", data: iaData, seeAllRoute: "/ia"),
              const SizedBox(height: 10),
              MedicalListSection(
                title: "Rechercher un centre",
                onSeeAllPressed: () {
                    GoRouter.of(context).go("/search");
                },
                items: centresData,
                activedTitle: true,
              ),
              const SizedBox(height: 10),
              MedicalListSection(
                title: "Rechercher un laboratoire",
                onSeeAllPressed: () {
                    GoRouter.of(context).go("/search");
                },
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