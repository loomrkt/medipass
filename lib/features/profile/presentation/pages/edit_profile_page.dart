import 'package:flutter/material.dart';
import '../../../../core/services/supabase_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: SupabaseService.instance.userName);
  bool _isLoading = false;

  void _showMessage(String msg, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? Colors.redAccent : const Color(0xFF2B88F0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  Future<void> _updateProfile() async {
    if (_nameController.text.trim().isEmpty) {
      _showMessage("Le nom ne peut pas être vide", true);
      return;
    }

    setState(() => _isLoading = true);
    final success = await SupabaseService.instance.updateDisplayName(_nameController.text.trim());
    setState(() => _isLoading = false);

    if (success) {
      _showMessage("Profil mis à jour avec succès !", false);
      if (mounted) Navigator.pop(context, true);
    } else {
      _showMessage("Erreur lors de la mise à jour", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      // Fond dynamique
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 30),

            _buildSection(
              context,
              title: "Informations Personnelles",
              icon: Icons.person_outline,
              children: [
                _buildInputField(
                  context,
                  controller: _nameController,
                  label: "Nom complet d'affichage",
                  hint: "Ex: Jean Dupont",
                ),
                const SizedBox(height: 30),
                _buildActionButton("Enregistrer les modifications", _updateProfile),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF2B88F0), Color(0xFF53A3FF)]),
        borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(150, 20)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            const Text(
              "Modifier le profil",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required IconData icon, required List<Widget> children}) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Couleur de carte dynamique (Gris anthracite en sombre)
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(theme.brightness == Brightness.dark ? 0.3 : 0.03),
              blurRadius: 15,
              offset: const Offset(0, 8)
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF2B88F0), size: 22),
              const SizedBox(width: 10),
              Text(
                  title,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color
                  )
              ),
            ],
          ),
          Divider(height: 30, color: theme.dividerColor.withOpacity(0.1)),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputField(BuildContext context, {required TextEditingController controller, required String label, String? hint}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: theme.brightness == Brightness.dark ? Colors.white.withOpacity(0.05) : const Color(0xFFF8FAFC),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String title, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: _isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2B88F0),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
        ),
        child: _isLoading
            ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
    );
  }
}