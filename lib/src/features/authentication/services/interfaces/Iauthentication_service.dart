import '../../../../utilities/objects/response_object.dart';
import '../../data/sign_up_dto.dart';

class IAuthenticationService {
  Future<ResponseObject> authenticateUser(String email, String password) {
    return Future<ResponseObject>.value();
  }

  Future<ResponseObject> createUserAndAuthenticate(SignUpDto userDetails) {
    return Future<ResponseObject>.value();
  }

  Future<ResponseObject> _saveBearerToken(String bearerToken) {
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
