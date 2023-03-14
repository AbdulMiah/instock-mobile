class ResponseObject {
  int statusCode;

  String message;

  ResponseObject(this.statusCode, this.message);

  @override
  String toString() {
    return 'ResponseObject{statusCode: $statusCode, message: $message}';
  }
}
