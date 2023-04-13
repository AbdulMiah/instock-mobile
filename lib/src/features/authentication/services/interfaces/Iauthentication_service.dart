import 'package:instock_mobile/src/features/authentication/data/login_dto.dart';

import '../../../../utilities/objects/response_object.dart';
import '../../data/sign_up_dto.dart';

class IAuthenticationService {
  Future<ResponseObject> authenticateUser(LoginDto loginDto) {
    return Future<ResponseObject>.value();
  }

  Future<ResponseObject> createUserAndAuthenticate(SignUpDto userDetails) {
    return Future<ResponseObject>.value();
  }

  Future<ResponseObject> saveBearerToken(String bearerToken) async {
    return Future<ResponseObject>.value();
  }

  Future<ResponseObject> _saveFcmToken(String fcmToken) {
    return Future<ResponseObject>.value();
  }

  Future<Map> retrieveBearerToken() {
    return Future<Map>.value();
  }

  Future<Map> retrieveFcmToken() {
    return Future<Map>.value();
  }

  Future<ResponseObject> logOut() async {
    return Future<ResponseObject>.value();
  }
}
