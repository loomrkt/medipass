import 'package:supabase_flutter/supabase_flutter.dart';
//import '../mocks/mock_data.dart';

class AuthService {
  static final AuthService instance = AuthService._();
  AuthService._();

  final SupabaseClient _client = Supabase.instance.client;

  User? get currentUser => _client.auth.currentUser;

  // --- LOGIN ---
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return {'success': true, 'user': response.user};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // --- REGISTER ---
  Future<Map<String, dynamic>> register(String email, String password, {String? name}) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: name != null ? {'name': name} : null,
      );
      return {'success': true, 'user': response.user};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // --- MOT DE PASSE OUBLIÉ ---
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
      return {'success': true};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // --- VÉRIFICATION OTP (CORRECTION DE L'ERREUR) ---
  // On enlève les accolades pour accepter verifyOtp(email, token)
  Future<Map<String, dynamic>> verifyOtp(String email, String token, {OtpType type = OtpType.signup}) async {
    try {
      final response = await _client.auth.verifyOTP(
        email: email,
        token: token,
        type: type,
      );
      return {'success': true, 'user': response.user};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // --- RENVOYER OTP ---
  Future<Map<String, dynamic>> resendOtp(String email) async {
    try {
      await _client.auth.resend(email: email, type: OtpType.signup);
      return {'success': true};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // --- RÉCUPÉRER PROFIL ---
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = currentUser;
      if (user == null) return null;
      final metadata = user.userMetadata;
      return {
        'id': user.id,
        'email': user.email,
        'name': metadata?['name'] ?? metadata?['display_name'] ?? "Utilisateur",
        'avatar_url': metadata?['avatar_url'],
      };
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}