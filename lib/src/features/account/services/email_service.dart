import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../utilities/objects/response_object.dart';
import '../../../utilities/services/config_service.dart';

class EmailService {
  Future<ResponseObject> sendMessage(String topic, String message) async {
    String url = ConfigService.url;
    final uri = Uri.parse('$url/contact-us');

    var data = Map<String, dynamic>();
    data['Topic'] = topic;
    data['Message'] = message;

    var body = json.encode(data);

    final response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);

    ResponseObject responseObject =
    ResponseObject(statusCode: response.statusCode, body: response.body);

    return (responseObject);
  }
}