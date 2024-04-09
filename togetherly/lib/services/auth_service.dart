import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  Future<AuthException?> signUp(String email, String password) async {
    try {
      await Supabase.instance.client.auth.signUp(
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
      await Supabase.instance.client.auth.signInWithPassword(
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
      await Supabase.instance.client.auth.updateUser(
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
    return Supabase.instance.client.auth.currentUser;
  }

  Session? getCurrentSession() {
    return Supabase.instance.client.auth.currentSession;
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }
}
