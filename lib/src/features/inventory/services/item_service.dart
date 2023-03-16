import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../utilities/objects/response_object.dart';
import '../../../utilities/services/config_service.dart';
import '../../authentication/services/interfaces/Iauthentication_service.dart';

@injectable
class ItemService {
  final IAuthenticationService _authenticationService;

  ItemService(this._authenticationService);

  Future<ResponseObject> updateItem() async {
    var tokenDict = await _authenticationService.retrieveBearerToken();
    var token = tokenDict["bearerToken"];
    Map<String, dynamic> payload = Jwt.parseJwt(token);

    String businessId = payload["BusinessId"];

    String url = ConfigService.url;

    var data = Map<String, dynamic>();
    data['Email'] = email;
    data['Password'] = password;
    var body = json.encode(data);

    var uri = Uri.http(url, '/items', body);

    final response = await http.post(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    }, body: {});

    ResponseObject responseObject = ResponseObject(response.statusCode, "test");
    // create response object
    return responseObject;
  }
}
