import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/models/parent.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:togetherly/services/person_service.dart';
import 'package:togetherly/utilities/env.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    // In automated unit tests, this would be TestWidgetsFlutterBinding.
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
        url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
  });

  group("PersonService tests", () {
    late PersonService personService;
    setUp(() => personService = PersonService());

    test('getChildren', () async {
      final result = await personService.getChildren(1);
      log("$result");
    });

    test('getParents', () async {
      final result = await personService.getParents(1);
      log("$result");
    });

    test('insertChild', () async {
      final result = await personService.insertChild(const Child(
          familyId: 1,
          pin: "1234",
          name: "John",
          icon: ProfileIcon.dog,
          totalPoints: 10));
      log("$result");
      await personService.deletePerson(result);
    });

    test('insertParent', () async {
      final result = await personService.insertParent(const Parent(
          familyId: 1, pin: "1234", name: "John", icon: ProfileIcon.dog));
      log("$result");
      await personService.deletePerson(result);
    });
  });

  group("ChoreService tests", () {
    late ChoreService choreService;
    setUp(() => choreService = ChoreService());

    test('getChoresByFamily', () async {
      final result = await choreService.getChoresByFamily(1);
      log("$result");
    });

    test('insertChore', () async {
      final result = await choreService.insertChore(
          1,
          Chore(
            title: "Test",
            dueDate: DateTime(2030),
            points: 10,
            isShared: true,
          ));
      log("$result");
      await choreService.deleteChore(result);
    });
  });

  // TODO: Add similar tests for other services.
}
