import 'package:flutter/material.dart';
import '../../../../core/services/auth_service.dart';

class HomeController extends ChangeNotifier {
  Map<String, dynamic>? _userProfile;
  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  String get userName => _userProfile?['name'] ?? 'Utilisateur';
  String get userEmail => _userProfile?['email'] ?? '';
  String get greeting => 'Bonjour, $userName';

  Future<void> loadUserProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userProfile = await AuthService.instance.getUserProfile();
      if (_userProfile == null) {
        _error = 'Impossible de charger le profil utilisateur';
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshProfile() async {
    await loadUserProfile();
  }
}
