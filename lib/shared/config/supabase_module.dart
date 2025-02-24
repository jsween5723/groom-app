import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@module
abstract class SupabaseModule {
  @preResolve
  Future<SupabaseClient> supabaseClient(LocalStorage localStorage) async {
    final supabase = await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_KEY'),
      authOptions: FlutterAuthClientOptions(localStorage: localStorage),
    );
    return supabase.client;
  }
}

@Singleton(as: LocalStorage)
class SecurityTokenStorage extends LocalStorage {
  final _storage = const FlutterSecureStorage();
  final _sessionKey = "session";
  String _refreshToken = "";
  String _accessToken = "";
  @override
  Future<String?> accessToken() async {
    return _accessToken;
  }

  @override
  Future<bool> hasAccessToken() async {
    return _accessToken.isEmpty;
  }

  Future<String?> refreshToken() async {
    return _refreshToken;
  }

  Future<bool> hasRefreshToken() async {
    return _refreshToken.isEmpty;
  }

  @override
  Future<void> initialize() async {
    final sessionString = await _storage.read(key: _sessionKey);
    if (sessionString != null) {
      final data = jsonDecode(sessionString);
      _accessToken = data['access_token'];
      _refreshToken = data['refresh_token'];
    }
  }

  @override
  Future<void> persistSession(String persistSessionString) async {
    final data = jsonDecode(persistSessionString);
    _accessToken = data['access_token'];
    _refreshToken = data['refresh_token'];
    return await _storage.write(key: _sessionKey, value: persistSessionString);
  }

  @override
  Future<void> removePersistedSession() async {
    _storage.delete(key: _sessionKey);
    _accessToken = "";
    _refreshToken = "";
  }
}
