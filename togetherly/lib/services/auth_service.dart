import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService([SupabaseClient? supabaseClient])
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  Future<AuthException?> signUp(String email, String password) async {
    try {
      await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'family_id': null},
      );
      return null;
    } on AuthException catch (err) {
      return err;
    }
  }

  Future<AuthException?> signIn(String email, String password) async {
    try {
      await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return null;
    } on AuthException catch (err) {
      return err;
    }
  }

  Future<AuthException?> updateAuthUser(int familyId) async {
    try {
      await _supabaseClient.auth.updateUser(
        UserAttributes(
          data: {'family_id': familyId},
        ),
      );
      return null;
    } on AuthException catch (err) {
      return err;
    }
  }

  User? getCurrentUser() {
    return _supabaseClient.auth.currentUser;
  }

  Session? getCurrentSession() {
    return _supabaseClient.auth.currentSession;
  }

  Future<void> logout() async {
    await _supabaseClient.auth.signOut();
  }
}
