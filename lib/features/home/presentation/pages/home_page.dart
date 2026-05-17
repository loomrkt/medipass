import 'package:flutter/material.dart';
import '../widgets/home_header_widget.dart';
import '../../../../core/widgets/medical_list_section.dart';
import '../widgets/ActivitySection.dart';
import '../controllers/home_controller.dart';
import '../../../../core/services/theme_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  late final HomeController _controller;

  // Données simulées
  final List<Map<String, dynamic>> ticketsData = [
    {"title": "Mal au ventre", "time": "il y a 2h", "statusColor": Colors.green},
    {"title": "Infection bucale", "time": "il y a 2 mois", "statusColor": Colors.red},
  ];

  final List<Map<String, dynamic>> iaData = [
    {"title": "Analyse de symptômes"},
    {"title": "Consultation IA"},
  ];

  final List<Map<String, dynamic>> centresData = [
    {"name": "Salfa Andohalo", "slogan": "La santé pour vous", "time": "10:30am - 5:30pm", "showButton": true},
  ];

  @override
  void initState() {
    super.initState();
    _controller = HomeController();
    _controller.loadUserProfile();
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 1. LE FOND DÉGRADÉ (Haut de page)
          _buildDynamicHeader(isDark),

          // 2. LE CONTENU SCROLLABLE
          SafeArea(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, child) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Header (Nom + Avatar) - Toujours au dessus du bleu
                      HomeHeaderWidget(onProfileReturn: _refresh),

                      const SizedBox(height: 30),

                      // 3. LE CORPS ARRONDI (Comme sur votre image)
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.7,
                        ),
                        decoration: BoxDecoration(
                          // Gris anthracite en sombre, gris bleuté très clair en light
                          color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F7FA),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDark ? Colors.black54 : Colors.black12,
                              blurRadius: 20,
                              offset: const Offset(0, -5),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),

                            // Petite barre horizontale indicative (Style iOS)
                            Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // SECTIONS DE L'ACCUEIL
                            ActivitySection(title: "Mes Tickets", data: ticketsData),
                            ActivitySection(title: "Mes discussions IA", data: iaData),

                            const SizedBox(height: 10),

                            MedicalListSection(
                              title: "Rechercher un centre",
                              onSeeAllPressed: () {},
                              items: centresData,
                              activedTitle: true,
                            ),

                            const SizedBox(height: 50), // Espace final
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour le dégradé bleu/noir du haut
  Widget _buildDynamicHeader(bool isDark) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
            const Color(0xFF0D1B2A), // Bleu très sombre (Presque noir)
            const Color(0xFF121212), // Noir pur
          ]
              : [
            const Color(0xFF2B88F0), // Bleu MediPass
            const Color(0xFF53A3FF),
            const Color(0xFF78B2F4),
          ],
        ),
      ),
    );
  }
}