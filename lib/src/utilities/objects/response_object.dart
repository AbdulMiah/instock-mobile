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
}
