import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/auth_service.dart';
import 'package:togetherly/services/person_service.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider(this._authService, this._userIdentityProvider) {
    log("AuthProvider created");
    refresh();
  }

  final AuthService _authService;
  // final PersonService _personService;
  UserIdentityProvider _userIdentityProvider;

  User? _user;
  User? get user => _user;

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

  Future<void> logout() async {
    await _authService.logout();
    await refresh();
  }

  Future<void> refresh() async {
    _user = _authService.getCurrentUser();
    notifyListeners();
    log("AuthProvider refreshed!");
  }

  void updateDependencies(UserIdentityProvider userIdentityProvider) {
    _userIdentityProvider = userIdentityProvider;
    refresh();
  }
}
