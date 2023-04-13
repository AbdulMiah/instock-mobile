class ErrorNotification {
  final Map<String, dynamic> errors;
  final bool hasErrors;

  ErrorNotification({
    required this.errors,
    required this.hasErrors,
  });

  factory ErrorNotification.fromJson(Map<String, dynamic> json) {
    return ErrorNotification(
      errors: json['errors'],
      hasErrors: json['hasErrors'],
    );
  }
}
