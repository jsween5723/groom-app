// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import 'supabase_module.dart' as _i695;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final supabaseModule = _$SupabaseModule();
    gh.singleton<_i454.LocalStorage>(() => _i695.SecurityTokenStorage());
    await gh.factoryAsync<_i454.SupabaseClient>(
      () => supabaseModule.supabaseClient(gh<_i454.LocalStorage>()),
      preResolve: true,
    );
    return this;
  }
}

class _$SupabaseModule extends _i695.SupabaseModule {}
