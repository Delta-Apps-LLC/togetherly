import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/utilities/env.dart';

Future<void> setUpManualServiceTest() async {
  SharedPreferences.setMockInitialValues({});
  // In automated unit tests, this would be TestWidgetsFlutterBinding.
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
}
