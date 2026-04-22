import 'package:flutter/material.dart';
import 'package:medipass/core/widgets/ticket_item_widget.dart';
import 'package:go_router/go_router.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  // Données simulées cohérentes avec ta HomePage
  final List<Map<String, dynamic>> ticketsData = [
    {
      "title": "Mal au ventre",
      "subtitlePrefix": "Hospital Central",
      "time": "il y a 2h",
      "statusColor": Colors.green,
    },
    {
      "title": "Infection bucale",
      "subtitlePrefix": "Clinique de l'Espoir",
      "time": "il y a 2 mois",
      "statusColor": Colors.red,
    },
    {
      "title": "Consultation Générale",
      "subtitlePrefix": "Hôpital Manambaro",
      "time": "il y a 3 mois",
      "statusColor": Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fond gris très clair pour faire ressortir les cartes blanches
      backgroundColor: const Color(0xFFF5F7FA), 
      body: Stack(
        children: [
          // 1. En-tête avec dégradé bleu
          _buildDynamicHeader(),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildAppBar(),
                const SizedBox(height: 25),

                // 2. Carte d'information style "Glassmorphism"
                _buildGlassStatCard(),

                const SizedBox(height: 30),

                // 3. Conteneur principal de la liste (Arrondi blanc)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F7FA),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: Offset(0, -5),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(24, 30, 24, 100),
                        physics: const BouncingScrollPhysics(),
                        itemCount: ticketsData.length,
                        itemBuilder: (context, index) {
                          final item = ticketsData[index];

                          // --- TON CODE RE-INTÉGRÉ ICI ---
                          return Column(
                            children: [
                              TicketItemWidget(
                                title: item['title'],
                                subtitlePrefix: item['subtitlePrefix'],
                                time: item['time'],
                                statusColor: item['statusColor'],
                              ),
                              if (index < ticketsData.length - 1)
                                Divider(
                                  color: Colors.grey.withOpacity(0.2),
                                  thickness: 1,
                                  height: 32, // Espace autour du trait
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour le fond dégradé en haut de page
  Widget _buildDynamicHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2B88F0),
            Color(0xFF53A3FF),
            Color(0xFF78B2F4),
          ],
        ),
      ),
    );
  }

  // Widget pour la barre d'outils personnalisée
  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
         IconButton(
          onPressed: () => GoRouter.of(context).go("/home"),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white), // Plus centré
        ),
          const Spacer(),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Mes Tickets",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Historique des soins",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Carte d'info semi-transparente
  Widget _buildGlassStatCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStat("3", "Total"),
          _buildStat("1", "En cours"),
          _buildStat("2", "Terminés"),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12)),
      ],
    );
  }
}