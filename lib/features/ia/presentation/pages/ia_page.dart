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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // 1. Fond dégradé dynamique
          _buildDynamicHeader(isDark),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildAppBar(),
                const SizedBox(height: 25),

                // 2. Widget "Glass"
                _buildGlassInfoCard(isDark),

                const SizedBox(height: 30),

                // 3. Conteneur de liste avec arrondi inversé
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? theme.cardColor : const Color(0xFFF5F7FA),
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
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      child: ListView.builder(
                        // CORRECTION : On augmente le padding du bas à 140 pour ne pas être caché par la NavBar
                        padding: const EdgeInsets.fromLTRB(24, 30, 24, 140),
                        physics: const BouncingScrollPhysics(),
                        itemCount: iaDiscussions.length,
                        itemBuilder: (context, index) {
                          final item = iaDiscussions[index];
                          return _buildChatTile(item, isDark);
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
      // Bouton flottant
      floatingActionButton: Padding(
        // On monte aussi un peu le bouton pour qu'il ne touche pas la NavBar
        padding: const EdgeInsets.only(bottom: 90),
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: const Color(0xFF2B88F0),
          icon: const Icon(Icons.add_comment, color: Colors.white),
          label: const Text("Nouvelle Analyse",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildDynamicHeader(bool isDark) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [const Color(0xFF1A3A5F), const Color(0xFF121212)]
              : [const Color(0xFF2B88F0), const Color(0xFF53A3FF), const Color(0xFF78B2F4)],
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
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 0.5),
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

  Widget _buildGlassInfoCard(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.black38 : Colors.white.withOpacity(0.15),
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
                  "L'IA peut vous aider à comprendre vos symptômes.",
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChatTile(Map<String, dynamic> item, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF333333) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black.withOpacity(0.03),
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
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: isDark ? Colors.white : const Color(0xFF2D3142)
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Icon(Icons.calendar_today, size: 12, color: isDark ? Colors.white54 : Colors.grey.shade400),
              const SizedBox(width: 4),
              Text(item['date'], style: TextStyle(color: isDark ? Colors.white54 : Colors.grey.shade500, fontSize: 12)),
            ],
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 14, color: isDark ? Colors.white38 : Colors.grey),
        onTap: () {},
      ),
    );
  }
}