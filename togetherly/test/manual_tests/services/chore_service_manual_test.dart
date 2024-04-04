import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:togetherly/utilities/env.dart';

void main() {
  late ChoreService choreService;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    // In automated unit tests, this would be TestWidgetsFlutterBinding.
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: 'https://ejsdquitvcfduhsrdwvx.supabase.co',
      anonKey: Env.supabaseAnonKey,
    );
  });

  setUp(() {
    choreService = ChoreService(Supabase.instance.client);
  });

  test('Get chores by family', () async {
    final result = await choreService.getChoresByFamily(1);
    print(result);
  });
}
