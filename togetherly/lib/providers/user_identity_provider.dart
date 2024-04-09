import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/auth_provider.dart';

class UserIdentityProvider with ChangeNotifier {
  UserIdentityProvider(this._authProvider) {
    log("UserProvider created");
    refresh();
  }

  AuthProvider _authProvider;

  int? _familyId;
  int? get familyId => _familyId;

  int? _personId;
  int? get personId => _personId;

  Future<void> setPersonId(int? personId) async {
    _personId = personId;
    notifyListeners();
  }

  Future<void> refresh() async {
    _familyId = _authProvider.user?.userMetadata?['family_id'];
    notifyListeners();
    log("UserProvider refreshed!");
  }

  void updateDependencies(AuthProvider authProvider) {
    _authProvider = authProvider;
    refresh();
  }

  // TODO:
  // Have this provider talk to an AuthService to get session information.
  // Use session information to get the family ID.
  // Have this provider talk to a UserIdentityService (or something along those
  // lines) to get the person ID.
}
