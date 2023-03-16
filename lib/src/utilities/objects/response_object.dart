class ResponseObject {
  int statusCode;

  String body;

  List<String>? errors;

  ResponseObject(this.statusCode, this.body, [this.errors]);

  @override
  String toString() {
    return 'ResponseObject{statusCode: $statusCode, body: $body, errors: $errors}';
  }
}
