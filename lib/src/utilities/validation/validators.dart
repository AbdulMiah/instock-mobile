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
    } else
      return null;
  }

  static String? notBlank(value) {
    //Stripping white space, just spaces won't be allowed
    String valueStripped = value.replaceAll(' ', '');
    if (value == "" || value == " ") {
      return "This field is required";
    } else
      return null;
  }

  static String? shortLength(value) {
    int maxLength = 30;

    ValidatorUtilities utilities = ValidatorUtilities();
    String? result = utilities.maxLength(value, maxLength);

    return result;
  }
}