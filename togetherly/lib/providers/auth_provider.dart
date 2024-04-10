import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider(this._authService) {
    log("AuthProvider created");
    refresh();
  }

  final AuthService _authService;

  User? _user;
  User? get user => _user;

  Session? _session;
  Session? get session => _session;

  Future<AuthException?> signUp(String email, String password) async {
    final res = await _authService.signUp(email, password);
    await refresh();
    return res;
  }

  Future<AuthException?> signIn(String email, String password) async {
    final res = await _authService.signIn(email, password);
    await refresh();
    return res;
  }

  Future<void> updateAuthUser(int familyId) async {
    await _authService.updateAuthUser(familyId);
    await refresh();
  }

  Future<void> logout() async {
    await _authService.logout();
    await refresh();
  }

  Future<void> refresh() async {
    _user = _authService.getCurrentUser();
    _session = _authService.getCurrentSession();
    notifyListeners();
    log("AuthProvider refreshed!");
  }
}
