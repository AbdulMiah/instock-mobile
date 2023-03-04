import 'package:email_validator/email_validator.dart';

import 'validator_utilities.dart';

class Validators {
  static validatePassword(String value) {
    int maxLength = 30;
    //set min lenth
    //set regex

    ValidatorUtilities utilities = ValidatorUtilities();
    String? result = utilities.maxLength(value, maxLength);

    return result;
  }

  static String? isEmail(value) {
    // Could replace with very long regex?
    // (?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])
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
    // Suggested max length for a name
    int maxLength = 50;

    ValidatorUtilities utilities = ValidatorUtilities();
    String? result = utilities.maxLength(value, maxLength);

    return result;
  }

  static String? noSpecialCharacters(value) {
    final nameRegExp = RegExp('^[0-9]*$');
    //clean for special charactrs
    bool hasNoSpecialCharacters = nameRegExp.hasMatch(value);
    if (hasNoSpecialCharacters) {
      return null;
    } else {
      return "Can't have numbers and special characters";
    }
  }

//  make validation for numbers
}
