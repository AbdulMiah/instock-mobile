// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'app_module.dart' as _i8;
import 'src/features/authentication/services/authentication_service.dart'
    as _i3;
import 'src/features/authentication/services/interfaces/Iauthentication_service.dart'
    as _i7;
import 'src/features/inventory/services/inventory_service.dart' as _i6;
import 'src/utilities/services/interfaces/Isecure_storage_service.dart' as _i4;
import 'src/utilities/services/secure_storage_service.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  await gh.factoryAsync<_i3.AuthenticationService>(
    () => appModule.authenticationService,
    preResolve: true,
  );
  gh.factory<_i4.ISecureStorageService>(() => _i5.SecureStorageService());
  gh.factory<_i6.InventoryService>(
      () => _i6.InventoryService(get<_i7.IAuthenticationService>()));
  await gh.factoryAsync<_i5.SecureStorageService>(
    () => appModule.secureStorageService,
    preResolve: true,
  );
  return get;
}

class _$AppModule extends _i8.AppModule {}
