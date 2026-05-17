import 'package:flutter/material.dart';
import '../../../../core/widgets/medical_list_section.dart';
import '../widgets/search_input.dart';

class SearchPage extends StatefulWidget {
  // Indispensable pour être appelé avec "const SearchPage()"
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isCentresSelected = true;
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = "";

  // Données
  final List<Map<String, dynamic>> centresData = [
    {"name": "Salfa Andohalo", "slogan": "La santé pour vous", "time": "10:30am - 5:30pm", "showButton": true},
    {"name": "Centre Anosy", "slogan": "Excellence médicale", "time": "08:00am - 04:00pm", "showButton": true},
  ];

  final List<Map<String, dynamic>> labosData = [
    {"name": "Labo Salfa", "slogan": "Analyses précises", "time": "07:30am - 05:30pm", "showButton": false},
  ];

  List<Map<String, dynamic>> get _filteredItems {
    final source = isCentresSelected ? centresData : labosData;
    if (_searchQuery.isEmpty) return source;
    return source.where((item) {
      final name = item['name'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          _buildDynamicGradient(isDark),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildAppBar(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SearchInput(
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ),
                const SizedBox(height: 30),
                _buildGlassToggle(isDark),
                const SizedBox(height: 25),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
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
                          title: isCentresSelected ? "Centres Médicaux" : "Laboratoires",
                          items: _filteredItems,
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

  Widget _buildDynamicGradient(bool isDark) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark ? [const Color(0xFF1A3A5F), const Color(0xFF121212)] : [const Color(0xFF2B88F0), const Color(0xFF78B2F4)],
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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Santé & Soins", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Trouvez le meilleur centre", style: TextStyle(color: Colors.white70, fontSize: 14)),
          ]),
          CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.person_outline, color: Colors.white))
        ],
      ),
    );
  }

  Widget _buildGlassToggle(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isDark ? Colors.black38 : Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _buildToggleButton("Centres", isCentresSelected, isDark, () => setState(() => isCentresSelected = true)),
          _buildToggleButton("Laboratoires", !isCentresSelected, isDark, () => setState(() => isCentresSelected = false)),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive, bool isDark, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? (isDark ? const Color(0xFF2B88F0) : Colors.white) : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(label, textAlign: TextAlign.center, style: TextStyle(color: isActive ? (isDark ? Colors.white : const Color(0xFF1A73E8)) : Colors.white70, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}