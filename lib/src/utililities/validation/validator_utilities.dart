class ValidatorUtilities {
  maxLength(String value, int maxLength) {
    if (value.length >= maxLength) {
      return "Cannot be longer than ${maxLength} characters";
    }
    return null;
  }

  minLength(var value, int minLength) {
    if (value.length <= minLength) {
      return "Cannot be shorter than ${minLength} characters";
    }
    return null;
  }
}
