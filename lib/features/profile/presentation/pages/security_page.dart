import 'package:flutter/material.dart';
import '../../../../core/services/supabase_service.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  final _emailController = TextEditingController(text: SupabaseService.instance.userEmail);
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  void _showMessage(String msg, bool isError) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? Colors.redAccent : const Color(0xFF2B88F0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 30),

            _buildSection(
              title: "Compte Email",
              icon: Icons.alternate_email,
              children: [
                if (SupabaseService.instance.isEmailChangePending)
                  _buildPendingWarning(),
                _buildInputField(controller: _emailController, label: "Adresse Email liée"),
                const SizedBox(height: 15),
                _buildButton("Mettre à jour l'email", _handleUpdateEmail, isSecondary: true),
              ],
            ),

            const SizedBox(height: 20),

            _buildSection(
              title: "Mot de passe",
              icon: Icons.lock_outline,
              children: [
                _buildInputField(controller: _oldPasswordController, label: "Ancien mot de passe", isPassword: true),
                const SizedBox(height: 10),
                _buildInputField(controller: _newPasswordController, label: "Nouveau mot de passe", isPassword: true),
                const SizedBox(height: 10),
                _buildInputField(controller: _confirmPasswordController, label: "Confirmer nouveau mot de passe", isPassword: true),
                const SizedBox(height: 20),
                _buildButton("Valider le nouveau mot de passe", _handleUpdatePassword),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingWarning() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "Changement vers ${SupabaseService.instance.pendingEmail} en attente. Vérifiez vos DEUX boîtes mail.",
        style: const TextStyle(color: Colors.orange, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  Future<void> _handleUpdateEmail() async {
    setState(() => _isLoading = true);
    final res = await SupabaseService.instance.updateEmail(_emailController.text);
    setState(() => _isLoading = false);
    if (res['success']) {
      _showDoubleConfirmationDialog();
    } else {
      _showMessage(res['error'] ?? "Erreur", true);
    }
  }

  void _showDoubleConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Action requise"),
        content: const Text("Cliquez sur les liens envoyés sur votre ANCIENNE et votre NOUVELLE adresse email."),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }

  Future<void> _handleUpdatePassword() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      _showMessage("Les mots de passe ne correspondent pas", true); return;
    }
    setState(() => _isLoading = true);
    final res = await SupabaseService.instance.changePassword(
      oldPassword: _oldPasswordController.text,
      newPassword: _newPasswordController.text,
    );
    setState(() => _isLoading = false);
    if (res['success']) {
      _showMessage("Mot de passe mis à jour ! Vérifiez vos emails.", false);
      _oldPasswordController.clear(); _newPasswordController.clear(); _confirmPasswordController.clear();
    } else { _showMessage(res['error'], true); }
  }

  Widget _buildHeader() {
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
            const Text("Sécurité", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required IconData icon, required List<Widget> children}) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
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
              Icon(icon, color: const Color(0xFF2B88F0)),
              const SizedBox(width: 10),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: theme.textTheme.bodyLarge?.color)),
            ],
          ),
          Divider(height: 30, color: theme.dividerColor.withOpacity(0.1)),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String label, bool isPassword = false}) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          style: TextStyle(color: theme.textTheme.bodyLarge?.color),
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.brightness == Brightness.dark ? Colors.white.withOpacity(0.05) : const Color(0xFFF8FAFC),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String label, VoidCallback action, {bool isSecondary = false}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _isLoading ? null : action,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSecondary ? Colors.blue.shade50.withOpacity(0.1) : const Color(0xFF2B88F0),
          foregroundColor: isSecondary ? const Color(0xFF2B88F0) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : Text(label),
      ),
    );
  }
}