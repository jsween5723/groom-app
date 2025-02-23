import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class SupabaseModule {
  @preResolve
  Future<SupabaseClient> get supabaseClient async {
    final supabase = await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_KEY'),
      authOptions: FlutterAuthClientOptions(
        pkceAsyncStorage: SecurityTokenStorage(),
      ),
      storageOptions: StorageClientOptions(retryAttempts: 10),
    );
    return supabase.client;
  }
}

class SecurityTokenStorage extends GotrueAsyncStorage {
  final storage = FlutterSecureStorage();
  @override
  Future<String?> getItem({required String key}) async {
    return await storage.read(key: key);
  }

  @override
  Future<void> removeItem({required String key}) async {
    return await storage.delete(key: key);
  }

  @override
  Future<void> setItem({required String key, required String value}) async {
    return await storage.write(key: key, value: value);
  }
}
