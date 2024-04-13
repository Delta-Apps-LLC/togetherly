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

import 'test_data.dart';

/*
These tests are intended to be run manually as a type of integration test, as
they perform actual database read and write operations. These cover a more
limited subset of the functionality of the services, but should be sufficient
to ensure that the services can read and write to the actual database properly.
 */

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    // In automated unit tests, this would be TestWidgetsFlutterBinding.
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
        url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
  });

  group("PersonService tests", () {
    const testChildren = TestChildGenerator(1);
    const testParents = TestParentGenerator(1);
    late PersonService personService;
    setUp(() => personService = PersonService());

    test('getChildren', () async {
      final result = await personService.getChildren(1);
      debugPrint("Result: $result");
    });

    test('getParents', () async {
      final result = await personService.getParents(1);
      debugPrint("Result: $result");
    });

    test('insertChild', () async {
      final input = testChildren.get(0);
      debugPrint("Input: $input");
      final result = await personService.insertChild(input);
      debugPrint("Result: $result");
      await personService.deletePerson(result);
    });

    test('insertParent', () async {
      final input = testParents.get(0);
      debugPrint("Input: $input");
      final result = await personService.insertParent(input);
      debugPrint("Result: $result");
      await personService.deletePerson(result);
    });
  });

  group("ChoreService tests", () {
    const testData = TestChoreGenerator(1);
    late ChoreService choreService;
    setUp(() => choreService = ChoreService());

    test('getChoresByFamily', () async {
      final result = await choreService.getChoresByFamily(1);
      debugPrint("Result: $result");
    });

    test('insertChore', () async {
      final input = testData.get(0);
      debugPrint("Input: $input");
      final result = await choreService.insertChore(testData.familyId, input);
      debugPrint("Result: $result");
      await choreService.deleteChore(result);
    });
  });

  // TODO: Add similar tests for other services.
}
