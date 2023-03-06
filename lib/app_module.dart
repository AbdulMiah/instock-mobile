import 'package:injectable/injectable.dart';
import 'package:instock_mobile/src/features/authentication/services/authentication_service.dart';
import 'package:instock_mobile/src/utilities/services/secure_storage_service.dart';

@module
abstract class AppModule {
  @preResolve
  Future<AuthenticationService> get authenticationService =>
      AuthenticationService.init();

  // @injectable
  // AuthenticationService get authentication => AuthenticationService.instance;

  @preResolve
  Future<SecureStorageService> get secureStorageService =>
      SecureStorageService.init();
//
// @injectable
// SecureStorageService get secureStorage => SecureStorageService.instance;
}
