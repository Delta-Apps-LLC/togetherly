import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:togetherly/utilities/env.dart';

import 'setup.dart';

void main() {
  late ChoreService choreService;

  setUpAll(setUpManualServiceTest);

  setUp(() {
    choreService = ChoreService();
  });

  test('Get chores by family', () async {
    final result = await choreService.getChoresByFamily(1);
    print(result);
  });
}
