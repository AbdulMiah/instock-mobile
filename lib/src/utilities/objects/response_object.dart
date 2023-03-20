class ResponseObject {
  int? statusCode;
  String? body;
  List<String>? errors;
  bool? requestSuccess;

  ResponseObject({
    this.statusCode,
    this.body,
    this.errors,
    this.requestSuccess,
  });

  @override
  String toString() {
    return 'ResponseObject{statusCode: $statusCode, body: $body, errors: $errors, RequestSuccess: $requestSuccess}';
  }

  hasErrors() {
    if (errors != null || errors!.isNotEmpty) {
      return true;
    }
    return false;
  }

  static List<String> extractErrorsFromResponse(
      Map<String, dynamic> dictionary) {
    List<String> errorMessages = [];
    if (dictionary.containsKey('errors')) {
      Map<String, dynamic> errors = dictionary['errors'];
      errors.forEach((key, value) {
        if (value is List) {
          value.forEach((element) {
            if (element is String) {
              errorMessages.add(element);
            }
          });
        }
      });
    }
    return errorMessages;
  }
}
