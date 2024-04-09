import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(useConstantCase: true)
abstract class Env {
  @EnviedField(obfuscate: true)
  static final String supabaseUrl = _Env.supabaseUrl;

  @EnviedField(obfuscate: true)
  static final String supabaseAnonKey = _Env.supabaseAnonKey;
}
