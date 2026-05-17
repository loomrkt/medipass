import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';

class SupabaseService {
  SupabaseService._();
  static final SupabaseService instance = SupabaseService._();

  final SupabaseClient client = Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }

  // --- GETTERS ---
  String get userName => client.auth.currentUser?.userMetadata?['name'] ??
      client.auth.currentUser?.userMetadata?['display_name'] ?? "Utilisateur";

  String? get avatarUrl => client.auth.currentUser?.userMetadata?['avatar_url'];
  String get userEmail => client.auth.currentUser?.email ?? "";
  String? get pendingEmail => client.auth.currentUser?.newEmail;
  bool get isEmailChangePending => pendingEmail != null;

  // --- ACTIONS ---
  Future<bool> updateDisplayName(String newName) async {
    try {
      await client.auth.updateUser(UserAttributes(data: {'name': newName}));
      return true;
    } catch (e) { return false; }
  }

  Future<String?> uploadAvatar(File imageFile) async {
    try {
      final user = client.auth.currentUser;
      if (user == null) return null;
      final fileName = '${user.id}/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await client.storage.from('avatars').upload(fileName, imageFile,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true));
      final String publicUrl = client.storage.from('avatars').getPublicUrl(fileName);
      await client.auth.updateUser(UserAttributes(data: {'avatar_url': publicUrl}));
      return publicUrl;
    } catch (e) { return null; }
  }

  // --- SÉCURITÉ ---
  Future<Map<String, dynamic>> updateEmail(String newEmail) async {
    try {
      await client.auth.updateUser(
        UserAttributes(email: newEmail),
        emailRedirectTo: 'com.example.medipass://login-callback',
      );
      return {'success': true};
    } on AuthException catch (e) {
      return {'success': false, 'error': e.message};
    }
  }

  Future<Map<String, dynamic>> changePassword({required String oldPassword, required String newPassword}) async {
    try {
      final email = client.auth.currentUser?.email;
      await client.auth.signInWithPassword(email: email!, password: oldPassword);
      await client.auth.updateUser(UserAttributes(password: newPassword));
      return {'success': true};
    } on AuthException catch (e) {
      return {'success': false, 'error': "L'ancien mot de passe est incorrect."};
    } catch (e) {
      return {'success': false, 'error': "Erreur lors de la modification."};
    }
  }

  // --- DÉCONNEXION (LA MÉTHODE APPELÉE) ---
  Future<void> signOut() async {
    await client.auth.signOut();
  }
}