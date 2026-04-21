import 'package:flutter/material.dart';

class IAPage extends StatefulWidget {
  const IAPage({super.key});

  @override
  State<IAPage> createState() => _IAPageState();
}

class _IAPageState extends State<IAPage> {
  // Données simulées
  final List<Map<String, dynamic>> iaDiscussions = [
    {"title": "Analyse des symptômes : Mal de ventre", "date": "Aujourd'hui"},
    {"title": "Conseils nutritionnels", "date": "Hier"},
    {"title": "Interprétation de résultat de prise de sang", "date": "12 Oct."},
    {"title": "Questions sur le traitement Hypertension", "date": "05 Oct."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 155, 155, 155), // Cohérence avec SearchPage
      body: Stack(
        children: [
          // 1. Fond dégradé dynamique (Identique à SearchPage)
          _buildDynamicHeader(),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildAppBar(),
                const SizedBox(height: 25),

                // 2. Widget "Glass" - Statistiques rapides ou Information IA
                _buildGlassInfoCard(),

                const SizedBox(height: 30),

                // 3. Liste des discussions avec arrondi inversé
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF5F7FA), // Gris bleuté très clair
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
                        itemCount: iaDiscussions.length,
                        itemBuilder: (context, index) {
                          final item = iaDiscussions[index];
                          return _buildChatTile(item);
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
      // Bouton flottant stylisé
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF2B88F0),
        icon: const Icon(Icons.add_comment, color: Colors.white),
        label: const Text("Nouvelle Analyse", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildDynamicHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2B88F0),
            Color.fromARGB(255, 83, 163, 255),
            Color.fromARGB(255, 120, 178, 244),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assistant IA",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                "Historique de vos consultations",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.auto_awesome, color: Colors.white, size: 20),
          )
        ],
      ),
    );
  }

  Widget _buildGlassInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.white, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Analyse Intelligente",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "L'IA peut vous aider à comprendre vos symptômes avant de voir un médecin.",
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChatTile(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2B88F0).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.chat_bubble_outline, color: Color(0xFF2B88F0), size: 22),
        ),
        title: Text(
          item['title'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF2D3142)),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Icon(Icons.calendar_today, size: 12, color: Colors.grey.shade400),
              const SizedBox(width: 4),
              Text(item['date'], style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
            ],
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}