import 'package:flutter/material.dart';
import '../../../../core/widgets/medical_list_section.dart';
import '../widgets/search_input.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isCentresSelected = true;
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> centresData = [
    {"name": "Salfa Andohalo", "slogan": "La santé pour vous", "time": "10:30am - 5:30pm", "showButton": true},
    {"name": "Centre Anosy", "slogan": "Excellence médicale", "time": "08:00am - 04:00pm", "showButton": true},
  ];

  final List<Map<String, dynamic>> labosData = [
    {"name": "Labo Salfa", "slogan": "Analyses précises", "time": "07:30am - 05:30pm", "showButton": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // On garde le fond très clair pour le contraste
      backgroundColor: const Color.fromARGB(255, 155, 155, 155), // Bleu électrique
      body: Stack(
        children: [
          // 1. Le fond dégradé dynamique
          _buildDynamicHeader(),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildAppBar(),
                const SizedBox(height: 10),
                
                // Barre de recherche
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SearchInput(),
                ),
                
                const SizedBox(height: 10),

                // 2. Le sélecteur d'onglets (Style Pill)
                _buildGlassToggle(),

                const SizedBox(height: 25),

                // 3. Conteneur de liste avec arrondi inversé
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
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: MedicalListSection(
                          title: isCentresSelected ? "Centres Médicaux" : "Laboratoires d'Analyses",
                          items: isCentresSelected ? centresData : labosData,
                          onSeeAllPressed: () {},
                        ),
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

  Widget _buildDynamicHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
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
                "Santé & Soins",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                "Trouvez le meilleur centre",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.person_outline, color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget _buildGlassToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          _buildToggleButton("Centres", isCentresSelected, () => setState(() => isCentresSelected = true)),
          _buildToggleButton("Laboratoires", !isCentresSelected, () => setState(() => isCentresSelected = false)),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            boxShadow: isActive 
                ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))] 
                : [],
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? const Color(0xFF1A73E8) : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}