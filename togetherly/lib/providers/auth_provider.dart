import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider(this._authService, this._userIdentityProvider,
      this._personProvider, this._choreProvider) {
    log("AuthProvider created");
    refresh();
  }

  final AuthService _authService;
  UserIdentityProvider _userIdentityProvider;
  PersonProvider _personProvider;
  ChoreProvider _choreProvider;

  User? _user;
  User? get user => _user;

  Session? _session;
  Session? get session => _session;

  Future<AuthException?> signUp(String email, String password) async {
    final res = await _authService.signUp(email, password);
    await refresh();
    await _personProvider.refresh();
    await _choreProvider.refresh();
    return res;
  }

  Future<AuthException?> signIn(String email, String password) async {
    final res = await _authService.signIn(email, password);
    await refresh();
    await _personProvider.refresh();
    await _choreProvider.refresh();
    return res;
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

  void updateDependencies(UserIdentityProvider userIdentityProvider,
      PersonProvider personProvider, ChoreProvider choreProvider) {
    _userIdentityProvider = userIdentityProvider;
    _personProvider = personProvider;
    _choreProvider = choreProvider;
    refresh();
  }
}
