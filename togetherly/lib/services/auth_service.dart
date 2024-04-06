import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  Future<AuthException?> signUp(String email, String password) async {
    try {
      final AuthResponse res = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
      return null;
    } on AuthException catch (err) {
      return err;
    }
  }

  Future<AuthException?> signIn(String email, String password) async {
    try {
      final AuthResponse res =
          await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return null;
    } on AuthException catch (err) {
      return err;
    }
  }

  User? getCurrentUser() {
    return Supabase.instance.client.auth.currentUser;
  }

  Session? getCurrentSession() {
    return Supabase.instance.client.auth.currentSession;
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }
}
