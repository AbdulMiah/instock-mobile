import 'package:email_validator/email_validator.dart';

import 'validator_utilities.dart';

class Validators {
  static String? validatePassword(value) {
    final RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,32}$');
    bool meetsPasswordCrtiera = regex.hasMatch(value);
    if (meetsPasswordCrtiera) {
      return null;
    } else {
      return "Password must contain one capital letter, number and special character and have 8-32 characters";
    }
  }

  static String? isEmail(value) {
    // Tried replacing with this very long regex but kept facing different errors
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

  static String? noNumbers(value) {
    final RegExp regex = RegExp(r'\d+');
    bool hasNumbers = regex.hasMatch(value);
    if (hasNumbers) {
      return "Can't have numbers";
    } else {
      return null;
    }
  }

  static String? nameValidation(value) {
    RegExp regex = RegExp(r"[^\w\s\'\-.]");
    bool hasSpecialCharacters = regex.hasMatch(value);
    if (hasSpecialCharacters) {
      return "Can't have special characters except hyphens, apostrophes and points";
    } else {
      return null;
    }
  }
}
