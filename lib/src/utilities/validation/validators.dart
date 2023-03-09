import 'package:email_validator/email_validator.dart';

import 'validator_utilities.dart';

class Validators {
  static validatePassword(String value) {
    int maxLength = 20;

    ValidatorUtilities utilities = ValidatorUtilities();
    String? result = utilities.maxLength(value, maxLength);

    return result;
  }

  static String? isEmail(value) {
    bool isValid = EmailValidator.validate(value);
    if (isValid) {
      return null;
    }
    return "Invalid Email Format";
  }

  static String? notNull(value) {
    if (value == null) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? notBlank(value) {
    //Stripping white space, just spaces won't be allowed
    String valueStripped = value.replaceAll(' ', '');
    if (valueStripped == "" || valueStripped == " ") {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? shortLength(value) {
    int maxLength = 30;

    ValidatorUtilities utilities = ValidatorUtilities();
    String? result = utilities.maxLength(value, maxLength);

    return result;
  }

  static String? noSpecialChars(value) {
    const pattern = r'^[a-zA-Z0-9]+(\s+[a-zA-Z0-9]+)*$';
    final regexp = RegExp(pattern, caseSensitive: false);
    if (!regexp.hasMatch(value)) {
      return "No special characters";
    }

    return null;
  }

  static String? longLength(value) {
    int maxLength = 180;

    ValidatorUtilities utilities = ValidatorUtilities();
    String? result = utilities.maxLength(value, maxLength);

    return result;
  }
}
