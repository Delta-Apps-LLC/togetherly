import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/providers/auth_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/family_service.dart';

class FamilyProvider with ChangeNotifier {
  FamilyProvider(
      this._familyService, this._userIdentityProvider, this._authProvider) {
    log("FamilyProvider created");
    refresh();
  }

  final FamilyService _familyService;
  AuthProvider _authProvider;
  UserIdentityProvider _userIdentityProvider;

  String? _familyName;
  String? get familyName => _familyName;

  Future<void> createFamily(String name) async {
    final res = await _familyService.insertFamily(name);
    await _authProvider.updateAuthUser(res.id!);
    await refresh();
  }

  Future<void> refresh() async {
    final familyId = _userIdentityProvider.familyId;
    if (familyId != null) {
      _familyName = await _familyService.getFamilyName(familyId);
    } else {
      _familyName = null;
    }
    notifyListeners();
    log("FamilyProvider refreshed!");
  }

  void updateDependencies(
      UserIdentityProvider userIdentityProvider, AuthProvider authProvider) {
    _userIdentityProvider = userIdentityProvider;
    _authProvider = authProvider;
    refresh();
  }
}
