import '../../../../utilities/objects/response_object.dart';
import '../../data/sign_up_dto.dart';

abstract class IAuthenticationService {
  Future<ResponseObject> authenticateUser(String email, String password);

  Future<ResponseObject> createUserAndAuthenticate(SignUpDTO userDetails);

  Future<ResponseObject> _saveBearerToken(String bearerToken);

  Future<Map> retrieveBearerToken();
}
