import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  Future<void> signUp(String email, String password) async {
    final AuthResponse res = await Supabase.instance.client.auth.signUp(
      email: 'example@email.com',
      password: 'example-password',
    );
    final Session? session = res.session;
    final User? user = res.user;
  }
  
  Future<void> signIn(String email, String password) async {
    final AuthResponse res = await Supabase.instance.client.auth.signInWithPassword(
      email: 'example@email.com',
      password: 'example-password',
    );
    final Session? session = res.session;
    final User? user = res.user;
  }

  User? getCurrentUser() {
    return Supabase.instance.client.auth.currentUser;
  }
  
  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }
}
