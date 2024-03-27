import 'dart:developer';

import 'package:flutter/foundation.dart';

class UserIdentityProvider with ChangeNotifier {
  UserIdentityProvider() {
    log("UserProvider created");
    // TODO: Remove temporary hard-coded IDs once authentication is done.
    _familyId = 1;
    // Child:
    // _personId = 3;
    // Parent:
    _personId = 4;
  }

  int? _familyId;
  int? get familyId => _familyId;

  int? _personId;
  int? get personId => _personId;

  void setIdentity(int familyId, int personId) {
    _familyId = familyId;
    _personId = personId;
    notifyListeners();
  }

  void clearIdentity() {
    _familyId = null;
    _personId = null;
    notifyListeners();
  }

  // TODO:
  // Have this provider talk to an AuthService to get session information.
  // Use session information to get the family ID.
  // Have this provider talk to a UserIdentityService (or something along those
  // lines) to get the person ID.
}
