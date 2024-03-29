import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  Future<void> signUp() async {
    final AuthResponse res = await Supabase.instance.client.auth.signUp(
      email: 'example@email.com',
      password: 'example-password',
    );
    final Session? session = res.session;
    final User? user = res.user;
  }
  
  Future<void> logIn() async {
    final AuthResponse res = await Supabase.instance.client.auth.signInWithPassword(
      email: 'example@email.com',
      password: 'example-password',
    );
    final Session? session = res.session;
    final User? user = res.user;
  }
  
  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }
}
