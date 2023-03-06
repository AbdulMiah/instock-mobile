// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart'
    as _i7;
import 'package:instock_mobile/src/features/authentication/services/interfaces/Iauthentication_service.dart'
    as _i6;
import 'package:instock_mobile/src/features/inventory/services/inventory_service.dart'
    as _i5;
import 'package:instock_mobile/src/utilities/services/interfaces/Isecure_storage_service.dart'
    as _i3;
import 'package:instock_mobile/src/utilities/services/secure_storage_service.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.ISecureStorageService>(() => _i4.SecureStorageService());
    gh.factory<_i5.InventoryService>(() => _i5.InventoryService());
    gh.factory<_i6.IAuthenticationService>(
        () => _i7.AuthenticationService(gh<_i3.ISecureStorageService>()));
    return this;
  }
}
