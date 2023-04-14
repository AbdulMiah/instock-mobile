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

  String? getFirstErrorMessage() {
    print("Error Notification");
    // If errors is not null and errors is not empty then
    // continue (it should never be empty if not null)
    if (errors != null && errors.isNotEmpty) {
      // Go through errors
      for (String errorKey in errors.keys) {
        List<dynamic> errorValues = errors[errorKey];
        print("Get first error message");
        print(errorValues);
        // if the errorValues is not empty and the first value is a string
        if (errorValues.isNotEmpty && errorValues[0] is String) {
          // return it
          return errorValues[0];
        }
      }
    }
    return null;
  }
}
